function [ str ] = datetimestr( )
% datetimestr() converts current datetime to a nice string
%
%   Returns
%       str     a time formated as YYYYmmdd-HHMMSS
%
%   Example
%       display(datetimestr())

str = datestr(datetime, 'YYYYmmdd-HHMMSS');

end

