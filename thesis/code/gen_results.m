%%

import_results;

%%

for I = 1:10
    f = I + 14;
    dataset = [ 'f' int2str(f) '-5d-5000' ];
    subplot(2,5,I);
    gen_results_for(results, 'Forests', dataset);
    title(['f' int2str(f)]);
end