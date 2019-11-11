%% Test all non-lineal models trained with holdout and optimize them if possible
load YTest.mat
load XTest.mat
load XwPCATest.mat
load XwPCATTest.mat
% NN
load NETwoPCA.mat
load NETwPCA.mat 
load NETwPCAT.mat
% SVM with Gaussian Kernel
load SVMwoPCAGK.mat
load SVMwPCAGK.mat 
load SVMwPCATGK.mat
% SVM with polynomial Kernel
load SVMwoPCAPK.mat
load SVMwPCAPK.mat 
load SVMwPCATPK.mat


% Compute confusion chart for each one%% Non-linear
% Neural Network
% Without any analysis
PredictNN = NETwoPCA(XTest');
PredictNN = PredictNN';
PredictNN(PredictNN >= 0.953) = 1;
PredictNN(PredictNN < 0.953) = 0;
% j = 1;
% for i = 0.001:0.001:1
%     PredictNNa(PredictNN >= i) = 1;
%     PredictNNa(PredictNN < i) = 0;
%     [CNN, ~] = confusionmat(YTest,PredictNNa);
%     TP = CNN(1,1); FP = CNN(2,1); FN = CNN(1,2);
%     Precision(j) = TP/(TP+FP);
%     Recall(j) = TP/(TP+FN);
%     j = j + 1;
% end
% plot(Recall,Precision)
% grid on
% title('2 class Precision-Recall curve')
% xlabel('Recall')
% ylabel('Precision')
% With PCA analysis but without space transformation
PredictNNwPCA = NETwPCA(XwPCATest');
PredictNNwPCA = PredictNNwPCA';
PredictNNwPCA(PredictNNwPCA >= 0.956) = 1;
PredictNNwPCA(PredictNNwPCA < 0.956) = 0;
% j = 1;
% for i = 0.001:0.001:1
%     PredictNNa(PredictNNwPCA >= i) = 1;
%     PredictNNa(PredictNNwPCA < i) = 0;
%     [CNN, ~] = confusionmat(YTest,PredictNNa);
%     TP = CNN(1,1); FP = CNN(2,1); FN = CNN(1,2);
%     Precision(j) = TP/(TP+FP);
%     Recall(j) = TP/(TP+FN);
%     j = j + 1;
% end
% plot(Recall,Precision)
% grid on
% title('2 class Precision-Recall curve')
% xlabel('Recall')
% ylabel('Precision')
% With PCA and space transform
PredictNNwPCAT = NETwPCAT(XwPCATTest');
PredictNNwPCAT = PredictNNwPCAT';
PredictNNwPCAT(PredictNNwPCAT >= 0.96) = 1;
PredictNNwPCAT(PredictNNwPCAT < 0.96) = 0;
% j = 1;
% for i = 0.001:0.001:1
%     PredictNNa(PredictNNwPCAT >= i) = 1;
%     PredictNNa(PredictNNwPCAT < i) = 0;
%     [CNN, ~] = confusionmat(YTest,PredictNNa);
%     TP = CNN(1,1); FP = CNN(2,1); FN = CNN(1,2);
%     Precision(j) = TP/(TP+FP);
%     Recall(j) = TP/(TP+FN);
%     j = j + 1;
% end
% plot(Recall,Precision)
% grid on
% title('2 class Precision-Recall curve')
% xlabel('Recall')
% ylabel('Precision')

% SVM with Gaussian Kernel
% Without any analysis
PredictSVMGK = predict(SVMwoPCAGK,XTest);
% With PCA analysis but without space transformation
PredictSVMwPCAGK = predict(SVMwPCAGK,XwPCATest);
% With PCA and space transform
PredictSVMwPCATGK = predict(SVMwPCATGK,XwPCATTest);


% SVM with Polynomial Kernel
% Without any analysis
PredictSVMPK = predict(SVMwoPCAPK,XTest);
% With PCA analysis but without space transformation
PredictSVMwPCAPK = predict(SVMwPCAPK,XwPCATest);
% With PCA and space transform
PredictSVMwPCATPK = predict(SVMwPCATPK,XwPCATTest);

% Confusion chart calculation
% Without any analysis
[CNN, ~] = confusionmat(YTest,PredictNN);
[CSVMGK, ~] = confusionmat(YTest,PredictSVMGK);
[CSVMPK, ~] = confusionmat(YTest,PredictSVMPK);
% With PCA analysis but without space transformation
[CNNwPCA, ~] = confusionmat(YTest,PredictNNwPCA);
[CSVMGKwPCA, ~] = confusionmat(YTest,PredictSVMwPCAGK);
[CSVMPKwPCA, ~] = confusionmat(YTest,PredictSVMwPCAPK);
% With PCA and space transform
[CNNwPCAT, ~] = confusionmat(YTest,PredictNNwPCAT);
[CSVMGKwPCAT, ~] = confusionmat(YTest,PredictSVMwPCATGK);
[CSVMPKwPCAT, ~] = confusionmat(YTest,PredictSVMwPCATPK);

CNonLineal = [CNN,CSVMGK,CSVMPK;CNNwPCA,CSVMGKwPCA,CSVMPKwPCA;CNNwPCAT,CSVMGKwPCAT,CSVMPKwPCAT];

save CNonLineal.mat CNonLineal