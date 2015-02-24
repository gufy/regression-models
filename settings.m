I = 0;

I = I + 1;
models{I} = struct('name', 'SVM', 'model', @svmSim);
models{1}.params = {{3}, {2}, { 0.001, 0.01, 0.1, 1, 2, 5, 10, 15, 20, 30, 50, 100, 150, 200, 250, 300, 350, 400, 500, 600, 700}};

I = I + 1;
models{I} = struct('name', 'Poly', 'model', @polyfitSim);
models{I}.params = {{'quadratic'}};

I = I + 1;
models{I} = struct('name', 'RBF-NN', 'model', @nnSim);
models{I}.params = {{4,2,1.5,1.2,1.1,1,0.1,0.01,0.001},{ 0.00001},{150}};

I = I + 1;
models{I} = struct('name', 'Forests', 'model', @forestsSim);
models{I}.params = {num2cell(50:50:900), {1, 2, 5, 10, 20, 50}};

I = I + 1;
models{I} = struct('name', 'GP', 'model', @gpSim);
models{I}.params = {{5e-8, 5e-8, 1e-7, 5e-7, 1e-6, 5e-6, 1e-5, 5e-5, 1e-4, 0.001}, {0}};

