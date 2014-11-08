
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

xscale = -5:0.05:5 + x_opt_val(1);
yscale = -5:0.05:5 + x_opt_val(2);
[XS, YS] = meshgrid(xscale,yscale);
ZS = griddata(X(1,:),X(2,:),Y, XS, YS);
meshc(XS, YS, ZS);
