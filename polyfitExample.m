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

mdl = fitlm(X,T,'Y ~ (A + B)^15','VarNames',{'A', 'B', 'Y'});
save('poly25_mdl.mat', 'mdl');
sendmail('vojtech.kopal@gmail.com', 'Computation finished: poly15', 'Computation has finished', {'poly15_mdl.mat'}); 
