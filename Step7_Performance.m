%% Performance of every trained model
load Clineal.mat
load CNonLineal.mat
load CNonSupervised.mat

% Lineal models
k = 1;
for i = 1:2:4
    for j = 1:2:6
        C = CLineal(j:j+1,i:i+1)
        TP = C(1,1); FP = C(2,1); FN = C(1,2); TN = C(2,2);
        All = TP + TN + FP + FN; P = TP + FN; N = FP + TN; Pp = TP + FP; Np = FN + TN;
        Accuracy(k) = (TP+TN)/All;
        ErrorRate(k) = (FP+FN)/All;
        Sensitivity(k) = TP/P;
        Specificity(k) = TN/N;
        Precision(k) = TP/(TP+FP);
        Recall(k) = TP/(TP+FN);
        FScore(k) = (2*Precision(k)*Recall(k))/(Precision(k)+Recall(k));
        k = k + 1;
    end
end

% Non lineal models
for i = 1:2:6
    for j = 1:2:6
        C = CNonLineal(j:j+1,i:i+1)
        TP = C(1,1); FP = C(2,1); FN = C(1,2); TN = C(2,2);
        All = TP + TN + FP + FN; P = TP + FN; N = FP + TN; Pp = TP + FP; Np = FN + TN;
        Accuracy(k) = (TP+TN)/All;
        ErrorRate(k) = (FP+FN)/All;
        Sensitivity(k) = TP/P;
        Specificity(k) = TN/N;
        Precision(k) = TP/(TP+FP);
        Recall(k) = TP/(TP+FN);
        FScore(k) = (2*Precision(k)*Recall(k))/(Precision(k)+Recall(k));
        k = k + 1;
    end
end

Order = {'LDAwoPCA', 'LDAwPCA', 'LDAwPCAT','SVMwoPCA','SVMwPCA','SVMwPCAT'...
    'NNwoPCA','NNwPCA','NNwPCAT','SVMwoPCAGK','SVMwPCAGK','SVMwPCATGK'...
    'SVMwoPCAPK','SVMwPCAPK','SVMwPCATPK'};

scatter(Precision,Recall)
grid on
xlabel('Precision')
ylabel('Recall')
title('Comparison between trained models')