%% Data separation
load X.mat
load Y.mat
load XwPCAT.mat
load XwPCA.mat

%% Holdout separation
Partition = cvpartition(Y,'Holdout',30/100);
TestP = Partition.test;
% Train set
XTrain = X(~TestP,:);
XwPCATTrain = XwPCAT(~TestP,:);
XwPCATrain = XwPCA(~TestP,:);
YTrain = Y(~TestP,:);
% Test set
XTest = X(TestP,:);
XwPCATTest = XwPCAT(TestP,:);
XwPCATest = XwPCA(TestP,:);
YTest = Y(TestP,:);

save XTrain.mat XTrain
save XwPCATTrain.mat XwPCATTrain
save XwPCATrain.mat XwPCATrain
save YTrain.mat YTrain
save XTest.mat XTest
save XwPCATTest.mat XwPCATTest
save XwPCATest.mat XwPCATest
save YTest.mat YTest