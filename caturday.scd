s.options.memSize = 65536;
Server.default.options.outDevice_("Scarlett 2i4 USB")
Server.default.options.inDevice_("Scarlett 2i4 USB")




// Server.default.options.outDevice_("HDMI")



Server.default.options.outDevice


SuperDirt.start
SuperDirt.stop


s.record
s.stopRecording


MIDIClient.init;



~minitaur = MIDIOut.newByName("Moog Minitaur", "Moog Minitaur");
~dirt.soundLibrary.addMIDI(\minitaur, ~minitaur);
~minitaur.latency = 0.03



~dirt.loadSoundFiles("/Users/Srinivasan/Music/samples/*");


"/Users/Srinivasan/Music/reckoner-live/synthdefs1.scd".load()
