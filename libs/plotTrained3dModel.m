function [ f ] = plotTrained3dModel( model, N, maxVal, minVal, savePath, fig)
% plotTrained3dModel( model, N, maxVal, minVal, savePath, fig)
%   Plots a trained model in 3 dimensions. The model needs to be trained on
%   2 dimensional input data. By setting higher N parameter, the result is
%   smoother. The graph is drawn in interval [minVal, maxVal]x[minVal,
%   maxVal]. You may specify savePath where to save the graph as a PDF
%   file.
%   
%   The function allows to use existing figure via parameter fig.
%
%   Parameters
%       model:      a trained model, it needs to be an object that has a
%                   method predict(...)
%       N:          number of data points drawn uniformly from an interval
%                   [minVal, maxVal]x[minVal, maxVal]
%       maxVal:     upper bound for the interval, default 5
%       minVal:     lower bound for the interval, default -maxVal
%       savePath:   path to a destination where will be the figure save,
%                   default 0
%       fig:        figure handler which will be used instead of creating a
%                   new one
%
%   Returns
%       f:          a figure handler
%
%   Example:
%       >> mdl = polyfitSim(X,T,struct());
%       >> plotTrained3dModel(mdl, 40);
%

if nargin < 3 
    maxVal = 5;
end

if nargin < 4 
    minVal = -maxVal;
end

if nargin < 5
    savePath = 0;
end

if nargin < 6 || fig == 0
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

[ZS, StdTr] = model.predict(X2);

if (isempty(ZS))
    ZS = model.predict(X2);
end

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

