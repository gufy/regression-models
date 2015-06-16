global ping;
ping = @() (system('kinit -R') && display('baf'));

I = 0;

I = I + 1;
models{I} = struct('name', 'Polynomial', 'model', @polyfitSim);
models{I}.params = struct();


%I = I + 1;
%models{I} = struct('name', 'RBF-NN', 'model', @nnSim);
%models{I}.params = {{4,2,1.5,1.2,1.1,1,0.1,0.01,0.001},{ 0.00001},{150}};