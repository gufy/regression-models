function [ params, uniq ] = paramsFromTable( Data )

    uniq = struct();
    params = struct();

    for I = 1:length(Data.Parameters)
        pars = strsplit(Data.Parameters{I}, ',');
        for J = 1:length(pars)
            par = strsplit(pars{J},'=');
            key = par{1};

            if strcmp(key, 'eq')
                key = 'eg';
            end

            if ~isfield(uniq, key)
                uniq.(key) = [];
            end

            if ~isfield(params, key)
                params.(key) = {};
            end

            if sum(uniq.(key) == str2num(par{2})) == 0
                uniq.(key) = [uniq.(key) str2num(par{2})]; 
                uniq.(key) = sort(uniq.(key));
            end

            params.(key){length(params.(key)) + 1} = str2num(par{2});

        end
    end

end

