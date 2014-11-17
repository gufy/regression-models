function [  ] = plotAll( from, to, cols )
%PLOTALL Plot all functions from f_{from} to f_{to}
%   

if nargin < 3
    cols = 5;
end

if nargin < 2
    to = 23;
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
        subplot(rows*2, cols, I);
        plot3d(str2func(strcat('f', int2str(no))));
        
        subplot(rows*2, cols, rows*cols+I);
        plot3d(str2func(strcat('f', int2str(no))), 2);
    catch
        fprintf('Cannot plot3d f%d\n', no);
    end
end

end

