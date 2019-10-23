%% SVM with gaussian kernel calssification
load xtrainp
load xtrain
load ytrain

% Variable definitions
Accuracy = ones(1,3);
ErrorRate = ones(1,3);
Sensitivity = ones(1,3);
Specificity = ones(1,3);
Precision = ones(1,3);
Recall = ones(1,3);
FScore = ones(1,3);

% Database creation
Y = ytrain;
X = xtrainp;

% _Step 1: Remove virginica from database_
Xv1 = X;
Yv1 = Y;

% _Step 2: Partition resulting database for cross-validation purposes_
Partition = cvpartition(Yv1,'Holdout',30/100);
TestP = Partition.test;
% Train set
Xv1Train = Xv1(~TestP,:);
Yv1Train = Yv1(~TestP,:);
% Test set
Xv1Test = Xv1(TestP,:);
Yv1Test = Yv1(TestP,:);

% _Step 3: Implement classifier_
net = feedforwardnet([18, 9, 3],'trainlm');

net.trainParam.epochs = 200;

[net, tr] = train(net,Xv1Train',Yv1Train');
view(net)

% _Step 4: Obtain performance of classifier_
label = net(Xv1Test');
label = label';

i = 1;

for j = 0.01:0.01:1
    labela(label < j) = 0;
    labela(label >= j) = 1;
    labela = labela';
    % Confusion matrix generation
    [CNN, ~] = confusionmat(double(Yv1Test),labela);
    figure
    title('Confusion chart for ANN')
    cm = confusionchart(double(Yv1Test),labela);
    cm.ColumnSummary = 'column-normalized';
    cm.RowSummary = 'row-normalized';
    cm.Title = 'Confusion chart for ANN';

    TP = CNN(1,1); FP = CNN(2,1); FN = CNN(1,2); TN = CNN(2,2);
    TrP(i) = TP; FaP(i) = FP;
    All = TP + TN; P = TP + FN; N = FP + TN; Pp = TP + FP; Np = FN + TN;
    Accuracy(i) = (TP+TN)/All;
    ErrorRate(i) = (FP+FN)/All;
    Sensitivity(i) = TP/P;
    Specificity(i) = TN/N;
    Precision(i) = TP/(TP+FP);
    Recall(i) = TN/(TN+FN);
    FScore(i) = (2*Precision(i)*Recall(i))/(Precision(i)+Recall(i));
    i = i + 1;
end

TrP = TrP./max(TrP);
FaP = FaP./max(FaP);

figure
plot(Recall,Precision)
xlabel('Recall')
ylabel('Precision')
title('Precision-Recall curve')
ylim([0.973 1])
xlim([0.046 0.88])
grid on

figure
plot(FaP,TrP)
xlabel('False positive')
ylabel('True positive')
title('TP-FP curve')
grid on
