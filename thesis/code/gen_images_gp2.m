%% Demo #3 Gaussian Process %%
% one way of looking at a Gaussian Process is as a Multivariate Normal with
% an infinite number of dimensions. However, in order to model
% relationships between points, we construct the covariance matrix with a
% function that defines the value of the matrix for any pair of real numbers:
figure;
sigma_f = 0.6; %parameter of the squared exponential kernel
l =  0.90441; %parameter of the squared exponential kernel
kernel_function = @(x,x2) sigma_f^2*exp((x-x2)^2/(-2*l^2));

%This is one of many popular kernel functions, the squared exponential
%kernel. It favors smooth functions. (Here, it is defined here as an anonymous
%function handle)

% we can also define an error function, which models the observation noise
sigma_n = 0.0; %known noise on observed data
error_function = @(x,x2) sigma_n^2*(x==x2); 
%this is just iid gaussian noise with mean 0 and variance sigma_n^2s

%kernel functions can be added together. Here, we add the error kernel to
%the squared exponential kernel)
k = @(x,x2) kernel_function(x,x2)+error_function(x,x2);

%We can find the mean and the variance of the GP at each point
prediction_x=-2:0.01:1;
for i=1:length(prediction_x)
    mean(i) = 0;
    variance(i) = k(prediction_x(i),prediction_x(i));
end
plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,fliplr(lower)],color),'EdgeColor',color);
plot_variance(prediction_x,mean-1.96*variance,mean+1.96*variance,[0.9 0.9 0.9])
hold on
set(plot(prediction_x,mean,'k'),'LineWidth',2)

% now, we would like to sample from a Gaussian Process defined by this
% kernel. First, for the subset of points we are interested to plot, we
% construct the kernel matrix (using our kernel function)
K=zeros(length(prediction_x),length(prediction_x));
for i=1:length(prediction_x)
    for j=i:length(prediction_x)%We only calculate the top half of the matrix. This is an unnecessary speedup trick
        K(i,j)=k(prediction_x(i),prediction_x(j));
    end
end
K=K+triu(K,1)'; % We can use the upper half of the matrix and copy it to the
%bottom, because it is symetrical

[V,D]=eig(K);
A=V*(D.^(1/2));

%Then, we use the kernel as the covariance matrix of a multivariate normal
clear gaussian_process_sample;
for i=1:7
    standard_random_vector = randn(length(prediction_x),1);
    gaussian_process_sample(:,i) = A * standard_random_vector;
end

plot(prediction_x,real(gaussian_process_sample))

%%

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, ['thesis/images/gp_prior.pdf'], 'pdf')

%% Demo #5 Gaussian Process Regression %%
%initialize observations
X_o = [-1.5 -1 -0.75 -0.4 -0.3 0]';
Y_o = [-1.6 -1.3 -0.5 0 0.3 0.6]';

X_o = [-1.5 0.5]';
Y_o = sin(X_o);

K = zeros(length(X_o));
for i=1:length(X_o)
    for j=1:length(X_o)
        K(i,j)=k(X_o(i),X_o(j));
    end
end

%note that we use kernel_function, not kernel_function+error_function, when incorporating points other than noisy measurements
K_ss=zeros(length(prediction_x),length(prediction_x));
for i=1:length(prediction_x)
    for j=i:length(prediction_x)%We only calculate the top half of the matrix. This an unnecessary speedup trick
        K_ss(i,j)=kernel_function(prediction_x(i),prediction_x(j));
    end
end
K_ss=K_ss+triu(K_ss,1)'; % We can use the upper half of the matrix and copy it to the

K_s=zeros(length(prediction_x),length(X_o));
for i=1:length(prediction_x)
    for j=1:length(X_o)
        K_s(i,j)=kernel_function(prediction_x(i),X_o(j)); 
    end
end

Mu = (K_s/K)*Y_o;
Sigma = 1.96*sqrt(diag(K_ss-K_s/K*K_s'));

figure
plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,fliplr(lower)],color),'EdgeColor',color);
plot_variance(prediction_x,(Mu-Sigma)',(Mu+Sigma)',[0.8 0.8 0.8])
hold on
set(plot(prediction_x,Mu,'k-'),'LineWidth',2)
set(plot(X_o,Y_o,'r.'),'MarkerSize',15)

% this gives a poor model, because we aren't using good parameters to model
% the function. In order to get better parameters, we can maximize evidence
evidence = exp((Y_o'/K*Y_o+log(det(K))+length(Y_o)*log(2*pi))/-2);
%title (['this plot has evidence ' num2str(evidence)])

%legend('confidence bounds','mean','data points','location','SouthEast')

clearvars -except k prediction_x K X_o Y_o

%We can also sample from this posterior, the same way as we sampled before:
K_ss=zeros(length(prediction_x),length(prediction_x));
for i=1:length(prediction_x)
    for j=i:length(prediction_x)%We only calculate the top half of the matrix. This an unnecessary speedup trick
        K_ss(i,j)=k(prediction_x(i),prediction_x(j));
    end
end
K_ss=K_ss+triu(K_ss,1)'; % We can use the upper half of the matrix and copy it to the

K_s=zeros(length(prediction_x),length(X_o));
for i=1:length(prediction_x)
    for j=1:length(X_o)
        K_s(i,j)=k(prediction_x(i),X_o(j));
    end
end

[V,D]=eig(K_ss-K_s/K*K_s');
A=real(V*(D.^(1/2)));

for i=1:7
    standard_random_vector = randn(length(A),1);
    gaussian_process_sample(:,i) = A * standard_random_vector+K_s/K*Y_o;
end
hold on
plot(prediction_x,real(gaussian_process_sample))

set(plot(X_o,Y_o,'r.'),'MarkerSize',20)

%%

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, ['thesis/images/gp_posterior.pdf'], 'pdf')