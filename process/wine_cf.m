setup;
setup_mail;

%% loading data

clear
load('data/wine.mat');
Y = y;
clear y;

%% minmax normalization

[sX, Xfw, Xbw] = minmaxNorm(X);
[sY, Yfw, Ybw] = minmaxNorm(Y);

%%

system('ulimit -t unlimited');

name = ['wine-', 'crossval-', datetimestr];

fprintf('\n[wine]\n------\n');
models{1} = struct('name', 'SVM', 'model', @svmSim);
models{1}.params = {{3}, {2}, {2, 5}};

models{2} = struct('name', 'Poly', 'model', @polyfitSim);
models{2}.params = {{'quadratic'}};

models{3} = struct('name', 'RBF-NN', 'model', @nnSim);
models{3}.params = {{4,2,1,0.1,0.01,0.001},{0.01, 0.001, 0.0001},{100,200,300,400}};

models{4} = struct('name', 'Forests', 'model', @forestsSim);
models{4}.params = {num2cell(50:50:500), {1, 2, 5, 10, 20, 50, 100}};

models{5} = struct('name', 'GP', 'model', @gpSim);
models{5}.params = {{1e-6, 5e-6, 1e-5, 5e-5, 1e-4, 0.001, 0.01, 0.1}};

results = crossValidateModelsWithParams(models, sX, sY, @(results, models) ...
    save(['data/',name,'.mat'], 'results', 'models') ...
);

save(['data/',name,'.mat'], 'results', 'models');
sendmail('vojtech.kopal@gmail.com', ['MATLAB Results: ', name], 'Computation done.', ['data/',name,'.mat']); 
system('kinit -R');
