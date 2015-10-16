function [ test_err, train_err ] = computeModelErrors( trainModel, params, train_X, train_T, test_X, test_T )
%   computeModelErrors( trainModel, params, train_X, train_T, test_X, test_T)
%   
%   Takes train_X, train_T and params and through function trainModel it
%   trains model. It computes training error train_err, and from test_X,
%   test_T and test_Y computed from model.predict(text_X), it calculates
%   testing error test_err.
%
%   Returns: [ test_err, train_err ]
%

    [Out, model, train_err] = evalc('trainModel(train_X, train_T, params)');
    [Out, test_Y] = evalc('model.predict(test_X)');
    test_err = (1/length(test_T))*sum((test_Y - test_T).^2);

end

