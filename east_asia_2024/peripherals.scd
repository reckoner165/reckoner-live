load("/Users/sumanth/Library/Application Support/SuperCollider/synthdefs/mi-ugens.scd");

// define global effects for mutable instruments effects

~dirt.orbits.do { |x|
            var clouds = GlobalDirtEffect(\global_mi_clouds, [\cloudspitch, \cloudspos, \cloudssize, \cloudsdens, \cloudstex, \cloudswet, \cloudsgain, \cloudsspread, \cloudsrvb, \cloudsfb, \cloudsfreeze, \cloudsmode, \cloudslofi]);
            var verb = GlobalDirtEffect(\global_mi_verb, [\verbwet, \verbtime, \verbdamp, \verbhp, \verbfreeze, \verbdiff, \verbgain]);
            x.globalEffects = x.globalEffects
              .addFirst(clouds)
              .addFirst(verb);
            x.initNodeTree;
 };

//

~looper = TidalLooper(~dirt);

// VOCAL BYPASS

SynthDef(\input, {
    | out, sustain=1, freq=440, speed=1, begin=0, end=1, pan, accelerate, offset, volume|
	var env    = EnvGen.ar(Env.linen(0, sustain, 0), doneAction: Done.freeSelf);
	var osc    = PitchShift.ar(SoundIn.ar(0), pitchRatio: speed);
    OffsetOut.ar(out, DirtPan.ar(osc, ~dirt.numChannels, pan, env));
}).add;

