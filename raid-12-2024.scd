s.options.memSize = 65536;
Server.default.options.outDevice_("Scarlett 2i4 USB")
Server.default.options.inDevice_("Scarlett 2i4 USB")


Server.default.options.outDevice_("EarPods")


SuperDirt.start

~dirt.loadSoundFiles("/Users/sumanth/Music/samples/*");

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

load("/Users/sumanth/Music/reckoner-live/sidechain.scd")

MIDIClient.init;
~pro800 = MIDIOut.newByName("PRO 800", "PRO 800");
~dirt.soundLibrary.addMIDI(\pro800, ~pro800);
~pro800.latency = 0

~ableton = MIDIOut.newByName("IAC Driver", "Bus 1");
~dirt.soundLibrary.addMIDI(\ableton, ~ableton);
~ableton.latency = 0

s.record
s.stopRecording