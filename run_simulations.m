function run_simulations(exppath_short, settings_script)

eval(settings_script);

i = 1;
for ModelIndex = 1:length(models)
    for ParamIndex = 1:length(models{ModelIndex}.params)
        ident = [int2str(ModelIndex) '-' int2str(ParamIndex)];
        model = struct('name', models{ModelIndex}.name, 'model', models{ModelIndex}.model, 'params', models{ModelIndex}.params(ParamIndex));
        % {func_no, D, N, id, models, noisy}
        comp_f_id(15, 2, 200, ident, {model}, 0, exppath_short);
        i = i + 1;
    end
end

  
end