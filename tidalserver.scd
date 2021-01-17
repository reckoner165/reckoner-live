SuperDirt.start
SuperDirt.start(path:"/Users/Srinivasan/Music/AlgoraveStuff")
SuperDirt.stop

s.record
s.stopRecording
Quarks.gui

Server.killAll;


Platform.userExtensionDir

File.mkdir(Platform.userExtensionDir)

ServerOptions.outDevices

ServerOptions.inDevices

Server.default.options.outDevice_("Multi-Output Device");

// Send to Mixer
Server.default.options.outDevice_("USB Audio CODEC");


Server.default.options.inDevice_("Built-in Microph");

Server.default.options.outDevice


s.options.numOutputBusChannels = 12;


(
var functions = ();  // make a dictionary of functions
var recSynth, recBufs, counter = 0, recording = false;
var whichOrbit = ~dirt.orbits[0];
var maxTime = 48; // allow a maximum of four seconds, adjust to your needs
var lat = s.latency + 0.02; // finetune
var numBuffers = 8; // number of buffers
var bufnamePrefix = "fooloop"; // soundname prefix
var soundIn = Array.with(0);

~recBufs.do(_.free); // free them if they are left over (this is why we keep it in the environment variable)
~recBufs = recBufs = { Buffer.alloc(~dirt.server, ~dirt.server.sampleRate * maxTime, soundIn.size) } ! numBuffers;

// recorder writes audio from SoundIn to a bufnum
SynthDef(\fooRecord, { |bufnum|
    var in = SoundIn.ar(soundIn) * EnvGen.ar(Env.linen(0.003, 23, 0.003, 1, \sine), doneAction: 0);
    RecordBuf.ar(in, bufnum, loop:0, doneAction:2);
}).add;

// start recording round robin to buffers
functions[\fooloopRec] = {
    if(recording) { functions[\fooloopAdd].value };
	counter = counter + 1;
    if(counter > recBufs.lastIndex, {counter = 0});
    ~server.makeBundle(lat, {
    recSynth = Synth(\fooRecord, [bufnum: (recBufs @ counter)], ~server);
    recording = true;
    })
};

// add new buffer and free synth
functions[\fooloopAdd] = {
    var name = bufnamePrefix ++ counter.asString;
    if(recording) {
    ~server.makeBundle(lat, {
    ~dirt.soundLibrary.addBuffer(name, (recBufs @@ counter), false );
    recSynth.free;
    recording = false;
    })
    }
};
// reset all buffers
functions[\fooloopReset] = {
    "reset".postln;
    ~recBufs.do(_.free);
    ~recBufs = recBufs = { Buffer.alloc(~dirt.server, ~dirt.server.sampleRate * maxTime, soundIn.size) } ! numBuffers;
    for(0,numBuffers-1, { |i|  ~dirt.soundLibrary.addBuffer(bufnamePrefix++i, (recBufs @@ i), false )});
    counter = 0;
    recording = false;
};

// add these functions to the dirt soundLibrary
functions.keysValuesDo{ |key, func|  ~dirt.soundLibrary.addSynth( key, (play: func)) };

)

SuperDirt.stop

SuperDirt.start

~dirt.loadSoundFiles("/Users/Srinivasan/Music/Samples/Burial/*");

~dirt.loadSoundFiles("/Users/Srinivasan/Music/LIVE/samples/*");

~dirt.loadSoundFiles("/Users/Srinivasan/Music/Samples/TS-UndergroundVinylVol1/");

~dirt.loadSoundFiles("/Users/Srinivasan/Music/Samples/2020/*");


s.record
s.stopRecording
