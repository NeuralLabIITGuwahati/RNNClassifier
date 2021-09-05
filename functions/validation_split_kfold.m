%% syntax 
%% [xtrain,ytrain,xval,yval] = validation_split_kfold(data,label,nsets)
%% Description
%%if nsets is specified, returns the desired number of validation and training sets from the input data and label
%%if nsets in not provided, it returns the equipartitioned sets from the input data and label



function [xtrain,ytrain,xval,yval] = validation_split_kfold(data,label,nsets)

try 
    nsets
    rng default
    valid=cvpartition(length(data),'KFold',nsets)
catch
    rng default
    valid=cvpartition(length(data),'KFold');
end



for a = 1:valid.NumTestSets
    
    indtrain = training(valid,a);
    indval = test(valid,a);
    
    xtrain{a} = data(indtrain);
    ytrain{a} = label(indtrain);
    
    xval{a} = data(indval);
    yval{a} = label(indval);
end
end