function [  ] = plotTrainedModel( predict, N, maxVal, minVal, savePath, fig )

if nargin < 3 
    maxVal = 5;
end

if nargin < 4 
    minVal = -maxVal;
end

if nargin < 5
    savePath = 0;
end

if nargin < 6
    fig = figure;
end

if nargin < 2
    error('Incorrect number of parameter. 2 are mandatory. Example: plotTrainedModel( mdl, 100 )');
end

if size(minVal, 2) == 2
    minValX = minVal(1);
    minValY = minVal(2);
else
    minValX = minVal;
    minValY = minVal;
end

if size(maxVal, 2) == 2
    maxValX = maxVal(1);
    maxValY = maxVal(2);
else
    maxValX = maxVal;
    maxValY = maxVal;
end


[XS, YS] = meshgrid(linspace(minValX,maxValX,N),linspace(minValY,maxValY,N));
ZS = zeros(N,N);

X2 = [XS(:) YS(:)];
ZS = predict(X2);
ZS = reshape(ZS, [N N]);

f = fig;
mesh(XS, YS, ZS);

if savePath
    savefig(savePath);
    saveas(f, savePath, 'png');
end

end

