s.options.memSize = 65536;
Server.default.options.outDevice_("Scarlett 2i4 USB")
Server.default.options.inDevice_("Scarlett 2i4 USB")

Server.default.options.outDevice_("EarPods")


ServerOptions.inDevices

SuperDirt.start

~dirt.loadSoundFiles("/Users/sumanth/Music/samples/*");


load("/Users/sumanth/Music/reckoner-live/synthdefs1.scd")


load("/Users/sumanth/Music/reckoner-live/sidechain.scd")

load("/Users/sumanth/Library/Application Support/SuperCollider/synthdefs/mi-ugens.scd");
// define global effects for mutable instruments effects
(
~dirt.orbits.do { |x|
            var clouds = GlobalDirtEffect(\global_mi_clouds, [\cloudspitch, \cloudspos, \cloudssize, \cloudsdens, \cloudstex, \cloudswet, \cloudsgain, \cloudsspread, \cloudsrvb, \cloudsfb, \cloudsfreeze, \cloudsmode, \cloudslofi]);
            var verb = GlobalDirtEffect(\global_mi_verb, [\verbwet, \verbtime, \verbdamp, \verbhp, \verbfreeze, \verbdiff, \verbgain]);
            x.globalEffects = x.globalEffects
              .addFirst(clouds)
              .addFirst(verb);
            x.initNodeTree;
 };
)

~looper = TidalLooper(~dirt);


// VOCAL CHAIN
(
SynthDef(\input, {
    |out=0, sustain=1, speed=1, pan=0, gain=1.0|

    var env, input, compressed, eq_low, eq_high, final;

    // Envelope for SuperDirt control
    env = EnvGen.ar(Env.linen(0, sustain, 0), doneAction: Done.freeSelf);

    // Get mic input
    input = SoundIn.ar(0);

    // High-pass filter (removes low-end rumble)
    input = HPF.ar(input, 60);

    // Fast Limiter (1176-style compression)
    compressed = Limiter.ar(input, level: 0.7, dur: 0.005);

    // Pultec-style EQ:
    eq_high = BPeakEQ.ar(compressed, 12000, 0.5, db: 4); // Boost air
    eq_low = BPeakEQ.ar(eq_high, 200, 1, db: 2); // Boost warmth

    // Final gain control
    final = eq_low * gain;

    // Output through SuperDirt’s effect routing
    OffsetOut.ar(out, DirtPan.ar(final, ~dirt.numChannels, pan, env));

}).add;
)


~waveformUpdater.stop;



s.record
s.stopRecording



// install this repository
// Quarks.install("https://github.com/geikha/tidal-drum-machines.git");

~drumMachinesDir = Quarks.all.detect({ |x| x.name == "tidal-drum-machines" }).localPath;

~dirt.loadSoundFiles(~drumMachinesDir +/+ "machines" +/+ "*" +/+ "*", namingFunction: { |x| x.basename.replace("-","")})

SuperDirt.default = ~dirt;

(type:\dirt, s: \rolandtr909sd, n: 0).play;


MIDIClient.init;
~ableton = MIDIOut.newByName("IAC Driver", "Bus 1");
~dirt.soundLibrary.addMIDI(\ableton, ~ableton);

~pro800 = MIDIOut.newByName("PRO 800", "PRO 800");
~dirt.soundLibrary.addMIDI(\pro800, ~pro800);
~pro800.latency = 0

~looper.listLoops.postln;


// ROGER THAT
(
SynthDef(\rogerThatFx, { |out, in=0, rogerThatFx=0, mix=0.5, drive=1.0, shift=0, filterFreq=1000, filterQ=1.0, noiseLevel=0.1, tune=440|
    var input, modulated, noisyModulated, demodulated, distorted, wetSignal, output, noise;

    // Get audio from input bus
    input = In.ar(in, 2);  // Stereo input

    // Only process if effect is enabled
    input = Select.ar(rogerThatFx, [input, input * drive]);

    // FM Modulation with positional arguments
    modulated = PMOsc.ar(
        tune + shift,          // Carrier frequency: base pitch + shift (tune knob controls base frequency)
        input.abs * 1000,      // Modulating frequency based on input level
        5,                     // Modulation index (increased for more effect)
        0.5                    // Amplitude (adjust if necessary)
    );

    // Add noise to the modulated signal
    noise = WhiteNoise.ar(0.05);  // Adjust the noise level here
    noisyModulated = modulated + (noise * noiseLevel);  // Mix noise with the modulated signal

    // FM Demodulation approximation
    demodulated = HPF.ar(noisyModulated, 10);

    // Apply distortion
    distorted = tanh(demodulated * 10);  // Increased gain for stronger distortion

    // Bandpass filter to shape the output
    wetSignal = BPF.ar(distorted, filterFreq, filterQ);

    // Mix wet and dry signals
    output = XFade2.ar(input, wetSignal, mix * 2 - 1);  // XFade2 mixes dry/wet signals

    // Output the processed signal
    Out.ar(out, output);
}).add;
)



(
~dirt.addModule('rogerThatFx', { |dirtEvent|
    dirtEvent.sendSynth('rogerThatFx',
        [
            rogerThatFx: ~rogerThatFx,      // Enable or disable the effect
            mix: ~mix,                      // Wet/dry mix (parameter)
            drive: ~drive,                  // Distortion drive (parameter)
            shift: ~shift,                  // FM modulation shift (parameter)
            filterFreq: ~filterFreq,        // Filter frequency (parameter)
            filterQ: ~filterQ,              // Filter resonance (parameter)
			tune: ~tune,                    // Carrier wave frequency (parameter)
            out: ~out                       // Output bus (if necessary)
        ]
    );
}, { ~rogerThatFx.notNil && ~mix.notNil });  // Play effect only if rogerThatFx and mix are defined

~busses = ~dirt.orbits.collect { |x| x.dryBus };
)

