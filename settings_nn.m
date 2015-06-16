global ping;
ping = @() (system('kinit -R') && display('baf'));

I = 0;

I = I + 1;
models{I} = struct('name', 'RBF-NN', 'model', @nnSim);
scParams = [4; 2; 1.5; 1.2; 1.1; 1; 0.1; 0.01; 0.001];
eqParams = [1; 0.1; 0.01];
maxParams = [500, 1000];
models{I}.params = explodeStruct(struct(), allcombs( scParams , eqParams, maxParams), {'sc', 'eq', 'max'});


%I = I + 1;
%models{I} = struct('name', 'RBF-NN', 'model', @nnSim);
%models{I}.params = {{4,2,1.5,1.2,1.1,1,0.1,0.01,0.001},{ 0.00001},{150}};