x = -3:.1:3;
a2 = radbas(x-1);
a3 = radbas(x+1.5);
a4 = a + a2*1.0 + a3*0.75;
plot(x,a,'--',x,a2,'--',x,a3,'--',x,a4)
xlabel('X');
ylabel('Y');

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, ['thesis/images/rbf_weighted.pdf'], 'pdf');

%%

P = rand(1,20)*8 - 4;
T = sin(P);
   
eg = 0.02; % sum-squared error goal
sc = .01;  % spread constant
net = newrb(P,T,eg,sc);

figure;
scatter(P,T);
X = -4:.01:4;
Y = net(X);
hold on;
plot(X,Y);
hold off;

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, ['thesis/images/rbf_underlapping.pdf'], 'pdf');

%%

eg = 0.02; % sum-squared error goal
sc = 100;  % spread constant
net = newrb(P,T,eg,sc);

figure;
scatter(P,T);
X = -4:.01:4;
Y = net(X);
hold on;
plot(X,Y);
hold off;

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, ['thesis/images/rbf_overlapping.pdf'], 'pdf');

%%

eg = 0.02; % sum-squared error goal
sc = 2.5;    % spread constant
net = newrb(P,T,eg,sc);

figure;
scatter(P,T);
X = -4:.01:4;
Y = net(X);
hold on;
plot(X,Y);
hold off;

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, ['thesis/images/rbf_fine.pdf'], 'pdf');