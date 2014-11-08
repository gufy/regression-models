clear all, close all
figure 

% Replicate the generation of random functions from Figure 2.2. 
% Use a regular (or random) grid of scalar inputs and the covariance function from eq. (2.16). 
% Hints on how to generate random samples from multi-variate Gaussian distributions are given in section A.2. 
% Invent some training data points, and make random draws from the resulting GP posterior using eq. (2.19).
%

%x = rand(5,1)*4 - 2% * 0.3
sigma_f = 1.08; %parameter of the squared exponential kernel
sigma_n = 0.00005;
l =  0.3; %parameter of the squared exponential kernel
cov = @(x,x2) sigma_f^2*exp(sq_dist(x',x2')/(-2*l^2));
Len = 5

% body
x = ((1:Len) - 2) + randn()*0.5;
x = x'

m = 0;
K = cov(x,x);
L = chol(K);
u = randn(Len,1);
y = m + L * u; 
I = zeros(Len);

plot(x,y,'r+', 'LineWidth', 2)
hold all

xmin = min([(x-0.1); -1.9]);
xmax = max([(x+0.1); 1.9]);
axis([xmin xmax -3.9 3.9]);

z = linspace(xmin, xmax, 101)';

Kss = cov(z,z);
Ks  = cov(x,z);
s2 = Kss - Ks'/(K+I*sigma_n)*Ks;
ColorSet = varycolor(3);

plot(z, Ks'/(K+I*sigma_n)*y, 'k--', 'LineWidth', 1);

[V,D] = eig(s2);
A = real(V*(D.^(1/2)));

for I = 1:3
    Y(I,:) = Ks'/(K+I*sigma_n)*y + A * randn(length(A),1);
end

for I = 1:3
    %subplot(3,1,I)
    plot(z,real(Y(I,:)), 'Color', ColorSet(I,:))
end
% 
% figure
% for I = 1:3
%     subplot(3,1,I)
%     plot(z,Y(I,:), 'Color', ColorSet(I,:))
% end

