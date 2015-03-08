function [ params ] = gpParams( fun, cov_params, sn_param, dim )
% gpParams(@f15, {[0.1 0.5 1]; [0.1 0.2]}, [0.1 0.3])

if nargin < 4
    %iso
    
    cov_param_combs = allcombs(cov_params{1}, cov_params{2}, sn_param);
    params = explodeStruct(struct('covfun', fun), cov_param_combs, {'cov1', 'cov2', 'sn'});

    for I = 1:length(params)
        params(I).cov = [params(I).cov1 params(I).cov2];    
    end

    params = rmfield(params, 'cov1');
    params = rmfield(params, 'cov2');

else 
    %ard
    
    % TODO
    
end

end

