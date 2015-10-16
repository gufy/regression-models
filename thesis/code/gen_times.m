
time = import_time('time_forests');
boxplot(time.time, time.dim);
xlabel('Dimensions');
ylabel('Time [s]');
title('Random forests');
clear time;

set(gca,'FontSize', 16);
set(gcf, 'PaperPosition', [0.25 0.1 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [6 5.75]); %Keep the same paper size
saveas(gcf, ['thesis/images/forests_time.pdf'], 'pdf');

input('Press Enter to continue');

%%

time = import_time('time_rbf');
time = time(time.time < 6*10^3,:);
time = time(time.time > 1*10^3,:);
boxplot(time.time, time.dim);
xlabel('Dimensions');
ylabel('Time [s]');
title('RBF');
clear time;

set(gca,'FontSize', 16);
set(gcf, 'PaperPosition', [0.25 0.1 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [6 5.75]); %Keep the same paper size
saveas(gcf, ['thesis/images/rbf_time.pdf'], 'pdf');

input('Press Enter to continue');

%%

time = import_time('time_gp');
time = time(time.time < 1.5*10^4,:);
boxplot(time.time, time.dim);
xlabel('Dimensions');
ylabel('Time [s]');
title('Gaussian processes');
clear time;

set(gca,'FontSize', 16);
set(gcf, 'PaperPosition', [0.25 0.1 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [6 5.75]); %Keep the same paper size
saveas(gcf, ['thesis/images/gp_time.pdf'], 'pdf');

input('Press Enter to continue');

%%

time = import_time('time_poly');
boxplot(time.time, time.dim);
xlabel('Dimensions');
ylabel('Time [s]');
title('Polynomial regression');
set(gca,'YScale','log');
clear time;

set(gca,'FontSize', 16);
set(gcf, 'PaperPosition', [0.25 0.1 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [6 5.75]); %Keep the same paper size
saveas(gcf, ['thesis/images/poly_time.pdf'], 'pdf');

input('Press Enter to continue');

%%

time = import_time('time_svm');
boxplot(time.time, time.dim);
xlabel('Dimensions');
ylabel('Time [s]');
title('Support vector regression');
set(gca,'YScale','log');
clear time;

set(gca,'FontSize', 16);
set(gcf, 'PaperPosition', [0.25 0.1 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [6 5.75]); %Keep the same paper size
saveas(gcf, ['thesis/images/svm_time.pdf'], 'pdf');