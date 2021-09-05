%% Syntax
%% layers = bilstm_network_architecture()
%% Description
%%The function creates the network architecture we defined. It inputs
%%nothing and outputs the layers variable which can be fed into
%%trainNetwork() function



function layers = bilstm_network_architecture()

nchannels = 61;
hidden1 = 256;
hidden2 = 128;
hidden3 = 64;

droupout = 0.2;
dense = 16;
nclass = 3;


layers = [sequenceInputLayer(nchannels,'Name','Input')
    bilstmLayer(hidden1,'Name','BiLSTM_layer')
    dropoutLayer(droupout,'Name','Dropout_layer')
    batchNormalizationLayer('Name','Batch_normalization_layer_I')    
    lstmLayer(hidden2,'Name','LSTM_layer_I')
    batchNormalizationLayer('Name','Batch_normalization_layer_II')
    lstmLayer(hidden3,'OutputMode','last','Name','LSTM_layer_II')
    batchNormalizationLayer('Name','Batch_normalization_layer_III')
    fullyConnectedLayer(dense,'Name','Fully_connected_layer_I')
    fullyConnectedLayer(nclass,'Name','Fully_connected_layer_II')
    softmaxLayer('Name','Softmax_layer')
    classificationLayer('Name','classification_layer')];

end