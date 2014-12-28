X = -6:0.2:6;
Y = sin(X);

%%

plot(X,Y);

%%

K = 20;

SX = rand(K,1)*3 - 3;
Xs = SX;
T = sin(SX) + randn(K,1)*0.05;

SX = rand(K,1) * 3 + 3;
Xs = [Xs; SX];
T = [T; (sin(SX) + randn(K,1)*0.1)];

scatter(Xs, T);
hold on;

%%

model = forestsSim(Xs, T, {300, 3});

%%

model = gpSim(Xs, T);

%%

model = polyfitSim(Xs, T, {'y ~ x1^9'});

%%

model = nnSim(Xs, T);

%%

Xtr = (-6:0.2:6)';
[Ytr, StdTr] = model(Xtr);

%%

figure;
hold on;

if ~isempty(StdTr)
    if size(StdTr, 2) == 1
        XU = Ytr' + StdTr';
        XL = Ytr' - StdTr';
    else
        XU = StdTr(:,1)';
        XL = StdTr(:,2)';
    end

    Xfill = [Xtr', fliplr(Xtr')];
    Yfill = [XU, fliplr(XL)];
    fill(Xfill, Yfill, [0.8 0.8 0.8], 'EdgeColor', 'none');
end

scatter(Xs, T);
plot(Xtr, Ytr);
hold on;
plot(X,Y);
axis([-4 6 -1 1]);

%%

f = @(D, params) (@(x) sin(x));

[X, T] = dataSample(f, 1, 10);
[T, Tfw, Tbw] = minmaxNorm(T);

%%

model = forestsSim(Xs, T, {1000});

%%

params = {num2cell(5:5:500), {5}};%, 10, 20, 50, 100}};

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

