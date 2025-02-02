s.options.memSize = 65536;
Server.default.options.outDevice_("Scarlett 2i4 USB")
Server.default.options.inDevice_("Scarlett 2i4 USB")

Server.default.options.outDevice_("EarPods")


ServerOptions.inDevices

SuperDirt.start

~dirt.loadSoundFiles("/Users/sumanth/Music/samples/*");

// "/Users/sumanth/Music/reckoner-live/east_asia_2024/peripherals.scd".load()

load("/Users/sumanth/Library/Application Support/SuperCollider/synthdefs/mi-ugens.scd");

load("/Users/sumanth/Music/reckoner-live/synthdefs1.scd")

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
~looper.persistPath = "/Users/sumanth/Music/Loops/"

load("/Users/sumanth/Music/reckoner-live/loop_buffer_viz.scd")

load("/Users/sumanth/Music/reckoner-live/sidechain.scd")

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

PathName(~looper.persistPath).entries.do(_.postln);

~looper.dump;

// Manually create a buffer and save it
b = Buffer.alloc(s, 44100, 1);  // Allocating a buffer with 1 channel and 44100 samples
b.write("/Users/sumanth/Music/Loops/loop_0.wav", "wav", "int16");  // Save to the specified location

~looper.persistPath = "/Users/sumanth/Music/Loops/".standardizePath;

b = ~looper.numBuffers[0];  // Access the first buffer

b.write("/Users/sumanth/Music/Loops/loop_0.wav", "wav", "int16");  // Explicitly write the buffer

~dirt.soundLibrary.buffers[0]


~dirt.soundLibrary.buffers.keys.do(_.postln);

(
~dirt.soundLibrary.buffers.keys
  .select { |key| key.asString.contains("loop") } // or any condition you need
  .do { |key| ("Buffer for " + key).postln;}
)

(
~dirt.soundLibrary.buffers.values
  .select { |buffer| buffer.path.contains("loop") }
  .do { |buffer|
    ("Buffer path: " + buffer.path).postln;
  }
)

~dirt.soundLibrary.buffers