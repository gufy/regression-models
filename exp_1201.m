clear;
load_exp_params;
p = expandParams(P);

%%

log = {};
tic;
for I = 1:2 %length(p) % how to iterate efficiently?
    params = p(I);
    
    params = prepare_exp_params(params);
    res = eval_exp_and_save(params);
    log{I} = struct('params', params, 'res', res);
    
end
toc
   