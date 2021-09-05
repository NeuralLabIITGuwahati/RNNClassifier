# RNNClassifier
The codes provided here are the implementation of a RNN Classifer on the Mental Workload Dataset from NEC 2021



RNN classification of Mental Workload EEG

Requisites 
1.	MATLAB 2021a Installation
2.	Deep Learning toolbox
3.	Predictive Maintenance Toolbox (May not be needed in MATLAB 2021a)
4.	Neuroergonomics Conference 2021 Grand Hackathon Challenge dataset 
https://zenodo.org/record/5055046#.YTTSk44zZk5
5.	EEGLAB latest version

Data
Each subject data is provided as a separate MATLAB variable. 
Note: the given data originally had two sessions for each subject combined into a single dataset. 

Setting up the environment
Download the Parent folder, place it in the workspace, and add the folder to the MATLAB working directory before executing the code. 
Descriptions
Description of the in-built MATLAB functions can be found at mathworks.com or in the help doc provided by MATLAB
The descriptions of the custom functions used here are given below. These are available in the file for each of these functions. Most names are self-explanatory. However, for implementation details, refer to this file 
They are also available in the MATLAB documentation and can be accessed by calling doc followed by the custom function name

Custom Functions
1.	data_process : The function inputs the subject ID and saves a matlab variable to the current working directory for the selected subject containing the trials from two sessions as test and train dataset. The function does not output anything
2.	extract features: the function extracts specified spectral and non-linear features from the given 3D EEG signal matrix. It inputs the data as a 3D EEG matrix of dimension CHANNELxSAMPLESxTRIALS, and outputs the extracted features in the same dimensions as the input, CHANNELxFEATURESxTRIALS.
3.	make_cellarray_eeg: The data has to be in the form of a cell array for MATLAB Deep learning toolbox implementation. This function converts the 3D signal matrix to cell arrays. The input matrix should be of dimension CHANNELxSAMPLESxTRIALS. Output is a cell array of trials each containing CHANNELxSAMPLES for a single TRIAL. 
4.	make_categorical_label: The Deep Learning toolbox requires the labels as categorical variables. This function converts the numeric labels to categorical labels. It inputs the numeric labels and outputs the categorical label
5.	validation_split_kfold: This function returns the K partitions of training and validation data. It inputs the data and label as cell arrays and number of partitions as an optional argument
6.	training_options_bilstm: this function specifies the training option for the network, including the validation data. The various parameters can be specified as a struct() variable to be passed into the function. At the very lease, The validation data are to be passed in, as instructed in the demo file
7.	bilstm_network_architecture: This function returns the deep learning architecture as a layer sequence, as required by the Deep Learning toolbox. It does not need any input


An example of implementing this on a demo subject is given below. 
Run the demo code to see the training and validation of the network on the demo subject. 

Example_subject_1.mlx. 
The details about the various steps in the implementation can be found in the Helpfile.mlx
