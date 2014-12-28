[X, T] = dataSample(@f15, 2, 2000);

%%

model = nnSim(X, T);

%%

N = 100;

%%
X = linspacem(-5,5,N,2);
T = zeros(size(X,1),1); %f(X);
for i = 1:(N*N)
    T(i) = f(X(i,:)');
end

%%

D = size(X, 2);
eg = 1.5; % sum-squared error goal
sc = 1;    % spread constant
net = newrb(X',T',eg,sc);

%%

N = 50;
[XS, YS] = meshgrid(linspace(-4,4,N),linspace(-4,4,N));
ZS = zeros(N,N);

X = [XS(:) YS(:)]';
ZS = net(X);
%ZS = T;
ZS = reshape(ZS, [N N]);

mesh(XS, YS, ZS);

%%

TS = reshape(T, [N N]);
mesh(XS, YS, TS);

%%
X = linspacem(-3,6,30,D)';
Y = net(X);

plot(X, Y);