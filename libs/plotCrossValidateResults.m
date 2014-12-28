function [  ] = plotCrossValidateResults( test_err, train_err, params_comb, params )

len = length(test_err);
params_mat = cell2mat(params_comb);
cc=hsv(12);

for I = 1:length(params{2})
    el = cell2mat(params{2}(I));
    dat = params_mat((params_mat(1:len,2)) == el, 1);
    vals = test_err(params_mat(1:len,2) == el);
    plot(dat, vals,'color',cc(I,:));
    hold on
    vals = train_err(params_mat(1:len,2) == el);
    plot(dat, vals, '--','color',cc(I,:));
    hold on
end
hold off;

end

