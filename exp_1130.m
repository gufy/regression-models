clear;

Phases = [20, 40, 100, 200];
NumTrains = [5, 10, 20, 40];
TrainRanges = [2, 4, 8, 12, 16];

D = 2;

I = 1;
G = Phases(I) * D;

I = 1;
NumTrain = NumTrains(I) * D;

I = 1;
TrainRange = TrainRanges(I);

I = 1;
ExpId = I;

fprintf('Running evaluation: D=%d, gen=%d, NumTrain=%d, TrainRange=%d\n', D, G, NumTrain, TrainRange);
load(['exp/', 'exp_cmaeslog1_purecmaes_1_', int2str(D), 'D_1']);

CmaesOut = cmaes_out{ExpId};
TrainRange = TrainRange * CmaesOut.sigmas(G)^2;
M = CmaesOut.means(:, G);

[X, Y] = loadArchive(G, CmaesOut, ...
    struct('m', M, 'range', TrainRange, 'num', NumTrain));

X = X - repmat(mean(X,2), 1, length(Y));
model = gpSim(X', Y', struct('sn',0.02));

f = figure;

scatter3(X(1,:), X(2,:), Y, 'ro', 'LineWidth', 2);
hold on;
plotTrained3dModel(model, 200, 2*max(max(X)), 2*min(min(X)), 0, f);
hold off;
