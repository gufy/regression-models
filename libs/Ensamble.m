classdef Ensamble

    
    properties
        sizes % number of classifiers
        frac 
        C % classifiers
        weights
        labels % class labels
    end
    
    methods
        
        function K=Ensamble(s, data, f, fits)
            if nargin < 2
                error('Malo vstupnich parametru');
            elseif nargin < 3 
                K.frac = 1;
            else 
                K.frac = f;
            end
            
            K.sizes = s;
            K.labels = unique(data.y_tr);
            
            for i=1:length(K.sizes)
                for j=1:K.sizes(i)
                    mask = rand(1, length(data.y_tr)) < K.frac;
                    K.C{i, j} = fits{i}(data.x_tr(mask,:), data.y_tr(mask), j);
                    
                    y = K.C{i, j}.predict(data.x_tr(~mask,:));
                    
                    good = y == data.y_tr(~mask);
                   
                    K.weights{i, j} = sum(good)/length(good);
                    
                end
            end
            
        end
        
        
        function [y,pr,a]=predict(K, data)
            
            Y=zeros(sum(K.sizes), length(data.y_tst));
            W=ones(sum(K.sizes));
            
            for i=1:length(K.sizes)
                for j=1:K.sizes(i)
                    id = (i-1)*K.sizes(i)+j;
                   
                    y2 = K.C{i, j}.predict(data.x_tst);
                  
                    
                    Y(id,:) = y2;
                    
                    W(id) = K.weights{i, j};
                end
            end
            
            a = zeros(length(data.y_tst),length(K.labels));
            for i=1:length(data.y_tst)
                for j=1:length(W)
                    y2 = Y(j,i);
                    if y2 > 0
                        a(i, y2) = a(i, y2) + W(j) / sum(K.sizes);
                    end
                end
            end
            
            %a = hist(Y,K.labels);
            [m, y] = max(a');
            pr = m / sum(K.sizes);
            
        end
        
    end
    
end

