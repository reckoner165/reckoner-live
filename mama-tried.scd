s.options.memSize = 65536;
Server.default.options.outDevice_("Scarlett 2i4 USB")
Server.default.options.inDevice_("Scarlett 2i4 USB")




// Server.default.options.outDevice_("HDMI")



Server.default.options.outDevice


SuperDirt.start
SuperDirt.stop


s.record
s.stopRecording


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


MIDIClient.init;
~blofeld = MIDIOut.newByName("Blofeld", "");
~dirt.soundLibrary.addMIDI(\blofeld, ~blofeld);
~blofeld.latency = 0



// Evaluate the block below to start the mapping MIDI -> OSC.
(
var playbackControl, osc;

osc = NetAddr.new("127.0.0.1", 6010);

MIDIClient.init;
MIDIIn.connectAll;

playbackControl = MIDIFunc.cc({ |val, num, chan, src|
if ((chan == 9) && (num >= 20) && (num <= 23), {
if (val == 0, {
osc.sendMsg("/mute", num - 19);
}, {
osc.sendMsg("/unmute", num - 19);
});
});
});

if (~stopMidiMuteControl != nil, {
    ~stopMidiMuteControl.value;
});

~stopMidiMuteControl = {
    playbackControl.free;
};
)

// Evaluate the line below to stop it.
~stopMidiMuteControl.value;
