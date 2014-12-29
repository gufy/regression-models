
clear models;

name = ['f16-', num2str(DIM), 'D-crossval-', datetimestr];
D = [2, 5, 10, 20]; %, 40];

for DI = 1:length(D)

DIM=D(DI);
fprintf('\nDimension=%d\n------\n', DIM);
models{1} = struct('name', 'SVM', 'model', @svmSim);
models{1}.params = {{3}, {2}, {2, 5}};

models{2} = struct('name', 'Poly', 'model', @polyfitSim);
models{2}.params = {{0}};

models{3} = struct('name', 'RBF-NN', 'model', @nnSim);
models{3}.params = {{4,2,1,0.1,0.01,0.001},{0.01, 0.001, 0.0001},{100,200,300,400}};

models{4} = struct('name', 'Forests', 'model', @forestsSim);
models{4}.params = {num2cell(50:50:500), {1, 2, 5, 10, 20, 50, 100}};

models{5} = struct('name', 'GP', 'model', @gpSim);
models{5}.params = {{1e-6, 5e-6, 1e-5, 5e-5, 1e-4, 0.001, 0.01, 0.1}};

[X, T] = dataSample(@f15, DIM, 2000);
[T, Tfw, Tbw] = minmaxNorm(T);

results = crossValidateModels(models, X, T, @(results, models) ...
    save(['data/',name,'.mat'], 'results', 'models') ...
);

save(['data/',name,'.mat'], 'results', 'models');
sendmail('vojtech.kopal@gmail.com', ['MATLAB Results: ', name], 'Computation done.', ['data/',name,'.mat']); 

end
