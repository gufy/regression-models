function [ vec ] = lambda( alpha, D )

vec = eye(D);

for i = 1:D 
    vec(i,i) = alpha ^ ((1/2) * (i - 1) / (D - 1));
end

end

