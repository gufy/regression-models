%%

import_results;

%%

for I = 1:10
    f = I + 14;
    dataset = [ 'f' int2str(f) '-40d-5000' ];
    subplot(2,5,I);
    gen_results_for(results, 'Forests', dataset);
    title(['f' int2str(f)]);
end

%%

for D = [5 10 20 40]
    for I = 1:10
        f = I + 14;
        dataset = [ 'f', int2str(f), '-', int2str(D), 'd-5000' ];
        gen_results_for(results, 'RBF-NN', dataset);
        %title(['f' int2str(f)]);
        
        set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
        set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
        saveas(gcf, ['thesis/images/rbf_params_f', int2str(f), '_', int2str(D), 'd.pdf'], 'pdf');

    end
end

%%

f = 16;
dataset = [ 'f' int2str(f) '-10d-5000' ];
gen_results_for(results, 'RBF-NN', dataset);
title(['f' int2str(f)]);

%%

f = 16;
dataset = [ 'f' int2str(f) '-10d-5000' ];
gen_curve_for(results, 'RBF-NN', dataset);
title(['f' int2str(f)]);