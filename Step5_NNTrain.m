%% Neural Network Train
load Xtrain.mat
load Ytrain.mat

load XwPCATrain.mat

load XwPCATTrain.mat

%% Neural Network 1: without PCA
% _Step 1: Implement classifier_
NETwoPCA = feedforwardnet([9, 6, 3],'trainlm');

NETwoPCA.trainParam.epochs = 10000;
[NETwoPCA, ~] = train(NETwoPCA,XTrain',YTrain');

%% Neural Network 2: with PCA but no space transformation
% _Step 1: Implement classifier_
NETwPCA = feedforwardnet([9, 6, 3],'trainlm');

NETwPCA.trainParam.epochs = 10000;
[NETwPCA, ~] = train(NETwPCA,XwPCATrain',YTrain');

%% Neural Network 3: with PCA with transformation
% _Step 1: Implement classifier_
NETwPCAT = feedforwardnet([9, 6, 3],'trainlm');

NETwPCAT.trainParam.epochs = 10000;
[NETwPCAT, tr] = train(NETwPCAT,XwPCATTrain',YTrain');

%% Save trained NETS
save NETwoPCA.mat NETwoPCA
save NETwPCA.mat NETwPCA
save NETwPCAT.mat NETwPCAT