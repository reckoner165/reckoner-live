(
// Define initialization function
~initSynthsAndEffects
= {
    // Load SynthDefs
	"Loading synthdefs1.scd...".postln;
    load("/Users/sumanth/Music/reckoner-live/sc/synthdefs1.scd");

	"Loading sidechain.scd...".postln;
    load("/Users/sumanth/Music/reckoner-live/sc/sidechain.scd");

	"Loading mi-ugens.scd...".postln;

    load("/Users/sumanth/Library/Application Support/SuperCollider/synthdefs/mi-ugens.scd");

    // Define global effects
	"Setting up global effects for each orbit...".postln;
    ~dirt.orbits.do { |x|
        var clouds = GlobalDirtEffect(\global_mi_clouds, [
            \cloudspitch, \cloudspos, \cloudssize, \cloudsdens,
            \cloudstex, \cloudswet, \cloudsgain, \cloudsspread,
            \cloudsrvb, \cloudsfb, \cloudsfreeze, \cloudsmode, \cloudslofi
        ]);
        var verb = GlobalDirtEffect(\global_mi_verb, [
            \verbwet, \verbtime, \verbdamp, \verbhp,
            \verbfreeze, \verbdiff, \verbgain
        ]);
        var resonator = GlobalDirtEffect(\resonatorFX, [
            \freq, \decay, \mix, \gain
        ]);

        x.globalEffects = x.globalEffects
            .addFirst(clouds)
            .addFirst(verb);
        x.initNodeTree;
    };
};

// Run immediately
~initSynthsAndEffects.();
)
