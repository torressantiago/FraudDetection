%% KMeans train
load Xtrain.mat
load Ytrain.mat
load XwPCATrain.mat
load XwPCATTrain.mat
%% KMeans 1: Without PCA
% _Step 1: Implement classifier_
kmeanswoPCA = kmeans(XTrain, 2);

%% KMeans 2: with PCA but no space transformation
kmeanswPCA = kmeans(XwPCATrain, 2);

%% KMeans 3: with PCA with transformation
kmeanswPCAT = kmeans(XwPCATTrain, 2);

%% Save models
save kmeanswoPCA.mat kmeanswoPCA
save kmeanswPCA.mat kmeanswPCA
save kmeanswPCAT.mat kmeanswPCAT