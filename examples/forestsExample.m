
[X, T] = dataSample(@f15, 2, 2000);

[T, Tfw, Tbw] = minmaxNorm(T);

%%

model = forestsSim(X, T, {400, 5});

%% 

outputPath = ['outputs/sims/', 'f15-forests', '-', datetimestr];
plotTrainedModel(model, 50, 5, -5, outputPath);
imageTrainedModel(model, 50, 5, -5, [outputPath,'-im']);
save([outputPath,'.mat'], 'model');


%%

for FI = 15:24
    fname = ['f', int2str(FI)];
    f = str2func(fname);
    
    [X, T] = dataSample(f, 2, 2000);
    model = forestsSim(X, T);

    outputPath = ['outputs/sims/', fname, '-forests', '-', datetimestr];
    plotTrainedModel(model, 100, 5, -5, outputPath);
    imageTrainedModel(model, 100, 5, -5, [outputPath,'-im']);
    save([outputPath,'.mat'], 'model');
end

%% crossvalidate

FI = 15;
fname = ['f', int2str(FI)];
f = str2func(fname);

[X, T] = dataSample(f, 2, 2000);
[T, Tfw, Tbw] = minmaxNorm(T);

%%

model = forestsSim(X, T, {400, 5});

%%

plotTrainedModel(model, 100, 5, -5);
    
%%

%params = {num2cell(400:25:500), {5}};%, 10, 20, 50, 100}};

params = {{400}, num2cell(1:2:11)};

[test_err, train_err, params_comb] = crossValidateModel(@forestsSim, X, T, params, @(test_err, train_err, param_combs) plotCrossValidateResults(test_err, train_err, param_combs, params));

%% plot cross validate results

params_mat = cell2mat(params_comb);
cc=hsv(12);
figure;
for I = 1:length(params{2})
    el = cell2mat(params{2}(I));
    dat = params_mat((params_mat(:,2)) == el, 1);
    vals = test_err(params_mat(:,2) == el);
    plot(dat, vals,'color',cc(I,:));
    display(vals);
    hold on
    vals = train_err(params_mat(:,2) == el);
    plot(dat, vals, '--','color',cc(I,:));
    display(vals);
    hold on
end
legend({'5', '5'},'Location','NorthEast');
hold off;

%%



