%%

load moore.mat

%%

tmp.y = moore(:,6);
tmp.x = moore(:,1:5);
sample_size = length(tmp.y);
tenth = int16(sample_size/10);
sample = randsample(length(tmp.y), sample_size);
test_indices = randsample(sample_size, tenth);
train_indices = setdiff(1:sample_size, test_indices);

data1.y = tmp.y(sample);
data1.x = tmp.x(sample,:);

data1.y_tr = data1.y(train_indices);
data1.y_tst = data1.y(test_indices);
data1.x_tr = data1.x(train_indices,:);
data1.x_tst = data1.x(test_indices,:);

%%

NTrees = 10
B = TreeBagger(NTrees,data1.x_tr,data1.y_tr,'method','regression');
B.Trees{1}

%%

good = y' == data1.y_tst;
sum(good)/length(good)

%%

mdl = fitlm(data1.x_tr,data1.y_tr);

%%

figure;
for i = 1:5 
    subplot(2,3,i)
    scatter(tmp.x(:,i), tmp.y)
end

%%

NTrees = 10
B = TreeBagger(NTrees,data1.x_tr(:,1),data1.y_tr,'method','regression');
B.Trees{1}


