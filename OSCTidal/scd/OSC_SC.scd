SuperDirt.start;

a = NetAddr.new("127.0.0.1", 12000);
OSCdef(\test, {a.sendMsg("/sendm", "outp")}, '/play2', n);