%% Test all lineal models trained with holdout and optimize them if possible
load YTest.mat
load XTest.mat
load XwPCATest.mat
load XwPCATTest.mat
% LDA
load LDAwoPCA.mat
load LDAwPCA.mat 
load LDAwPCAT.mat
% LMS
load LMSwoPCA.mat
load LMSwPCA.mat 
load LMSwPCAT.mat
% SVM
load SVMwoPCA.mat
load SVMwPCA.mat 
load SVMwPCAT.mat

% LDA
% Without any analysis
PredictLDA = LDAwoPCA'*XTest';
PredictLDA(PredictLDA>=0) = 0;
PredictLDA(PredictLDA<0) = 1;
PredictLDA = PredictLDA';
% With PCA analysis but without space transformation
PredictLDAwPCA = LDAwPCA'*XwPCATest';
PredictLDAwPCA(PredictLDAwPCA>=0) = 0;
PredictLDAwPCA(PredictLDAwPCA<0) = 1;
PredictLDAwPCA = PredictLDAwPCA';
% With PCA and space transform
PredictLDAwPCAT = LDAwPCAT'*XwPCATTest';
PredictLDAwPCAT(PredictLDAwPCAT>=0) = 0;
PredictLDAwPCAT(PredictLDAwPCAT<0) = 1;
PredictLDAwPCAT = PredictLDAwPCAT';

% SVM
% Without any analysis
PredictSVM = predict(SVMwoPCA,XTest);
% With PCA analysis but without space transformation
PredictSVMwPCA = predict(SVMwPCA,XwPCATest);
% With PCA and space transform
PredictSVMwPCAT = predict(SVMwPCAT,XwPCATTest);

% Confusion chart calculation
% Without any analysis
[CLDA, ~] = confusionmat(YTest,PredictLDA);
[CSVM, ~] = confusionmat(YTest,PredictSVM);
% With PCA analysis but without space transformation
[CLDAwPCA, ~] = confusionmat(YTest,PredictLDAwPCA);
[CSVMwPCA, ~] = confusionmat(YTest,PredictSVMwPCA);
% With PCA and space transform
[CLDAwPCAT, ~] = confusionmat(YTest,PredictLDAwPCAT);
[CSVMwPCAT, ~] = confusionmat(YTest,PredictSVMwPCAT);

CLineal = [CLDA,CSVM;CLDAwPCA,CSVMwPCA;CLDAwPCAT,CSVMwPCAT];
save CLineal.mat CLineal
