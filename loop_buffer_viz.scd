(
// Automatically close any existing window
if (~looperWindow.notNil, { ~looperWindow.close });
if (~waveformUpdater.notNil, { ~waveformUpdater.stop });

~bufferCount = ~looper.numBuffers;
~looperWindow = Window("TidalLooper Waveforms", Rect(100, 100, 800, 600));
~looperWindow.background_(Color.black);
~waveformViews = Array.fill(~bufferCount, { |i|
    var view = SoundFileView(~looperWindow, Rect(10, (i * 70) + 10, 780, 60));
    view.background_(Color.black);
    view.waveColors = [Color.white, Color.gray(0.5)];
    view.gridOn = false;
    view
});

~updateWaveforms = {
    var buffers = ~dirt.soundLibrary.buffers.values.select { |key| key.asString.contains("loop") };

    ~waveformViews.do { |view, i|
        var buffer = buffers.choose;

        if (buffer.notNil) {
            {
                var soundFile = SoundFile.new;
                var channelData;
                var filePath;

                filePath = buffer.at(4).asString;
                soundFile.path_(filePath);
                if (soundFile.openRead, {
                    channelData = FloatArray.newClear(soundFile.numFrames * soundFile.numChannels);
                    soundFile.readData(channelData);
                    soundFile.close;

                    {
                        view.setData(channelData);
                        view.refresh;
                    }.defer;
                }, {
                    "Failed to open file: %".format(filePath).postln;
                });
            }.fork;
        } {
            view.clear;
        }
    };
};

~waveformUpdater = Routine {
    loop {
        ~updateWaveforms.();
        0.5.wait;
    }
}.play;

~looperWindow.front;

// Ensure cleanup when window is closed
~looperWindow.onClose = {
    ~waveformUpdater.stop;
};
)