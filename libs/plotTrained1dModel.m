function [ f, h ] = plotTrained1dModel( predict, N, maxVal, minVal, savePath, fig, Xbw, Ybw)

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

if nargin < 7
    Xbw = 0;
end

if nargin < 8
    Ybw = 0;
end

if nargin < 2
    error('Incorrect number of parameter. 2 are mandatory. Example: plotTrainedModel( mdl, 100 )');
end

XS = linspace(minVal, maxVal, N)';
y = zeros(N, 1);

try 
    [y, StdTr] = predict(XS);
catch 
    StdTr = 0;
    y = predict(XS);
end

if isempty(y)
    StdTr = 0;
    y = predict(XS);
end

if isa(Xbw, 'function_handle')
    XS = Xbw(XS);
end

if ~isempty(StdTr) && length(StdTr) > 1
    hold on;
    
    if size(StdTr, 2) == 1
        XU = y' + StdTr';
        XL = y' - StdTr';
    else
        XU = StdTr(:,1)';
        XL = StdTr(:,2)';
    end
    
    if isa(Ybw, 'function_handle')
        XU = Ybw(XU);
        XL = Ybw(XL);
    end
    
    %plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor',color);
    
    f = [XU'; XL(end:-1:1)']; 
    h = fill([XS; XS(end:-1:1)], f, [0.4 0.6 0.7]);
    set(h,'FaceAlpha',0.15,'EdgeAlpha',0.3);
    plot(XS, XU, 'Color',  [0.4 0.6 0.7]);
    plot(XS, XL, 'Color',  [0.4 0.6 0.7]);
    
end

if isa(Ybw, 'function_handle')
    y = Ybw(y);
end

f = fig;
h = plot(XS, y);
hold off;

if savePath
    savefig(savePath);
    saveas(f, savePath, 'png');
end

end

