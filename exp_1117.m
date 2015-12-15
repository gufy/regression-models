err = zeros(length(samples), 50);
for I = 1:10 
    fprintf('\n---\n%d / %d\n---\n', I, 50);
    err(:,I) = fivewayEvaluation(15, 'gpSim', samples, struct('sn', 0.1));
end

boxplot(err(:,1:10)');