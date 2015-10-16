%% sample data

NTrees=20; MinLeaf=5;
[X, T] = dataSample(@f15, 2, 500);

P = [0.5 1];

%% compute function value at [0; 1]

params = default_params(2);
fun = f15(2,params,0);

display('Real function value at [0; 1]]');
fun(P')

input('Press Enter to continue');

%% random forests

NTrees = 40; MinLeaf=5;
mdl = forestsSim(X, T, struct('NTrees', 40, 'MinLeaf', 5));
            
plotTrained3dModel(mdl, 40);

input('Press Enter to continue');

%% gaussian processes

sn = 0.1;
cov = [0;0];
covfun = @covSEiso;
mdl = gpSim(X, T, struct('sn', sn, 'cov', cov, 'covfun', covfun));
plotTrained3dModel(mdl, 40);

input('Press Enter to continue');

%% radial basis function networks

max = 50; eg = 20; sc = 1;
mdl = nnSim(X, T, struct('max', max, 'eg', eg, 'sc', 1));
plotTrained3dModel(mdl, 40);


input('Press Enter to continue');

%% support vector regression
 
params = struct('s',3,'t',2,'g',1,'p',0.5,'e',0.001,'h',0);
mdl = svmSim(X, T, params);

plotTrained3dModel(mdl, 40);

input('Press Enter to continue');

%% polynomial regression

mdl = polyfitSim(X,T,struct());

plotTrained3dModel(mdl, 40);

