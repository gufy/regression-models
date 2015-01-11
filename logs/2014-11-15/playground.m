%%

C(:,:,1) = ones(3,3) * 1;
C(:,:,2) = ones(3,3) * 2;
C(:,:,3) = ones(3,3) * 3;

%%

x = 0:0.0001:0.25;
y = zeros(size(x));

for k = 1:length(x)
    D = 1;
    z = x(k);
    z_sum = 0;
    for i = 1:32
        z_sum = z_sum + abs( 2 ^ i * z - round( 2 ^ i * z ) ) / 2 ^ i;
    end

    y_ = 10 / (D ^ 2) * prod( 1 + (1:D) .* z_sum' ) ^ (10 / D ^ 1.2) - 10 / D ^ 2 + f_pen(x);
    y(k) = y_;
end

plot(x,y);
