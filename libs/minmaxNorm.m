function [ res, fw, bw ] = minmaxNorm( X )
%MINMAXNORM Nin-max normalization of data into [0, 1] interval
%   

if (size(X,1) > 1 && size(X, 2) > 1) 
    res = zeros(size(X));
    fw = {};
    bw = {};
    
    for I = 1:size(X,2)
        [ r_, f_, b_ ] = minmaxNorm( X(:, I) );
        res(:, I) = r_;
        fw{I} = f_;
        bw{I} = b_;
    end
else
    Mx = max(X);
    Mn = min(X);

    if Mx == Mn
        Mx = Mn + 1;
    end

    fw = @(x) (x - Mn) ./ (Mx - Mn); 
    bw = @(x) x * (Mx - Mn) + Mn;
    res = fw(X);
end

end

