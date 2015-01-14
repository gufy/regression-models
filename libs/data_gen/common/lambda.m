function [ vec ] = lambda( alpha, D, permute )

if nargin < 3 
    permute = 0;
end

if D == 1
    
    vec = 1;
    
else

    vec = eye(D);

    id = 1:D;

    if permute
        id = randperm(D);
    end

    for i = 1:D 
        vec(id(i),id(i)) = alpha ^ ((1/2) * (i - 1) / (D - 1));
    end
    
end

end

