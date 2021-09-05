%% syntax data_process(subject_ID)
%% call the function with the subject ID as the input
%% dataprocess(1) for example
%% The files are saved in the current directory in the MAT_II_B Folder. 


function data_process(subject_ID)

%clear all;
%close all;
%%
rng(0);

%% Input

%seticapath;
%setpath;
eeglab;
%%
%addpath(pwd+"\bilstm_implementation");
%addpath(pwd+"\parra_corrca");
%%
if subject_ID <10
    SBJ={ string('0'+string(subject_ID)) };% Participants
else
    SBJ={ string(subject_ID) };% Participants
end
    
TASK={ 'MATBdiff' 'MATBmed' 'MATBeasy' }; % Here all the names of the conditions
% The next two variables indicate what conditions you want to compare with
% each other. For example here the first test will be TASK{1} --> Difficult
% against TASK{3} --> Easy
TESTGR1={ (1) (1) (2)};
TESTGR2={ (3) (2) (3) }; % And the second condition to compare with

CLUSTER = [1:61];
%% Initiate some Structures
ALLDATA=struct;
accuracy=struct;
ACC=zeros(length(SBJ));

%% Two main loops (One for each Testgroup (Easy against Difficult))
for s=1:length(SBJ) % for all subjects
    disp('Hey I am now importing data for Subject '+string(SBJ{s}));
  %  for t=1:length(TESTGR1) % across all the test groups
    
%% 
        %disp('Hey I am now doing Machine Learning for Subject '+string(SBJ{s}));
        traindata1=pop_loadset(char('P'+string(SBJ{s})+'/S1/eeg/alldata_sbj'+string(SBJ{s})+'_sess1_'+string(TASK{1})+'.set'));
        traindata2=pop_loadset(char('P'+string(SBJ{s})+'/S1/eeg/alldata_sbj'+string(SBJ{s})+'_sess1_'+string(TASK{2})+'.set'));
        traindata3=pop_loadset(char('P'+string(SBJ{s})+'/S1/eeg/alldata_sbj'+string(SBJ{s})+'_sess1_'+string(TASK{3})+'.set'));
        
        traindata_rest=pop_loadset(char('P'+string(SBJ{s})+'/S1/eeg/alldata_sbj'+string(SBJ{s})+'_sess1_'+'RS'+'.set'));
        
        testdata1=pop_loadset(char('P'+string(SBJ{s})+'/S2/eeg/alldata_sbj'+string(SBJ{s})+'_sess2_'+string(TASK{1})+'.set'));
        testdata2=pop_loadset(char('P'+string(SBJ{s})+'/S2/eeg/alldata_sbj'+string(SBJ{s})+'_sess2_'+string(TASK{2})+'.set'));
        testdata3=pop_loadset(char('P'+string(SBJ{s})+'/S2/eeg/alldata_sbj'+string(SBJ{s})+'_sess2_'+string(TASK{3})+'.set'));
        
        testdata_rest=pop_loadset(char('P'+string(SBJ{s})+'/S2/eeg/alldata_sbj'+string(SBJ{s})+'_sess2_'+'RS'+'.set'));
        
        %extract only data
        class1=traindata1.data;
        class2=traindata2.data;
        class3=traindata3.data; %
        testclass1=testdata1.data;
        testclass2=testdata2.data;
        testclass3=testdata3.data;
        %concatenate
        allclass=cat(3,class1,class2,class3);
        
        training_rest = traindata_rest.data;
        training_rest = mean(training_rest(CLUSTER,:,:),3);
        testing_rest = testdata_rest.data;
        testing_rest =  mean(testing_rest(CLUSTER,:,:),3);
        
        testallclass=cat(3,testclass1,testclass2,testclass3);
        %reduce electrodes
        allclass=allclass(CLUSTER,:,:);
        % same for testset
        testallclass=testallclass(CLUSTER,:,:);
        N=size(allclass,3);
        % same for testset
        testN=size(testallclass,3);
        %make binary vector for labels
        classbin=zeros(N,1);
        classbin(1:size(class1,3))=2;
        classbin((size(class1,3)+1):2*(size(class1,3)))=1;
        classbin((2*size(class1,3)+1):N)=0;
        % same for testset
        testbin=zeros(N,1);
        testbin(1:size(class1,3))=2;
        testbin((size(class1,3)+1):2*(size(class1,3)))=1;
        testbin((2*size(class1,3)+1):N)=0;
        % Randomize order of training and testing set
        trainrand=randperm(N);
        trainingbin=classbin(trainrand);
        trainingset=allclass(:,:,trainrand);
        % same for testset
        testrand=randperm(testN);
        testbin=testbin(testrand);
        testset=testallclass(:,:,testrand);
        
        t_trainingset = trainingset - repmat(training_rest,1,1,size(trainingset,3));
        t_testset = testset - repmat(testing_rest,1,1,size(testset,3));        
        
%         eeg = cat(3,t_testset,t_trainingset);
%         label = cat(1,testbin,trainingbin);
        
        save(sprintf('subject_%d.mat',subject_ID),'t_trainingset','t_testset','testbin','trainingbin');
        
        
end
end

