function [ res, err_tr ] = svmSim( X, T, params )

if nargin < 3
    params.s = 3;
    params.t = 2;
end

fields = fieldnames(params);

method = '';

for i=1:numel(fields)
  field = fields{i};
  method = [method '-' field ' ' num2str(params.(field)) ' '];
end

len = size(X,1);
[Out, model] = evalc('svmtrain(T, X, method)');

if isempty(model)
    error(Out);
end

predict = @(x) svmpredict(zeros(size(x,1),1),x,model);
err_tr = (1/len) * sum((predict(X) - T).^2);

res.predict = predict;
res.model = model;

end

