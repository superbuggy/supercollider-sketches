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
z= {
	var sig, rate, imp_freq, duration;
	rate = 0.444;
	imp_freq = 90;
	duration = 5 * rate / imp_freq;
	sig = GrainBuf.ar(
		2,
		Impulse.ar(imp_freq),
		duration,
		b,
		rate,
		( // starting position
			Phasor.ar(
				// 0.1, // trigger
				Impulse.ar(
					LFNoise1.ar(imp_freq)

				), //trigger

				1* BufRateScale.ir(a), //rate
				0, // start
				BufSamples.ir(a)-1 + LFNoise1.ar(100).bipolar(0.01 * SampleRate.ir) //end,
				,0.5
			)
		) / BufSamples.ir(a),
			2, // interpolation
			0,
			-1,
			512
	);
	sig = sig * 0.4; // volume
}.play;
)
{LFSaw.ar(10,1)}.plot(0, 2)



s.queryAllNodes;
z.free;
