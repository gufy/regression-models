function [ output ] = explodeStruct( my_struct, values, keys )

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

