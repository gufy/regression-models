function [ data ] = make_data( X, y )
%MAKE_DATA Summary of this function goes here
%   Detailed explanation goes here

tmp.y = y;
tmp.x = X;
sample_size = length(tmp.y);
tenth = int16(sample_size/10);
sample = randsample(length(tmp.y), sample_size);
test_indices = randsample(sample_size, tenth);
train_indices = setdiff(1:sample_size, test_indices);

data.y = tmp.y(sample);
data.x = tmp.x(sample,:);

data.y_tr = data.y(train_indices);
data.y_tst = data.y(test_indices);
data.x_tr = data.x(train_indices,:);
data.x_tst = data.x(test_indices,:);

end

