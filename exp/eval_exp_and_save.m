function [ res ] = eval_exp_and_save( params, exppath_short )

res = eval_exp(params, exppath_short);

% and save

params.mse = res.err;
params.info = res.info;
params.mse_all = mat2str(res.errors);
paramstr = struct2str(params, '&');
urlread(['http://vojtechkopal.cz/regressions/save.php?', paramstr]);    

end

