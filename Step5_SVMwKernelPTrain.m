%% SVM with polynomial kernel Train
load Xtrain.mat
load Ytrain.mat
load XwPCATrain.mat
load XwPCATTrain.mat
%% SVM 1: Without PCA
% _Step 1: Implement classifier_
SVMwoPCAPK = fitcsvm(XTrain,YTrain,'Standardize',true,'KernelFunction',...
    'polynomial','PolynomialOrder',2,'KernelScale','auto','IterationLimit', 1e2);

%% SVM 2: with PCA but no space transformation
SVMwPCAPK = fitcsvm(XwPCATrain,YTrain,'Standardize',true,'KernelFunction',...
    'polynomial','PolynomialOrder',2,'KernelScale','auto','IterationLimit', 5e3);


%% SVM 3: with PCA with transformation
SVMwPCATPK = fitcsvm(XwPCATTrain,YTrain,'Standardize',true,'KernelFunction',...
    'polynomial','PolynomialOrder',2,'KernelScale','auto','IterationLimit', 5e3);

%% Save models
save SVMwoPCAPK.mat SVMwoPCAPK
save SVMwPCAPK.mat SVMwPCAPK
save SVMwPCATPK.mat SVMwPCATPK