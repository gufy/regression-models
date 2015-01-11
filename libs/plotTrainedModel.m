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
[ZS, StdTr] = predict(X2);

if 0 && ~isempty(StdTr)
    hold on;
    
    if size(StdTr, 2) == 1
        XU = ZS' + StdTr';
        XL = ZS' - StdTr';
    else
        XU = StdTr(:,1)';
        XL = StdTr(:,2)';
    end

    XU = reshape(XU, [N N]);
    XL = reshape(XL, [N N]);
    
    me = mesh(XS, YS, XU);
    set(me,'FaceColor',[1 0 0],'FaceAlpha',0.5);
    
    me = mesh(XS, YS, XL);
    set(me,'FaceColor',[1 0 0],'FaceAlpha',0.5);
    
end

ZS = reshape(ZS, [N N]);
f = fig;
mesh(XS, YS, ZS);
hold off;

if savePath
    savefig(savePath);
    saveas(f, savePath, 'png');
end

end

