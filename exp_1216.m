load_exp_params;
p = expandParams(P);

%%

walltime = '4h';
 
pbs_max_workers = 50;
pbs_params = ['-l walltime=' walltime ',nodes=^N^:ppn=1,mem=1gb,scratch=1gb,matlab_MATLAB_Distrib_Comp_Engine=^N^'];

while 1
    [tf msg] = license('checkout','Distrib_Computing_Toolbox');
    if tf==1, break, end
    display(strcat(datestr(now),' waiting for licence '));
    pause(4);
end

cl = parallel.cluster.Torque;
pause(2);
[~, ~] = mkdir(exppath_short, '../matlab_jobs')
cl.JobStorageLocation = [exppath_short filesep '../matlab_jobs'];
cl.ClusterMatlabRoot = matlabroot;
cl.OperatingSystem = 'unix';
cl.ResourceTemplate = pbs_params;
cl.HasSharedFilesystem = true;
cl.NumWorkers = pbs_max_workers;

display('Creating job');
job = createJob(cl);

%%

len = length(p);
batchSize = 1000;
tic;
for I = 1:batchSize:len %len % how to iterate efficiently?
    params = p(I:min(len,I+batchSize-1));
    
    %eval_exp_and_save(params);
    display(['Create task: ', int2str(I), '/', int2str(len)]);
    createTask(job, @eval_batch, 0, {params});
    
end

submit(job)
toc
   
