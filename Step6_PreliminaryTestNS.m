%% Test all non supervised models trained with holdout and optimize them if possible
load YTest.mat
load XTest.mat
load XwPCATest.mat
load XwPCATTest.mat
%KMeans
load kmeanswoPCA.mat
load kmeanswPCA.mat
load kmeanswPCAT.mat

% LDA
% Without any analysis
Predictkmeans = kmeans(XTest, 2) - 1;
% With PCA analysis but without space transformation
PredictkmeanswPCA = kmeans(XwPCATest, 2) - 1;
% With PCA and space transform
PredictkmeanswPCAT = kmeans(XwPCATTest, 2) - 1;

% Confusion chart calculation
% Without any analysis
[Ckmeans, ~] = confusionmat(YTest,Predictkmeans);
% With PCA analysis but without space transformation
[CkmeanswPCA, ~] = confusionmat(YTest,PredictkmeanswPCA);
% With PCA and space transform
[CkemeanswPCAT, ~] = confusionmat(YTest,PredictkmeanswPCAT);

CNonSupervised = [Ckmeans;CkmeanswPCA;CkemeanswPCAT];
save CNonSupervised.mat CNonSupervised
