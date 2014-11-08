classdef EnsambleKnn

    
    properties
        size % number of classifiers
        frac 
        C % classifiers
        labels % class labels
    end
    
    methods
        
        function K=EnsambleKnn(s, data, f)
            if nargin < 2
                error('Malo vstupnich parametru');
            elseif nargin < 3 
                K.frac = 1;
            else 
                K.frac = f;
            end
            
            K.size = s;
            K.labels = unique(data.y_tr);
            
            for i=1:K.size
                mask = rand(1, length(data.y_tr)) < K.frac;
                K.C{i} = ClassificationKNN.fit(data.x_tr(mask,:), data.y_tr(mask),'NumNeighbors',i);
            end
            
        end
        
        
        function y=predict(K, data)
            
            Y=zeros(K.size, length(data.y_tst));
            
            for i=1:K.size
                Y(i,:) = K.C{i}.predict(data.x_tst);
            end
            
            a = hist(Y,K.labels);
            [~, y] = max(a);
            
        end
        
    end
    
end

