global ping;
ping = @() (system('kinit -R') && display('baf'));

I = 0;

I = I + 1;
models{I} = struct('name', 'SVM (epsilon-SVR, rbf)', 'model', @svmSim);
s = [3];
t = [2];
g = [0.016]; %[1, 1/2, 1/5, 1/10, 1/20, 1/40, 1/100];
p = [0.05]; %[0.5, 0.2, 0.15, 0.1, 0.05, 0.01];
e = [0.001];
h = [0];
c = [200, 300]; %[256, 512, 1024]; %[2, 4, 8, 16, 32, 64, 128];
models{I}.params = explodeStruct(struct(), allcombs( s, t, g, p, e, h, c ), {'s', 't', 'g', 'p', 'e', 'h', 'c'});

