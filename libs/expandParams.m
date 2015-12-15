function [ p ] = expandParams( P )

index=arrayfun(@(p) (1:length(p.values)), ...
                P, 'UniformOutput', false);
[index{:}]=ndgrid(index{:});

structarg=[{P.name}; ...
           arrayfun(@(p,idx) (p.values(idx{1})), ...
                   P, index, 'UniformOutput', false)];
p=struct(structarg{:});
clear index structarg
% Optinal reshapping structure in row
p=reshape(p,1,[]);

end

