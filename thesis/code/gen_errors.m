import_results;

%%

Data = results(strcmp('RBF-NN', results.Method) & strcmp('f15-40d-5000', results.Dataset), :);

%%

uniq = struct();
params = struct();

for I = 1:length(Data.Parameters)
    pars = strsplit(Data.Parameters{I}, ',');
    for J = 1:length(pars)
        par = strsplit(pars{J},'=');
        key = par{1};
        
        if strcmp(key, 'eq')
            key = 'eg';
        end
        
        if ~isfield(uniq, key)
            uniq.(key) = [];
        end
        
        if ~isfield(params, key)
            params.(key) = {};
        end
        
        if sum(uniq.(key) == str2num(par{2})) == 0
            uniq.(key) = [uniq.(key) str2num(par{2})]; 
            uniq.(key) = sort(uniq.(key));
        end
        
        params.(key){length(params.(key)) + 1} = str2num(par{2});
        
    end
end

%%

Data(:,'sc') = params.sc';
Data(:,'max') = params.max';

%%

SubData = Data(:, {'Trainerrormean', 'Testerrormean', 'sc'});
SubData = SubData(SubData.sc >= 5, :);
func = @mean;
GroupedData = varfun(func,SubData,'GroupingVariables','sc');
GroupedData = GroupedData(GroupedData.GroupCount > 1, :);
X_test = GroupedData.mean_Testerrormean;
X_train = GroupedData.mean_Trainerrormean;
Y = GroupedData.sc;

figure;

scatter(SubData.sc, SubData.Testerrormean);
hold on;
scatter(SubData.sc, SubData.Trainerrormean);

ax = gca;
ax.ColorOrderIndex = 1;

plot(Y, X_test);
plot(Y, X_train);
xlabel('Spread constant');
ylabel('MSE');

