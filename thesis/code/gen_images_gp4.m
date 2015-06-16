
for KernelNo = 1:4

    if KernelNo == 1 % linear
        sigma_f = 0.6;
        c = 1; 
        kernel_function = @(x,x2) sigma_f^2*(x-c)*(x2 - c);
        name = 'linear';
    end
   
    if KernelNo == 2 % periodic
        sigma_f = 0.6;
        p = 1;
        l = 4;
        kernel_function = @(x,x2) sigma_f^2*exp(-2/l^2 * sin(pi*abs(x-x2)/p)^2);
        name = 'periodic';
    end
    
    if KernelNo == 3 % SE
        sigma_f = 0.6; 
        l = 1;
        kernel_function = @(x,x2) sigma_f^2*exp((x-x2)^2/(-2*l^2));
        name = 'SE';
    end
    
    if KernelNo == 4 % RQ
        sigma_f = 0.6;
        l =  1; 
        alpha = 1/2;
        kernel_function = @(x,x2) sigma_f^2*(1 + (x-x2)^2/(2*alpha*l^2))^(-alpha);
        name = 'RQ';
    end
    
    
    
    % prior distribution

    sigma_n = 0.0; %known noise on observed data
    error_function = @(x,x2) sigma_n^2*(x==x2); 
    k = @(x,x2) kernel_function(x,x2);%+error_function(x,x2);

    prediction_x=-1:0.05:1;
    for i=1:length(prediction_x)
        mean(i) = 0;
        variance(i) = k(prediction_x(i),prediction_x(i));
    end

    K=zeros(length(prediction_x),length(prediction_x));
    for i=1:length(prediction_x)
        for j=i:length(prediction_x)%We only calculate the top half of the matrix. This is an unnecessary speedup trick
            K(i,j)=k(prediction_x(i),prediction_x(j));
        end
    end
    K=K+triu(K,1)'; 

    figure;
    imagesc(K);

    % save

    set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
    set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
    saveas(gcf, ['thesis/images/gp_kernel_', name, '.pdf'], 'pdf')

end
