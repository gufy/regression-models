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

mdl = TreeBagger(NTrees, X, T, 'Method', 'regression',...
                'MinLeaf', MinLeaf);
y = mdl.predict(P);

fprintf('random forest predicts %f\n', y);

input('Press Enter to continue');

%% gaussian processes

sn = 0.1;
covfunc = @covSEiso; %covRQiso, covMaterniso
hyp2.cov = [0 ; 0];
likfunc = @likGauss;     
hyp2.lik = log(sn);
hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X, T);
y = gp(hyp2, @infExact, [], covfunc, likfunc, X, T, P);

fprintf('gaussian processes predicts %f\n', y);

input('Press Enter to continue');

%% radial basis function networks

max = 50; eg = 20; sc = 1;
net = newrb(X',T',eg,sc,max);
y = net(P);

fprintf('radial basis function networks predicts %f\n', y);

input('Press Enter to continue');

%% support vector regression
 
method = 's=3,t=2,g=1,p=0.5,e=0.001,h=0';
model = svmtrain(T, X, method);

x = P;
ze = zeros(size(x,1),1);
y = svmpredict(zeros(size(x,1),1),x,model);
fprintf('support vector regression predicts %f\n', y);

input('Press Enter to continue');

%% polynomial regression

method = 'quadratic';
mdl = fitlm(X,T,method);

x = P;
y = mdl.predict(x);
fprintf('polynomial regression predicts %f\n', y);

