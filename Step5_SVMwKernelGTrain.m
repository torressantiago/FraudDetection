%% SVM with gaussian kernel Train
load Xtrain.mat
load Ytrain.mat
load XwPCATrain.mat
load XwPCATTrain.mat
%% SVM 1: Without PCA
% _Step 1: Implement classifier_
SVMwoPCAGK = fitcsvm(XTrain,YTrain,'Standardize',true,'KernelFunction',...
    'gaussian','KernelScale','auto','IterationLimit', 1e2);

%% SVM 2: with PCA but no space transformation
SVMwPCAGK = fitcsvm(XwPCATrain,YTrain,'Standardize',true,'KernelFunction',...
    'gaussian','KernelScale','auto','IterationLimit', 5e3);


%% SVM 3: with PCA with transformation
SVMwPCATGK = fitcsvm(XwPCATTrain,YTrain,'Standardize',true,'KernelFunction',...
    'gaussian','KernelScale','auto','IterationLimit', 5e3);

%% Save models
save SVMwoPCAGK.mat SVMwoPCAGK
save SVMwPCAGK.mat SVMwPCAGK
save SVMwPCATGK.mat SVMwPCATGK