function [ ] = plotData( X, Y )
%PLOTDATA Summary of this function goes here
%   Detailed explanation goes here

if size(X, 2) == 1
    scatter(X, Y);
else
    if size(X, 2) == 2
        scatter3(X(:,1), X(:,2), Y);
    else
        fprintf('Cannot %dd plot\n', size(X, 2));
    end
end

end

