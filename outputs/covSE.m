function K = covSE(hyp, x, z)

if nargin<2, K = '1'; return; end
if nargin<3, z = []; end                                   % make sure, z exists
xeqz = numel(z)==0; dg = strcmp(z,'diag') && numel(z)>0;        % determine mode

ell = 1;%exp(hyp(1));                                 % characteristic length scale

% precompute squared distances
if dg                                                               % vector kxx
  K = zeros(size(x,1),1);
else
  if xeqz                                                 % symmetric matrix Kxx
    K = sq_dist(x'/ell);
  else                                                   % cross covariances Kxz
    K = sq_dist(x'/ell,z'/ell);
  end
end

if nargin<4                                                       % covariances
  K = exp(-K/2);
else                                                               % derivatives
  if i==1
    K = exp(-K/2).*K;
  else
    error('Unknown hyperparameter')
  end
end