func = @f15;
D = 2;
R = eye(D);
Q = R;

x_opt_val = zeros(D,1);
f_opt_val = 0;

f = func(D, x_opt_val, f_opt_val, R, Q);

%%

N = 50;

%%
X = linspacem(-5,5,N,2);
T = zeros(size(X,1),1); %f(X);
for i = 1:(N*N)
    T(i) = f(X(i,:)');
end

%%

D = size(X, 2);
eg = 0.02; % sum-squared error goal
sc = 1;    % spread constant
net = newrb(X', T', eg, sc, 10000);

