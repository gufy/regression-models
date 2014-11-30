N = 100;
[X, T] = dataSample(@f15, 2, 100);

%%

model = gpSim(X, T);

%% 

plotTrainedModel(model, 50);

%%

N = 100;
[XS, YS] = meshgrid(linspace(-4,4,N),linspace(-4,4,N));
figure;
TS = reshape(T, [N N]);
mesh(XS, YS, TS);
