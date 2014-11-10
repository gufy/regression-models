
D = 2;
N = 100;

x_opt_val = x_opt(D);
f_opt_val = f_opt();

X = zeros(D, N);
Y = zeros(N, 1);

for i = 1:N
    
    x = rand(D,1)*10 - 5;
    X(:, i) = x;
    
    y = f_1(x, x_opt_val, f_opt_val);
    Y(i) = y;
    
end

[XS, YS] = meshgrid(-5:0.5:5,-5:0.5:5);
ZS = griddata(X(1,:),X(2,:),Y, XS, YS);
mesh(XS, YS, ZS);

%scatter3(X(1,:), X(2,:), Y);

%%

D = 2;
N = 10000;

x = rand(D,1)*10 - 5;
x_opt_val = x_opt(D);
f_opt_val = f_opt();
[Q, R] = qr(randn(D));

X = zeros(D, N);
Y = zeros(N, 1);
    
for i = 1:N
    
    x = rand(D,1)*10 - 5;
    X(:, i) = x;
    
    y = f_15(x, x_opt_val, f_opt_val, R, Q);
    Y(i) = y;
    
end

xscale = -3:0.05:3 + x_opt_val(1);
yscale = -3:0.05:3 + x_opt_val(2);
[XS, YS] = meshgrid(xscale,yscale);
ZS = griddata(X(1,:),X(2,:),Y, XS, YS);
meshc(XS, YS, ZS);

%%

D = 2;
N = 5000;

range = 5;
xmin = -range; xmax = range;
ymin = -range; ymax = range;

x_opt_val = zeros(D,1);%x_opt(D);
f_opt_val = f_opt();
[Q, R] = qr(randn(D));

X = zeros(D, N);
Y = zeros(N, 1);
    
for i = 1:N
    
    x = rand(D,1)*(xmax - xmin) + xmin;
    X(:, i) = x;
    
    y = f_16(x, x_opt_val, f_opt_val, R, Q);
    Y(i) = y;
    
end

xscale = xmin:0.05:xmax + x_opt_val(1);
yscale = ymin:0.05:ymax + x_opt_val(2);
[XS, YS] = meshgrid(xscale,yscale);
ZS = griddata(X(1,:),X(2,:),Y, XS, YS);
meshc(XS, YS, ZS);
axis([xmin xmax ymin ymax]);
