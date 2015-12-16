function [ res ] = eval_batch( arr_of_params )

res = {};
for I = 1:length(arr_of_params)
	params = arr_of_params(I);
    	params = prepare_exp_params(params);
	res{I} = eval_exp_and_save(params);
end

end

