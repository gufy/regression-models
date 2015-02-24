function [ test_err, train_err ] = computeModelErrors( trainModel, params, train_X, train_T, test_X, test_T )

    [Out, model, train_err] = evalc('trainModel(train_X, train_T, params)');
    [Out, test_Y] = evalc('model.predict(test_X)');
    test_err = (1/length(test_T))*sum((test_Y - test_T).^2);

end

