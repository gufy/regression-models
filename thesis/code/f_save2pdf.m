function [  ] = f_save2pdf( from, to )
%Plot all functions from f_{from} to f_{to}. Show them in figures and save
% them into pdf. 
%
% Target paths:  thesis/images/f15.pdf
%   
%   Example:
%       >> f_save2pdf(15, 24)
%       Prints 3d graphs of functions 15 to 24 and

if nargin < 2
    to = 24;
end

if nargin < 1
    from = 15;
end

num = to - from + 1;

for I = 1:num
    no = I + from - 1;
    try 
        figure;
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

