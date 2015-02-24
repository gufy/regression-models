
model1 = @(x) sim(net, x');
plotTrainedModel(model1, 50, 0, 1, 0, 0, Xbw, Ybw);
hold on;
scatter3(XX(:,1), XX(:,2), Y);

%%

