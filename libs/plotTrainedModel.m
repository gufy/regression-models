function [  ] = plotTrainedModel( predict, N, maxVal, minVal )

if nargin < 3
    maxVal = 5;
end

if nargin < 4
    minVal = -maxVal;
end

if nargin < 2
    error('Incorrect number of parameter. 2 are mandatory. Example: plotTrainedModel( mdl, 100 )');
end

[XS, YS] = meshgrid(linspace(minVal,maxVal,N),linspace(minVal,maxVal,N));
ZS = zeros(N,N);

X2 = [XS(:) YS(:)];
ZS = predict(X2);
ZS = reshape(ZS, [N N]);

mesh(XS, YS, ZS);

end

