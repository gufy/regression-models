function [ ] = comp_f_id( func_no, D, N, id, models, noisy, exppath )
% comp_f( func_no, D, N, settings_script, noisy )
%       Start experiments using function with number func_no with D
%       dimensions and size of data set N. Models are defined in script
%       settings_script. Choose noisy=1, if you wish to add a noise to the
%       data set.
%
%       Notice that the settings_script does not contain a path to the
%       script, but it is a name of the script which is being run.
%
%   Example:
%       >> comp_f(15,2,500,'settings_example')
%

setup;

try
    setup_mail;
    display(['Computation started using ', func2str(@minimize), func2str(@gpSim)])
catch
    display('Cannot initiate mail. Skipping.');
end

%%

if nargin < 7
    noisy = 0;
end
 
% get rid of some mess from bash
D = str2double(int2str(D));
N = str2double(int2str(N));
func_no = str2double(int2str(func_no));
rng(1,'twister');

%%

func_name = strcat('f', int2str(func_no));
X = rand(D, N)*10 - 5;
Y = benchmarks(X, func_no);
X = X';
Y = Y';
rng('shuffle');

%%

system('ulimit -t unlimited');
dataset_name = [func_name,'-', int2str(D), 'd-', int2str(N)];
name = [dataset_name, '-', id, '-', datetimestr];
fprintf('\n[%s %dd %d]\n------\n', func_name, D, N);

%%

try
    results = crossValidateModelsWithParams(models, X, Y, @(model_name, test_err, train_err, kendall, params, time) ...
        store(model_name, dataset_name, datetimestr, params,... 
            struct( 'error_test_mean', test_err(1), 'error_test_sigma', test_err(2),... 
                    'error_train_mean', train_err(1), 'error_train_sigma', train_err(2),...
                    'kendall_mean', kendall(1), 'kendall_sigma', kendall(2)), time, noisy) ...
    );
catch e
    sendmail('vojtech.kopal@gmail.com', ['MATLAB Results: ', name], getReport(e));
end

%%

try     
    sendmail('vojtech.kopal@gmail.com', ['MATLAB Results: ', name], 'Computation done.', ['data/',name,'.mat']); 
catch
    display('Could not sent email with result. Skipping.');
end

try
    if exist('data', 'dir') == 0
        mkdir('data');
    end

    save(['data/',name,'.mat'], 'results', 'models');
catch
    display('Could not sent save result. Skipping.');
end

end

