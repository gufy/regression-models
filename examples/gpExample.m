func = @f15;
D = 2;
R = eye(D);
Q = R;

x_opt_val = zeros(D,1);
f_opt_val = 0;

f = func(D, x_opt_val, f_opt_val, R, Q);

%%

N = 100;

%%
X = linspacem(-5,5,N,2);
T = zeros(size(X,1),1); %f(X);
for i = 1:(N*N)
    T(i) = f(X(i,:)');
end

%%

covfunc = @covSEiso; 
  likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);

hyp2.cov = [0 ; 0];    
hyp2.lik = log(0.1);
hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, x, y);
  
nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, X, T)

%%

N = 50;
[XS, YS] = meshgrid(linspace(-4,4,N),linspace(-4,4,N));
ZS = zeros(N,N);

X2 = [XS(:) YS(:)];
[ZS s2] = gp(hyp2, @infExact, [], covfunc, likfunc, X, T, X2);
%ZS = T;
ZS = reshape(ZS, [N N]);

mesh(XS, YS, ZS);

%%

N = 100;
[XS, YS] = meshgrid(linspace(-4,4,N),linspace(-4,4,N));
figure;
TS = reshape(T, [N N]);
mesh(XS, YS, TS);
