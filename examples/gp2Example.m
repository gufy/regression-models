X = [rand(1,N/2)*3-4 rand(1,N/2)*3+1];
Y = sin(X) + randn(1, N)*0.1;

len = size(X, 1);
test_len = floor(len / 3);
idx_ = randperm(len, test_len);
idx = zeros(len, 1);
idx(idx_) = 1;

idx = logical(idx);

X1 = X(~idx,:);
Y1 = Y(~idx,:);
X2 = X(idx,:);
Y2 = Y(idx,:);

X1 = X1';
Y1 = Y1';
X2 = X2';
Y2 = Y2';

for N = 1 : 2
    % normalize
    m = mean(Y1(N,:));
    s = std(Y1(N,:));
    Y1(N,:) = 1/s * (Y1(N,:) - m);
    Y2(N,:) = 1/s * (Y2(N,:) - m);

    covfunc = @covSEiso;
    ell = 2;
    sf = 1;
    hyp.cov = [ log(ell); log(sf)];

    likfunc = @likGauss;
    sn = 1;
    hyp.lik = log(sn);

    hyp = minimize(hyp, @gp, -100, @infExact, [], covfunc, likfunc, X1', Y1(N,:)');
    [m s2] = gp(hyp, @infExact, [], covfunc, likfunc, X1', Y1(N,:)', X1');    
    figure;    
    subplot(2,1,1); hold on;    
    title(['N = ' num2str(N)]);    
    f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
    x = [1:length(m)];
    fill([x'; flipdim(x',1)], f, [7 7 7]/8);
    plot(Y1(N,:)', 'b');
    plot(m, 'r');
    mse_train = mse(Y1(N,:)' - m);

    [m s2] = gp(hyp, @infExact, [], covfunc, likfunc, X1', Y1(N,:)', X2');
    subplot(2,1,2); hold on;
    f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
    x = [1:length(m)];
    fill([x'; flipdim(x',1)], f, [7 7 7]/8);    
    plot(Y2(N,:)', 'b');
    plot(m, 'r');
    mse_test = mse(Y2(N,:)' - m);

    disp(sprintf('N = %d -- train = %5.4f   test = %5.4f', N, mse_train, mse_test));
end