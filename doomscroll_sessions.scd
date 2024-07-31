s.options.memSize = 65536;
Server.default.options.outDevice_("Scarlett 2i4 USB")

// Server.default.options.outDevice_("USB Audio CODEC")
Server.default.options.inDevice_("Scarlett 2i4 USB")


// ServerOptions.inDevices

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

// VOCAL BYPASS
(
SynthDef(\input, {
    | out, sustain=1, freq=440, speed=1, begin=0, end=1, pan, accelerate, offset, volume|
	var env    = EnvGen.ar(Env.linen(0, sustain, 0), doneAction: Done.freeSelf);
	var osc    = PitchShift.ar(SoundIn.ar(0), pitchRatio: speed);
    OffsetOut.ar(out, DirtPan.ar(osc, ~dirt.numChannels, pan, env));
}).add;
)


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
