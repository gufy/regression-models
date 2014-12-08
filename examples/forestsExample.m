
[X, T] = dataSample(@f15, 2, 2000);

%%

model = forestsSim(X, T);

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

%%

