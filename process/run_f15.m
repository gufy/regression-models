
clear models;

D = [2, 5, 10, 20]; %, 40];

for DI = 1:length(D)

DIM=D(DI);
fprintf('\nDimension=%d\n------\n', DIM);
models{1} = struct('name', 'SVM', 'model', @svmSim);
models{1}.params = {{3}, {2}, {2, 5}};

models{2} = struct('name', 'GP', 'model', @gpSim);
models{2}.params = {{1e-6, 1e-5, 0.5e-5, 1e-4, 0.001, 0.01, 0.1}};

[X, T] = dataSample(@f15, DIM, 2000);
[T, Tfw, Tbw] = minmaxNorm(T);

results = crossValidateModels(models, X, T);

name = ['f15-', num2str(DIM), 'D-crossval-', datetimestr];
save(['data/',name,'.mat'], 'results', 'models');
sendmail('vojtech.kopal@gmail.com', ['MATLAB Results: ', name], 'Computation done.', ['data/',name,'.mat']); 

end

%%

%y = [0.001, 0.05, 0.1, 0.5, 1, 2, 5, 20, 40, 80];
%plot(y, test_err);
%set(gca, 'xscale', 'log');
%set(gca, 'xtick', y);

%hold on;
%plot(y, train_err, '--');
%legend('Test', 'Train');
%hold off;

%%

%model = svmSim(X, T, { 3, 2, 5 });
%plotTrainedModel(model, 100);

