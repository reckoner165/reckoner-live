(
~initAbletonAndPro800 = {|dirt|

	"Initializing MIDI client...".postln;
	MIDIClient.init;

	"Initializing and assigning Pro800...".postln;
	~pro800 = MIDIOut.newByName("PRO 800", "PRO 800");
	dirt.soundLibrary.addMIDI(\pro800, ~pro800);

	"Initializing and assigning Ableton instruments...".postln;
	~ableton = MIDIOut.newByName("IAC Driver", "Bus 1");
	dirt.soundLibrary.addMIDI(\ableton, ~ableton);

	"Setting latency to 0...".postln;
	~pro800.latency = 0;
	~ableton.latency = 0;
};
)