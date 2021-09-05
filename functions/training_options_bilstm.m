%% Syntax
%% options = training_options_bilstm(parameters)
%parameters is a struct containing validation data to be used while generating training
%options
%It can also contain optional values like minibatch size and number of
%epochs to be trained
%The network trains using GPU by default, in case one is unavailable, it
%switches to CPU



function options = training_options_bilstm(parameters)

try parameters.minibatch
catch parameters.minibatch = 20;
end

try parameters.maxepoch
catch parameters.maxepoch = 100;
end


options = trainingOptions('adam',...
    'ExecutionEnvironment','gpu',...
    'GradientThreshold',0.5,...
    'MaxEpochs',parameters.maxepochs,...
    'ValidationData',{parameters.xval,parameters.yval},...
    'ValidationPatience',10,...
    'MiniBatchSize',parameters.minibatch,...
    'SequenceLength','longest',...
    'Shuffle','every-epoch',...
    'Verbose',0,...
    'Plots','training-progress');




try
   gpuArray(1);
   availGPU=true;
catch
   availGPU=false;
end

switch availGPU
    case false
        options.ExecutionEnvironment = 'cpu'
end
    

end