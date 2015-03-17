function [ string_out ] = struct2str( struct_in, delimiter )

if nargin < 2
    delimiter = ',';
end

fields = fieldnames(struct_in);
string_out = '';
for J = 1:numel(fields)
    key = fields{J};
    if ischar(struct_in.(key))
        value = struct_in.(key);
    else
        if isa(struct_in.(key), 'function_handle')
            value = func2str(struct_in.(key));
        else
            value = num2str(struct_in.(key));
        end
    end
    
    string_out = [string_out, key, '=', value];
    
    if J < numel(fields) 
        string_out = [string_out, delimiter];
    end
end

end

