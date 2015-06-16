Method = 'RBF-NN';
MethodShort = 'rbf';

for F = 15:24

    for D = 40 %[5 10 20 40]
        
        Data = results(strcmp(Method, results.Method) & strcmp(['f', int2str(F),'-', int2str(D),'d-5000'], results.Dataset), :);
        
        [params, uniq] = paramsFromTable(Data);

        Data(:,'sc') = params.sc';
        Data(:,'max') = params.max';

        % spread constant
        
        SubData = Data(:, {'Trainerrormean', 'Testerrormean', 'sc'});
        SubData = SubData(SubData.sc >= 5, :);
        func = @min;
        GroupedData = varfun(func,SubData,'GroupingVariables','sc');
        GroupedData = GroupedData(GroupedData.GroupCount > 1, :);
        X_test = GroupedData.min_Testerrormean;
        X_train = GroupedData.min_Trainerrormean;
        Y = GroupedData.sc;

        figure;

        scatter(SubData.sc, SubData.Testerrormean);
        hold on;
        scatter(SubData.sc, SubData.Trainerrormean);

        ax = gca;
        ax.ColorOrderIndex = 1;
        
        h1 = plot(Y, X_test);
        h2 = plot(Y, X_train);
        
        try 
            legend([h1  h2], {'Test error', 'Train error'}, 'Location','northeast');
        end
        
        xlabel('Spread constant');
        ylabel('MSE');
        title(['f', int2str(F), ' ', int2str(D),'D']);
        
        set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
        set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
        saveas(gcf, ['thesis/images/errors_f', int2str(F), '_', int2str(D), 'd_', MethodShort,'_sc.pdf'], 'pdf');
    
        
        % max
        
        SubData = Data(:, {'Trainerrormean', 'Testerrormean', 'max'});
        func = @min;
        GroupedData = varfun(func,SubData,'GroupingVariables','max');
        GroupedData = GroupedData(GroupedData.GroupCount > 1, :);
        X_test = GroupedData.min_Testerrormean;
        X_train = GroupedData.min_Trainerrormean;
        Y = GroupedData.max;

        figure;

        scatter(SubData.max, SubData.Testerrormean);
        hold on;
        scatter(SubData.max, SubData.Trainerrormean);

        ax = gca;
        ax.ColorOrderIndex = 1;

        h1 = plot(Y, X_test);
        h2 = plot(Y, X_train);
        legend([h1, h2], {'Test error','Train error'},'Location','northeast');
        
        xlabel('Maximum neurons');
        ylabel('MSE');
        title(['f', int2str(F), ' ', int2str(D),'D']);
        
        set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
        set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
        saveas(gcf, ['thesis/images/errors_f', int2str(F), '_', int2str(D), 'd_', MethodShort,'_max.pdf'], 'pdf');
    
        
    end

end

