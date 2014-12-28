function [ predict, err_tr ] = svmSim( X, T, params )

if nargin < 3
    params = {3, 2};
end

method = '';
for I = 1:length(params)
    if I == 1 
        method = [method '-s '];
    elseif I == 2
        method = [method '-t '];
    elseif I == 3
        method = [method '-g '];
    end
    
    method = [method num2str(params{I}) ' '];
end

len = size(X,1);
[Out, model] = evalc('svmtrain(T, X, method)');

if isempty(model)
    error(Out);
end

predict = @(x) svmpredict(zeros(size(x,1),1),x,model);
err_tr = (1/len) * sum((predict(X) - T).^2);

end

