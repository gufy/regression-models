function [  ] = plotAll( from, to, cols )
%PLOTALL Plot all functions from f_{from} to f_{to}
%   

if nargin < 3
    cols = 5;
end

if nargin < 2
    to = 24;
end

if nargin < 1
    from = 15;
end

num = to - from + 1;
rows = ceil(num / cols);

figure;
for I = 1:num
    no = I + from - 1;
    try 
        fprintf('plot3d f%d at %d and %d\n', no, I, rows*cols+I);
        sh=subplot(rows*2, cols, I);
        plot3d(str2func(strcat('f', int2str(no))));
        set(sh,'zdir','reverse');
        
        sh=subplot(rows*2, cols, rows*cols+I);
        plot3d(str2func(strcat('f', int2str(no))), 2);
        set(sh,'zdir','reverse');
    catch
        fprintf('Cannot plot3d f%d\n', no);
    end
end

end

