function [ dir ] = runSimulations( sims, simsParams, simsDatasets )
%RUNSIMULATIONS Main functions running all simulations
%   
% Sample usage:
%   runSimulations('nn', [], 'f15');

if ~iscell(sims)
    sims = {sims};
end

for i = 1:length(sims)
    
    sim = sims{i};
    fprintf('Running simulation %s\n', sim);
    
    
    
end

end

