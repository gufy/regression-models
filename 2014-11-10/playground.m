%%

%plot3d(@(x, x_opt, f_opt, R, Q) f_16(x, x_opt,f_opt, R,Q));

subplot(2,2,1);
plot3d(@f_15);

subplot(2,2,2);
plot3d(@f_16);

subplot(2,2,3);
plot3d(@f_17);

%%

plot3d(@f_15);

%%

plot3d(@f_17);