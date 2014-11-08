load('data/wine.mat');

%%

scatter(wine.quality, wine.alcohol);

%%

scatter(wine.quality, wine.pH);


%%

data1 = make_data(X, y);

%%

%T1 = classregtree(data2.x_tr, data2.y_tr);
T1 = classregtree(data1.x_tr, data1.y_tr, 'method', 'regression');

y2 = T1.eval(data1.x_tst);
sum(abs((y2 - data1.y_tst))) / length(y2)

%%

