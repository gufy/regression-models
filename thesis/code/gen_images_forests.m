%% number of trees in the random forest

% Nums is a list of number of trees in the random forest
% For each we generate graph of the model fit

Nums = [2 5 50 400];
for I = 1:length(Nums)
    
    Num = Nums(I);
    lin = -4:0.1:4;
    sin_y = sin(lin);
    
    f = figure;
    plot(lin, sin_y);
    hold on;

    N = 60;
    X = [rand(1,N/2)*3-4 rand(1,N/2)*3+1];
    T = sin(X) + randn(1, N)*0.1;
    scatter(X, T);
    axis([-4 4 -2.5 2.5]);

    model = forestsSim(X', T', struct('NTrees', Num, 'MinLeaf', 5, 'NVarToSample', 1));
    
    plotTrained1dModel(model.predict, 100, -4, 4, 0, f);
    
    set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
    set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
    saveas(gcf, ['thesis/images/rforests', num2str(Num), '.pdf'], 'pdf')

end

%% number of minimum of data points in a leaf

% Nums is a list of minimums of data points in a leaf
% For each we generate graph of the model fit


Nums = [40 20 10 5 2 1];
for I = 1:length(Nums)
    
    MinLeaf = Nums(I);
    lin = -4:0.1:4;
    sin_y = sin(lin);
    
    f = figure;
    plot(lin, sin_y);
    hold on;

    N = 60;
    X = [rand(1,N/2)*3-4 rand(1,N/2)*3+1];
    T = sin(X) + randn(1, N)*0.1;
    scatter(X, T);
    axis([-4 4 -2.5 2.5]);

    %

    model = forestsSim(X', T', struct('NTrees', 40, 'MinLeaf', MinLeaf, 'NVarToSample', 1));
    
    plotTrained1dModel(model.predict, 100, -4, 4, 0, f);
    
    set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
    set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
    saveas(gcf, ['thesis/images/rforests_l_', num2str(MinLeaf), '.pdf'], 'pdf')

end
