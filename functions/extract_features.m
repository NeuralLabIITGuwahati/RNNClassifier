%% Syntax
%% feature_vector = extract_features(eegmatrix,Fs)
%% Description
%%the function inputs the 3D eeg matrix of CHANNELxSAMPLESxTRIAL and extracts
%%the spectral and entropy features. It outputs the feature vector in the
%%same dimensions as the input matirx. CHANNELSxFEATURESxTRIAL





function feature_vector = extract_features(eegmatrix,Fs)

%%
%default sampling frequency/ sampling frequency for this dataset
if nargin<2
    fs=250; % sampling frequency
end
%% extract features from each trial
for a = 1:size(eegmatrix,3)
    features = [];
    clc;fprintf("Extracting features from trial %d",a);clc
    %% extract features from each channel    
    for b = 1:size(eegmatrix,1)
    
        
        %% spectral features
        [p,f] = pwelch(eegmatrix(b,:,a),[],[],[],fs);
        
        power_delta = band_power(p,f,1,4);
        power_theta = band_power(p,f,4,8);
        power_alpha = band_power(p,f,8,13);
        power_beta = band_power(p,f,13,30);
        power_gamma = band_power(p,f,30,40);
        %% entropy feature
        entropy = approximateEntropy(eegmatrix(b,:,a));
        
        %% feature vector
        feature_vector(b,:,a) = [power_delta ...
                                 power_theta ...
                                 power_alpha ...
                                 power_beta  ...
                                 power_gamma  ...
                                 entropy ]; 
        
    end
end
end

