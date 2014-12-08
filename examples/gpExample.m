
[X, T] = dataSample(@f15, 2, 2000);

%%

model = gpSim(X, T);

%% 

outputPath = ['outputs/sims/', 'f15-gp', '-', datetimestr];
plotTrainedModel(model, 50, 5, -5, outputPath);
save([outputPath,'.mat'], 'model');

%% TODO: plot desired function next to modeled one

N = 100;
[XS, YS] = meshgrid(linspace(-4,4,N),linspace(-4,4,N));
figure;
TS = reshape(T, [N N]);
mesh(XS, YS, TS);
