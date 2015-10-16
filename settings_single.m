global ping;
ping = @() (system('kinit -R') && display('baf'));

I = 0;

%I = I + 1;
%models{I} = struct('name', 'Forests', 'model', @forestsSim);
%models{I}.params = [ struct('NTrees', [800], 'MinLeaf', [50]) ];

%I = I + 1;
%models{I} = struct('name', 'GP (RQiso)', 'model', @gpSim);
%models{I}.params = [ struct('covfun', ['covRQiso'], 'sn', [0.5], 'cov', [0.69315,0,0.09531]) ];

I = I + 1;
models{I} = struct('name', 'Polynomial', 'model', @polyfitSim);
models{I}.params = [ struct() ];

%I = I + 1;
%models{I} = struct('name', 'RBF-NN', 'model', @nnSim);
%models{I}.params = [ struct('sc', [5], 'eg', [1], 'max', [50]) ];

%I = I + 1;
%models{I} = struct('name', 'SVM (epsilon-SVR, rbf)', 'model', @svmSim);
%models{I}.params = [ struct('s', [3], 't', [2], 'g', [0.0125], 'p', [0.01], 'e', [0.001], 'h', [0], 'c', [16]) ];

