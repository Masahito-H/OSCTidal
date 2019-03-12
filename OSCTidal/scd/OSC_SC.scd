SuperDirt.start;
OSCdef(\test, {|msg, time, addr, recvPort| 'osc'.postln}, '/play2', n);

a = NetAddr.new("127.0.0.1", 12000);
OSCdef(\test, {a.sendMsg("/sendm", "outp")}, '/play2', n);