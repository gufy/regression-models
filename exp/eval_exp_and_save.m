function [ res ] = eval_exp_and_save( params )

res = eval_exp(params);

% and save

params.mse = res.err;
paramstr = struct2str(params, '&');
urlread(['http://vojtechkopal.cz/regressions/save.php?', paramstr]);    

end

