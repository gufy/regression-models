I = 0;

I = I + 1;
models{I} = struct('name', 'GP (SEard)', 'model', @gpSim);
covParams = [0]; %[1; 1.5];
covParams = [repmat({covParams}, 1, D) {[1]}];
snParams = [0.01; 0.1; 1; 1.1; 1.2; 1.5; 1.75; 2; 4];
models{I}.params = explodeStruct(struct('fun', @covSEard), allcombs( snParams , covParams{:}), {'sn', 'cov'});


I = I + 1;
models{I} = struct('name', 'GP (SEiso)', 'model', @gpSim);
covParams = [0]; %[];
covParams = [covParams {[1]}];
snParams = [0.01; 0.1; 1; 1.1; 1.2; 1.5; 1.75; 2; 4];
models{I}.params = explodeStruct(struct('fun', @covSEiso), allcombs( snParams , covParams{:}), {'sn', 'cov'});

