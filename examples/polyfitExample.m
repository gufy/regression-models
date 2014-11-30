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

mdl = fitlm(X,T,'Y ~ (A + B)^6','VarNames',{'A', 'B', 'Y'});

%%

N = 50;
[XS, YS] = meshgrid(linspace(-4,4,N),linspace(-4,4,N));
ZS = zeros(N,N);

X = [XS(:) YS(:)]';
ZS = mdl.predict(X');
%ZS = T;
ZS = reshape(ZS, [N N]);

mesh(XS, YS, ZS);

%%

TS = reshape(T, [N N]);
mesh(XS, YS, TS);
