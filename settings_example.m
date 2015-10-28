global ping;
ping = @() (system('kinit -R') && display('baf'));

I = 0;

% I = I + 1;
% models{I} = struct('name', 'SVM (epsilon-SVR, rbf)', 'model', @svmSim);
% s = [3];
% t = [2];
% g = [1,  1/5, 1/10, 1/40, 1/80, 1/120];
% p = [0.5, 0.2, 0.15, 0.1, 0.05, 0.01];
% e = [0.001];
% h = [0];
% c = [2, 4, 16, 64, 256, 348];
% models{I}.params = explodeStruct(struct(), allcombs( s, t, g, p, e, h, c ), {'s', 't', 'g', 'p', 'e', 'h', 'c'});
% 
% I = I + 1;
% models{I} = struct('name', 'Polynomial', 'model', @polyfitSim);
% models{I}.params = struct();
% 
% I = I + 1;
% models{I} = struct('name', 'RBF-NN', 'model', @nnSim);
% scParams = [0.1;1;2;4;10;20];
% egParams = [0.001];
% maxParams = [20;50;100;200;300;600];
% models{I}.params = explodeStruct(struct(), allcombs( scParams , egParams, maxParams), {'sc', 'eg', 'max'});
% 
% I = I + 1;
% models{I} = struct('name', 'Forests', 'model', @forestsSim);
% NTrees = [50; 100; 200; 400];
% MinLeaf = [1; 2; 5; 10; 20; 50];
% models{I}.params = explodeStruct(struct(), allcombs( NTrees , MinLeaf ), {'NTrees', 'MinLeaf'});

I = I + 1;
models{I} = struct('name', 'GP (SEiso)', 'model', 'gpSim');
covParams = [0]; 
covParams = [covParams {[1]}];
snParams = [0.01; 0.1; 1; 1.1; 1.2; 1.5; 1.75; 2; 4];
models{I}.params = explodeStruct(struct('fun', 'covSEiso'), allcombs( snParams , covParams{:}), {'sn', 'cov'});