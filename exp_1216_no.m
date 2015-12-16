load_exp_params;
p = expandParams(P);

len = length(p);
batchSize = 1000;
tic;
for I = 1:batchSize:len %len % how to iterate efficiently?
    params = p(I:min(len,I+batchSize-1));
    
    %eval_exp_and_save(params);
    display(['Create task: ', int2str(I), '/', int2str(len)]);
    eval_batch(params);   
 
end

toc
   
