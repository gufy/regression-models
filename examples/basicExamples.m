%% init

NTrees=20; MinLeaf=5;
[X, T] = dataSample(@f15, 2, 500);

%%

params = default_params(2);
fun = f15(2,params,0);
fun([0; 1])

%% random forests

mdl = TreeBagger(NTrees, X, T, 'Method', 'regression',...
                'MinLeaf', MinLeaf);
y = mdl.predict([0 1]);

fprintf('random forest predicts %f\n', y);

%% gaussian processes

sn = 0.1;
covfunc = @covSEiso; %covRQiso, covMaterniso
hyp2.cov = [0 ; 0];
likfunc = @likGauss;     
hyp2.lik = log(sn);
hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X, T);
y = gp(hyp2, @infExact, [], covfunc, likfunc, X, T, [0 1]);

fprintf('gaussian processes predicts %f\n', y);

%% radial basis function networks

max = 50; eg = 20; sc = 1;
net = newrb(X',T',eg,sc,max);
y = net([0 1]');

fprintf('radial basis function networks predicts %f\n', y);

%% support vector regression
 
method = 's=3,t=2,g=1,p=0.5,e=0.001,h=0';
model = svmtrain(T, X, method);

x = [0 1];
ze = zeros(size(x,1),1);
y = svmpredict(zeros(size(x,1),1),x,model);
fprintf('support vector regression predicts %f\n', y);

%% polynomial regression

method = 'quadratic';
mdl = fitlm(X,T,method);

x = [0 1];
y = mdl.predict(x);
fprintf('polynomial regression predicts %f\n', y);

