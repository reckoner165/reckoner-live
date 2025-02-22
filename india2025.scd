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



s.record
s.stopRecording



