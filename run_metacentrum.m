function run_metacentrum(exppath_short, settings_script)

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

eval(settings_script);

i = 1;
for ModelIndex = 1:length(models)
    for ParamIndex = 1:length(models{ModelIndex}.params)
        ident = [int2str(ModelIndex) '-' int2str(ParamIndex)];
        model = struct('name', models{ModelIndex}.name, 'model', models{ModelIndex}.model, 'params', models{ModelIndex}.params(ParamIndex));
        % {func_no, D, N, id, models, noisy}
        tasks(i) = createTask(job, @comp_f_id, 0, {15, 2, 200, ident, {model}, 0, exppath_short});
        i = i + 1;
    end
end

tasks

submit(job)
  
end