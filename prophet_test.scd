
// Define the synth for SuperDirt, aiming for an ethereal, organ-like sound
(
SynthDef(\radiohead_like, {
    |out, freq = 440, detune = 0.01, amp = 0.3, pan = 0, sustain = 3, release = 2, cutoff = 1000, res = 0.2|

    var osc1, osc2, filter, env, signal, sound;

    // Two detuned sine waves for a smooth, organ-like tone
    osc1 = SinOsc.ar(freq);
    osc2 = SinOsc.ar(freq * (1 + detune));

    // Mixed together with a slight detune
	sound = Mix([osc1, osc2]) * 0.5;

    // Envelope for the amplitude (longer attack and release)
    env = EnvGen.kr(Env.linen(attackTime: 0.1, sustainTime: sustain, releaseTime: release), doneAction: 2);

    // Gentle filtering with a controllable cutoff frequency
    filter = LPF.ar(sound, cutoff);

    // Adding some reverb for space and depth
    signal = FreeVerb.ar(filter * env, mix: 0.4, room: 0.5);

    // Pan and output
    Out.ar(out, DirtPan.ar(sound, ~dirt.numChannels, pan, env));
}).add;
)


(
SynthDef(\radiohead_pad, {
    |out = 0, freq = 440, detune = 0.005, amp = 0.4, pan = 0, sustain = 3, release = 2, cutoff = 1000, res = 0.5|

    var osc1, osc2, sound, env, filter, lfo, reverb;

    // Two slightly detuned sine waves for a smooth, organ-like tone
    osc1 = SinOsc.ar(freq);
    osc2 = SinOsc.ar(freq * (1 + detune));

    // Mix oscillators
    sound = Mix([osc1, osc2]) * 0.5;

    // LFO for subtle modulation on the cutoff frequency
    lfo = SinOsc.kr(0.2).range(50, 300); // Low frequency oscillator for modulation
    filter = RLPF.ar(sound, lfo + cutoff, res); // Apply modulation to filter cutoff

    // Envelope for the amplitude (longer attack and release)
    env = EnvGen.kr(Env.linen(0.1, sustain, release), doneAction: 2);

    // Adding some reverb for space and depth
    reverb = FreeVerb.ar(filter * env, mix: 0.5, room: 0.8);

    // Pan and output
    Out.ar(out, Pan2.ar(reverb, pan));
}).add;
)

(
~dirt.soundLibrary.addSynth(\radiohead_pad);
)

(
~dirt.soundLibrary.addSynth(\radiohead_like);
)


(
Synth(\radiohead_pad, [\freq, 659.25, \sustain, 1]); // E5
Synth(\radiohead_pad, [\freq, 739.99, \sustain, 1]); // F#5
Synth(\radiohead_pad, [\freq, 830.61, \sustain, 1]); // G#5
)





(
SynthDef(\supercollider_pad, {
    |out, freq = 440, amp = 0.3, pan = 0, sustain = 5, release = 4, cutoff = 7000, res = 0.4|

    var osc1, osc2, env, lfo, filter, signal, sound;

    // Create a slightly detuned sawtooth oscillator for a rich texture
    osc1 = Saw.ar(freq);
    osc2 = Saw.ar(freq * 1.01); // Slightly detuned

    // Mix the oscillators
    sound = Mix([osc1, osc2]) * 0.5;

    // Low-frequency oscillator for subtle modulation of the filter
    lfo = SinOsc.kr(0.2).range(0, 4000); // LFO for modulating cutoff frequency
    filter = RLPF.ar(sound, lfo + cutoff, res); // Apply filter

    // Envelope for the amplitude
    env = EnvGen.kr(Env.linen(0.1, sustain, release), doneAction: 2);

    // Reverb for depth
    signal = FreeVerb.ar(filter * env, mix: 0.5, room: 0.7);

    // Pan and output
    Out.ar(out, Pan2.ar(signal, pan));
}).add;
)

(
Synth(\supercollider_pad, [\freq, 440, \sustain, 4]); // A4
Synth(\supercollider_pad, [\freq, 493.88, \sustain, 4]); // B4
Synth(\supercollider_pad, [\freq, 523.25, \sustain, 4]); // C5
)


(
~dirt.soundLibrary.addSynth(\supercollider_pad);
)

