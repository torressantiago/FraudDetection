%% SVM train
load Xtrain.mat
load Ytrain.mat
load XwPCATrain.mat
load XwPCATTrain.mat
%% SVM 1: Without PCA
% _Step 1: Implement classifier_
SVMwoPCA = fitcsvm(XTrain,YTrain,'IterationLimit', 1e2);

%% SVM 2: with PCA but no space transformation
SVMwPCA = fitcsvm(XwPCATrain,YTrain, 'IterationLimit', 5e3);


%% SVM 3: with PCA with transformation
SVMwPCAT = fitcsvm(XwPCATTrain,YTrain,'IterationLimit', 5e3);

%% Save models
save SVMwoPCA.mat SVMwoPCA
save SVMwPCA.mat SVMwPCA
save SVMwPCAT.mat SVMwPCAT