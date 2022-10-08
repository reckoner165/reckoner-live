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
Server.default.options.inDevice_("Scarlett 2i4 USB")
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

{ SoundIn.ar([0, 0]) }.play;
{ SoundIn.ar([1, 1]) }.play;
