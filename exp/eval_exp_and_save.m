function [ res ] = eval_exp_and_save( params, exppath_short )

if nargin < 2
    exppath_short = '.';
end

tic;
res = eval_exp(params, exppath_short);
t = toc;

% and save

params.mse = res.err;
params.info = res.info;
params.mse_all = mat2str(res.errors);
params.time = t;
paramstr = struct2str(params, '&');
urlread(['http://vojtechkopal.cz/regressions/save.php?', paramstr]);    

end

