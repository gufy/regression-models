function [ predict, err_tr ] = gpSim( X, T )

covfunc = @covSEiso; 
  likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);

hyp2.cov = [0 ; 0];    
hyp2.lik = log(0.1);
hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, X, T);
  
err_tr = gp(hyp2, @infExact, [], covfunc, likfunc, X, T);
predict = @(x) ( gp(hyp2, @infExact, [], covfunc, likfunc, X, T, x) );

end

