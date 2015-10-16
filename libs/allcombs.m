function combMat = allcombs(varargin)
%   allcombs(varargin) each parameter is a cell of values, the result of
%   this function is a matrix of all combinations of values.
%
%   Example:
%       >> allcombs({1,2}, {3,4})
%       ans = 
%       [1]    [3]
%       [1]    [4]
%       [2]    [3]
%       [2]    [4]


  sizeVec = cellfun('prodofsize', varargin);
  indices = fliplr(arrayfun(@(n) {1:n}, sizeVec));
  [indices{:}] = ndgrid(indices{:});
  combMat = cellfun(@(c,i) {reshape(c(i(:)), [], 1)}, ...
                    varargin, fliplr(indices));
  combMat = [combMat{:}];
end