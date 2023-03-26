Server.default.options.inDevice_("Scarlett2i4 USB")


SuperDirt.start
SuperDirt.stop

s.record
s.stopRecording



~dirt.loadSoundFiles("/Users/Srinivasan/Music/samples/*");



MIDIClient.init;


// TEMP JAM
~blofeld = MIDIOut.newByName("Blofeld", "");
~dirt.soundLibrary.addMIDI(\blofeld, ~blofeld);

~blofeld.latency = 0

~microkorg.latency = -0.65;


~looper = TidalLooper(~dirt);
// ~dirt.start
//
// { SoundIn.ar([0, 0]) }.play;


// VOCAL BYPASS
(
SynthDef(\input, {
    | out, sustain=1, freq=440, speed=1, begin=0, end=1, pan, accelerate, offset, volume|
	var env    = EnvGen.ar(Env.linen(0, sustain, 0), doneAction: Done.freeSelf);
	var osc    = PitchShift.ar(SoundIn.ar(0), pitchRatio: speed);
    OffsetOut.ar(out, DirtPan.ar(osc, ~dirt.numChannels, pan, env));
}).add;
)




