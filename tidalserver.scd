Server.killAll;
ServerOptions.outDevices
ServerOptions.inDevices

s.options.numInputBusChannels = 4

// Legacy
Server.default.options.outDevice_("Multi-Output Device");
Server.default.options.outDevice_("Soundflower (2ch)");

// Send to Mixer
Server.default.options.outDevice_("USB Audio CODEC");
// Send to headphones
Server.default.options.outDevice_("Built-in Output");

Server.default.options.inDevice_("USB Audio CODEC");


// Send to Focusrite
Server.default.options.inDevice_("Scarlett2i4 USB")
Server.default.options.outDevice_("Scarlett 2i4 USB")


// WONDERVILLE - CORTLAND's MIXER
Server.default.options.inDevice_("ZEDi10")
Server.default.options.outDevice_("ZEDi10")



// HDMI
Server.default.options.outDevice_("HDMI")


Server.default.options.inDevice_("Built-in Microph");

Server.default.options.outDevice

s.options.numOutputBusChannels = 12;

SuperDirt.start
SuperDirt.stop

s.record
s.stopRecording



~dirt.loadSoundFiles("/Users/Srinivasan/Music/samples/*");

//
// dirt.loadSoundFiles("/Users/Srinivasan/Music/Samples/TS-UndergroundVinylVol1/");
//
// ~dirt.loadSoundFiles("/Users/Srinivasan/Music/Samples/2020/*");
//
// ~dirt.loadSoundFiles("/Users/Srinivasan/Music/Samples/Burial/*");
//




// MIDI STUFF

MIDIClient.init;

~microkorg = MIDIOut.newByName("UM-ONE", "UM-ONE");
~blofeld = MIDIOut.newByName("Blofeld", "");
~dirt.soundLibrary.addMIDI(\microkorg, ~microkorg);
~dirt.soundLibrary.addMIDI(\blofeld, ~blofeld);


// TEMP JAM
~blofeld = MIDIOut.newByName("UM-ONE", "UM-ONE");
~dirt.soundLibrary.addMIDI(\blofeld, ~blofeld);

~blofeld.latency = 0

~microkorg.latency = -0.65;



OSCFunc.trace(false, true)






// print just play2 messages
OSCFunc.new({|msg, time, addr, recvport| msg.postln},'/play2')





Quarks.install("https://github.com/thgrund/tidal-looper.git")

s.start
// ~dirt = SuperDirt(2, s);
~looper = TidalLooper(~dirt);
~dirt.start
//
{ SoundIn.ar([0, 0]) }.play;
{ SoundIn.ar([1, 1]) }.play;

// VOCAL BYPASS
(
SynthDef(\input, {
    | out, sustain=1, freq=440, speed=1, begin=0, end=1, pan, accelerate, offset, volume|
	var env    = EnvGen.ar(Env.linen(0, sustain, 0), doneAction: Done.freeSelf);
	var osc    = PitchShift.ar(SoundIn.ar(0), pitchRatio: speed);
    OffsetOut.ar(out, DirtPan.ar(osc, ~dirt.numChannels, pan, env));
}).add;
)







// MULTI-CHANNEL EXPERIMENTS
s.options.memSize = 65536;
s.options.numOutputBusChannels = 2;
// Server.default.options.outDevice_("Soundflower (64ch)");
Server.default.options.outDevice_("Built-in Output");

~dirt = SuperDirt(1, s); // two output channels, increase if you want to pan across more channels
~dirt.start(57120, (4..16));

~dirt.loadSoundFiles("/Users/Srinivasan/Music/samples/*");


SuperDirt.start

Quarks.install("https://github.com/florian-grond/SC-HOA")

Platform.userExtensionDir
s.options.outDevice_


// try different orders up to 5 and watch the scope window.
HOADecLebedev50.loadHrirFilters(s);


~order = 1;
// s.scope((~order+1).pow(2));
(
{
	HOADecLebedev50.ar(~order,
		HOAEncoder.ar(~order, SoundIn.ar(0)), hrir_Filters: 1  )
}.play
)
