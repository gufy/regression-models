function [  ] = f_save2pdf( from, to, cols )
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

for I = 1:num
    no = I + from - 1;
    try 
        figure;
        fprintf('plot3d f%d at %d and %d\n', no, I, rows*cols+I);
        plot3d(str2func(strcat('f', int2str(no))));
        set(gca,'zdir','reverse');
        
        set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
        set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
        saveas(gcf, ['thesis/images/f', int2str(no), '.pdf'], 'pdf')
        
    catch
        fprintf('Cannot plot3d f%d\n', no);
    end
end

end

