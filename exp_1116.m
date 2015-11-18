clear;
D = 2;
N = 15*D;
NumSamples = 5;

C{1} = [   0;   0];
C{2} = [ 2.5; 2.5];
C{3} = [-2.5; 2.5];
C{4} = [ 2.5;-2.5];
C{5} = [-2.5;-2.5];

for I = 1:NumSamples
    samples{I} = rand(D, N)*2 - 1 + repmat(C{I}, 1, N);
end

func_no = 15;
func_name = strcat('f', int2str(func_no));


for S = 1:NumSamples

    f = figure;
    plot3d(func_no);
    hold on;
    N = 15*D;
    X = samples{S};
    Y = benchmarks(X, func_no);

    [ test_err, train_err, kendall, test_err_s, train_err_s, kendall_s, time ]... 
        = crossValidateModel('gpSim', X', Y', {});

    scatter3(X(1,:), X(2,:), Y, 'r.');

    fprintf('MSE=%f+-%f\n', test_err, test_err_s);

    hold off;

end