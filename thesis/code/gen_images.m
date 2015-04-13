%% overfitting and underfitting
figure;
lin = -4:0.1:4;
sin_y = sin(lin);
plot(lin, sin_y);
hold on;

N = 10;
X = rand(1,N)*8-4;
T = sin(X) + randn(1, N)*0.25;
scatter(X, T);
axis([-4 4 -2 2]);
hold off;

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, 'thesis/images/fitting_setup.pdf', 'pdf')

% fit quadratic regression
figure;
lin = -4:0.1:4;
sin_y = sin(lin);
plot(lin, sin_y);
hold on;

p = polyfit(X, T, 2);
Y = polyval(p, lin);
scatter(X, T);
plot(lin, Y);
axis([-4 4 -2 2]);
hold off;

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, 'thesis/images/underfitting.pdf', 'pdf')

% fit cubic regression
figure;
lin = -4:0.1:4;
sin_y = sin(lin);
plot(lin, sin_y);
hold on;

p = polyfit(X, T, 3);
Y = polyval(p, lin);
scatter(X, T);
plot(lin, Y);
axis([-4 4 -2 2]);
hold off;

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, 'thesis/images/fitting.pdf', 'pdf')

% fit higher polynom regression
figure;
lin = -4:0.1:4;
sin_y = sin(lin);
plot(lin, sin_y);
hold on;

p = polyfit(X, T, 6);
Y = polyval(p, lin);
scatter(X, T);
plot(lin, Y);
axis([-4 4 -2 2]);
hold off;

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, 'thesis/images/overfitting.pdf', 'pdf')
