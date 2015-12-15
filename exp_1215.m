clear;
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

job = createJob(cl);

%%

tic;
for I = 1:2 %length(p) % how to iterate efficiently?
    params = p(I);
    
    params = prepare_exp_params(params);
    %eval_exp_and_save(params);
    createTask(job, @eval_exp_and_save, 0, {params});
    
end
toc
   