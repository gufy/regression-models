function [ M ] = linspacem( val_max, val_min, N, D )

vec = linspace(val_min, val_max, N);
[out{1:D}] = ndgrid(vec);

M = zeros(N^D, D);
for i = 1:D 
    M(:,i) = out{i}(:);
end

end

