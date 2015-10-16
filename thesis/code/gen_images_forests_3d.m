%% 

display('Drawing sample 3d function');

[X, Y] = meshgrid(-1:0.1:1, -1:0.1:1);
Z = X .* exp(-X.^2 - 2*Y.^2);
surf(X,Y,Z);

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, ['thesis/images/rtree_fun.pdf'], 'pdf');

input('Press Enter to continue ...');

%%

display('Computing regression tree model.');

X = rand(40,2) * 2 - 1;
Y = X(:,1) .* exp(-X(:,1).^2 - 2*X(:,2).^2);
Tree = fitrtree(X, Y);

input('Press Enter to continue ...');

%%

display('Drawing approximated function by the computed model.');

colormap(jet);
[X, Y] = meshgrid(-1:0.1:1, -1:0.1:1);
Z = Tree.predict([X(:) Y(:)]);
Z = reshape(Z, 21, 21);
surf(X, Y, Z);

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, ['thesis/images/rtree_res.pdf'], 'pdf')

input('Press Enter to continue ...');

view([-90 90])
camroll(90)

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, ['thesis/images/rtree_part.pdf'], 'pdf')

input('Press Enter to continue ...');

view(Tree, 'mode', 'graph')

set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, ['thesis/images/rtree_tree.pdf'], 'pdf')
