setup;
setup_mail;

%% loading data

clear

[X, Y] = dataSample(@f21, 2, 900);


%% minmax normalization

[sX, Xfw, Xbw] = minmaxNorm(X);
[sY, Yfw, Ybw] = minmaxNorm(Y);

%%

system('ulimit -t unlimited');

name = ['f21-', 'crossval-2d-', datetimestr];

fprintf('\n[wine]\n------\n');

I = 0;

I = I + 1;
models{I} = struct('name', 'SVM', 'model', @svmSim);
models{1}.params = {{3}, {2}, { 0.001, 0.01, 0.1, 1, 2, 5, 10, 15, 20, 30, 50, 100, 150, 200, 250, 300, 350, 400, 500, 600, 700}};

I = I + 1;
models{I} = struct('name', 'Poly', 'model', @polyfitSim);
models{I}.params = {{'quadratic'}};

I = I + 1;
models{I} = struct('name', 'RBF-NN', 'model', @nnSim);
models{I}.params = {{4,2,1.5,1.2,1.1,1,0.1,0.01,0.001},{0.01, 0.001, 0.0001, 0.00001},{25, 50, 75,100,150,200,250,300,350,400,450,500}};

I = I + 1;
models{I} = struct('name', 'Forests', 'model', @forestsSim);
models{I}.params = {num2cell(50:50:900), {1, 2, 5, 10, 20, 50}};

I = I + 1;
models{I} = struct('name', 'GP', 'model', @gpSim);
models{I}.params = {{1e-6, 5e-6, 1e-5, 5e-5, 1e-4, 0.001, 0.01, 0.1, 0.2, 0.5, 1, 1.5, 2, 4, 8, 10}, {0}};

results = crossValidateModelsWithParams(models, sX, sY, @(results, models) ...
    save(['data/',name,'.mat'], 'results', 'models') ...
);

save(['data/',name,'.mat'], 'results', 'models');
sendmail('vojtech.kopal@gmail.com', ['MATLAB Results: ', name], 'Computation done.', ['data/',name,'.mat']); 
system('kinit -R');
