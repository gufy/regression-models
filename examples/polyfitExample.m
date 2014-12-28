
[X, T] = dataSample(@f15, 2, 2000);

%%

model = polyfitSim(X, T);

%%

outputPath = ['outputs/sims/', 'f15-polyfit', '-', datetimestr];
plotTrainedModel(model, 50, 5, -5, outputPath);
imageTrainedModel(model, 50, 5, -5, [outputPath,'-im']);
save([outputPath,'.mat'], 'model');

%% crossvalidate

FI = 15;
fname = ['f', int2str(FI)];
f = str2func(fname);

[X, T] = dataSample(f, 2, 2000);

[test_err, train_err, params_comb] = crossValidateModel(@polyfitSim, X, T);

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




