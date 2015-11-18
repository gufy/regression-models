function [ errors ] = fivewayEvaluation( func_no, model_name, samples, params )

D = 2;
N = 15*D;
NumSamples = length(samples);

C{1} = [   0;   0];
C{2} = [ 2.5; 2.5];
C{3} = [-2.5; 2.5];
C{4} = [ 2.5;-2.5];
C{5} = [-2.5;-2.5];

for I = 1:NumSamples
    samples{I} = rand(D, N)*2 - 1 + repmat(C{I}, 1, N);
end

errors = zeros(NumSamples, 1);
for S = 1:NumSamples

    X = samples{S};
    Y = benchmarks(X, func_no);

    [ test_err, train_err, kendall, test_err_s, train_err_s, kendall_s, time ]... 
        = crossValidateModel(model_name, X', Y', params);

    errors(S) = test_err;

end

end

