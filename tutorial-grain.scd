s.boot();
(
s.meter;
s.plotTree;
s.scope;
)

b = Buffer.readChannel(s, "/Users/jamesreichard/Documents/Samples/01-11-2023-century-trio-opening.wav", channels: [0]);
a = Buffer.readChannel(s, "/Users/jamesreichard/Documents/Samples/01-11-2023-century-trio-ride-and-percussion.wav", channels: [0]);
c = Buffer.readChannel(s, "/Users/jamesreichard/Documents/Samples/ringmod-guitar-boom.wav", channels: [0]);
b.play();

FreqScope.new;
(
{
	var sig;
	var rate;
	rate = 0.25;
	sig = GrainBuf.ar(
		2,
		Impulse.ar(0.9),
		2.71,
		b,
		rate,
		(
			Phasor.ar(
				0.1,
				1* BufRateScale.ir(a),
				0,
				BufSamples.ir(a)-1 + LFNoise1.ar(100).bipolar(0.01 * SampleRate.ir)
			)
		) / BufSamples.ir(a),
			2,
			0,
			-1,
			512
	);
	sig = sig * 0.4;
}.play
)
{LFSaw.ar(10,1)}.plot(0, 2)

CmdPeriod.run
Synth('temp__34').run(false);
x.free
