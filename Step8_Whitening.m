%% Data separation using Whitening transform
load WhitenData.mat
load Y.mat

%% SVM
% _Step 1: Create database for problem_
X = WhitenData;
XEF = X(Y == 0,:);
XNF = X(Y == 1,:);

XNF = downsample(XNF,27);

X = [XEF;XNF];

Yp1 = zeros(1,size(XEF,1));
Yp2 = ones(1,size(XNF,1));

Y = [Yp1';Yp2'];

% _Step 2: Partition resulting database for cross-validation purposes_
Partition = cvpartition(Y,'Holdout',30/100);
TestP = Partition.test;
% Train set
XTrain = X(~TestP,:);
YTrain = Y(~TestP,:);
% Test set
XTest = X(TestP,:);
YTest = Y(TestP,:);
YTesta = Y(TestP,:);

% _Step 3: Implement classifier using fitcsvm_
SVMPK = fitcsvm(XTrain,YTrain,'Standardize',true,'KernelFunction',...
    'gaussian','KernelScale','auto');

SVMModelCross = crossval(SVMPK,'KFold',5);

Model = SVMModelCross.Trained{1};

% _Step 4: Obtain performance of classifier_
label = predict(Model,XTest);
% Confusion matrix generation
[C, ~] = confusionmat(YTest,label);
Cm = confusionchart(YTest,label);

% These values hold for a 2x2 matrix confusion. In order to observe the
% performance of a certain characteristic given the characteristic itself
% or another one, the calculations must be adjusted.
TP = C(1,1); FP = C(2,1); FN = C(1,2); TN = C(2,2);
All = TP + TN + FP + FN; P = TP + FN; N = FP + TN; Pp = TP + FP; Np = FN + TN;
Accuracy(1) = (TP+TN)/All;
ErrorRate(1) = (FP+FN)/All;
Sensitivity(1) = TP/P;
Specificity(1) = TN/N;
Precision(1) = TP/(TP+FP);
Recall(1) = TP/(TP+FN);
FScore(1) = (2*Precision(1)*Recall(1))/(Precision(1)+Recall(1));

Model = SVMModelCross.Trained{2};

% _Step 4: Obtain performance of classifier_
label = predict(Model,XTest);
% Confusion matrix generation
[C, ~] = confusionmat(YTest,label);
Cm = confusionchart(YTest,label);

% These values hold for a 2x2 matrix confusion. In order to observe the
% performance of a certain characteristic given the characteristic itself
% or another one, the calculations must be adjusted.
TP = C(1,1); FP = C(2,1); FN = C(1,2); TN = C(2,2);
All = TP + TN + FP + FN; P = TP + FN; N = FP + TN; Pp = TP + FP; Np = FN + TN;
Accuracy(2) = (TP+TN)/All;
ErrorRate(2) = (FP+FN)/All;
Sensitivity(2) = TP/P;
Specificity(2) = TN/N;
Precision(2) = TP/(TP+FP);
Recall(2) = TP/(TP+FN);
FScore(2) = (2*Precision(2)*Recall(2))/(Precision(2)+Recall(2));

Model = SVMModelCross.Trained{3};

% _Step 4: Obtain performance of classifier_
label = predict(Model,XTest);
% Confusion matrix generation
[C, ~] = confusionmat(YTest,label);
Cm = confusionchart(YTest,label);

% These values hold for a 2x2 matrix confusion. In order to observe the
% performance of a certain characteristic given the characteristic itself
% or another one, the calculations must be adjusted.
TP = C(1,1); FP = C(2,1); FN = C(1,2); TN = C(2,2);
All = TP + TN + FP + FN; P = TP + FN; N = FP + TN; Pp = TP + FP; Np = FN + TN;
Accuracy(3) = (TP+TN)/All;
ErrorRate(3) = (FP+FN)/All;
Sensitivity(3) = TP/P;
Specificity(3) = TN/N;
Precision(3) = TP/(TP+FP);
Recall(3) = TP/(TP+FN);
FScore(3) = (2*Precision(3)*Recall(3))/(Precision(3)+Recall(3));


Model = SVMModelCross.Trained{4};

% _Step 4: Obtain performance of classifier_
label = predict(Model,XTest);
% Confusion matrix generation
[C, ~] = confusionmat(YTest,label);
Cm = confusionchart(YTest,label);

% These values hold for a 2x2 matrix confusion. In order to observe the
% performance of a certain characteristic given the characteristic itself
% or another one, the calculations must be adjusted.
TP = C(1,1); FP = C(2,1); FN = C(1,2); TN = C(2,2);
All = TP + TN + FP + FN; P = TP + FN; N = FP + TN; Pp = TP + FP; Np = FN + TN;
Accuracy(4) = (TP+TN)/All;
ErrorRate(4) = (FP+FN)/All;
Sensitivity(4) = TP/P;
Specificity(4) = TN/N;
Precision(4) = TP/(TP+FP);
Recall(4) = TP/(TP+FN);
FScore(4) = (2*Precision(4)*Recall(4))/(Precision(4)+Recall(4));


Model = SVMModelCross.Trained{5};

% _Step 4: Obtain performance of classifier_
label = predict(Model,XTest);
% Confusion matrix generation
[C, ~] = confusionmat(YTest,label);
Cm = confusionchart(YTest,label);

% These values hold for a 2x2 matrix confusion. In order to observe the
% performance of a certain characteristic given the characteristic itself
% or another one, the calculations must be adjusted.
TP = C(1,1); FP = C(2,1); FN = C(1,2); TN = C(2,2);
All = TP + TN + FP + FN; P = TP + FN; N = FP + TN; Pp = TP + FP; Np = FN + TN;
Accuracy(5) = (TP+TN)/All;
ErrorRate(5) = (FP+FN)/All;
Sensitivity(5) = TP/P;
Specificity(5) = TN/N;
Precision(5) = TP/(TP+FP);
Recall(5) = TP/(TP+FN);
FScore(5) = (2*Precision(5)*Recall(5))/(Precision(5)+Recall(5));


Mperformance = table(Accuracy, ErrorRate, Sensitivity, Specificity, Precision,...
    Recall, FScore);

save BestSVM.mat SVMPK
save BestSVMCrossval.mat SVMModelCross
save BestPerformance.mat Mperformance
save BestYtest.mat YTest
save BestXtest.mat XTest