me = mfilename;                                            % what is my filename
mydir = which(me); mydir = mydir(1:end-2-numel(me));        % where am I located
addpath(mydir(1:end-1))
addpath([mydir,'libs'])
addpath([mydir,'libs','data-gen'])
addpath([mydir,'libs','data-gen','common'])
addpath([mydir,'sims'])