function [ output ] = explodeStruct( my_struct, values, keys )
% explodeStruct( my_struct, values, keys )
%       It extend struct my_struct with new values which are set to keys.
%
%   Parameters
%       my_struct       a struct to be extended, can be empty, i.e.
%                       struct()
%       values          a matrix of numbers, for each row a new struct is
%                       created, i-th element from row is set to i-th key
%                       from keys
%       keys            labels for new fields 
%
%   Returns
%       output          an array of structs, each struct is based on
%                       my_struct, it has new keys with values
%

fields = fieldnames(my_struct);
output = my_struct;

for I = 1:size(values,1)
    
    for k=1:numel(fields)
        output(I).(fields{k}) = my_struct.(fields{k});
    end
    
    for J = 1:length(keys)
        output(I).(keys{J}) = values(I, J);
    end
    
    if length(keys) < size(values, 2)
        J = length(keys);
        for K = (J+1):size(values, 2)
            output(I).(keys{J}) = [output(I).(keys{J}) values(I, K)];
        end
    end
    
end

end

