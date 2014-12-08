function [  ] = imageTrainedModel( predict, N, maxVal, minVal, savePath )

if nargin < 3 
    maxVal = 5;
end

if nargin < 4 
    minVal = -maxVal;
end

if nargin < 5
    savePath = 0;
end

if nargin < 2
    error('Incorrect number of parameter. 2 are mandatory. Example: plotTrainedModel( mdl, 100 )');
end

linX = linspace(minVal,maxVal,N);
[XS, YS] = meshgrid(linX,linX);
ZS = zeros(N,N);

X2 = [XS(:) YS(:)];
ZS = predict(X2);
ZS = reshape(ZS, [N N]);

f = figure;
image(-linX, -linX, ZS);
savefig(savePath);
saveas(f, savePath, 'png');

end

