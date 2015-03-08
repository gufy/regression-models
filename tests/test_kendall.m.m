D = 40;
N = 5000;
maxInt = 5;
minInt = -5;

tic;

[XTrain, TTrain] = dataSample(@f15, D, N, maxInt, minInt);
model = forestsSim(XTrain, TTrain, {100, 5});

[XTest, TTest] = dataSample(@f15, D, N, maxInt, minInt);
Y = model(XTest);

toc;

test_err = (1/length(TTest))*sum((Y - TTest).^2);
fprintf('MSE=%f\n', test_err);

toc;

kendall = corr(TTest, Y, 'type', 'Kendall');
fprintf('corr(Kendall)=%f\n', kendall);

toc;