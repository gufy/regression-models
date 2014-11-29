function [ ] = plotData( X, Y )
%PLOTDATA Summary of this function goes here
%   Detailed explanation goes here

if size(X, 2) == 1
    plot(X, Y);
else
    if size(X, 2) == 2
        [XS, YS] = meshgrid(X(1,:),X(:,2));
        ZS = reshape(Y,[length(ran) length(ran)]);
        mesh(XS, YS, ZS);
    else
        fprintf('Cannot %dd plot\n', size(X, 2));
    end
end

end

