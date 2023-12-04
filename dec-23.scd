s.options.memSize = 65536*2;
Server.default.options.outDevice_("Scarlett 2i4 USB")
Server.default.options.inDevice_("Scarlett 2i4 USB")


Server.default.options.outDevice


SuperDirt.start
SuperDirt.stop


s.record
s.stopRecording



MIDIClient.init;

~microkorg = MIDIOut.newByName("UM-ONE", "UM-ONE");
~dirt.soundLibrary.addMIDI(\microkorg, ~microkorg);
~microkorg.latency = 0



~dirt.loadSoundFiles("/Users/Srinivasan/Music/samples/*");
~dirt.loadSoundFiles("/Users/Srinivasan/Music/samples/eu_tour_samples/*");
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



"/Users/Srinivasan/Music/reckoner-live/synthdefs1.scd".load()
