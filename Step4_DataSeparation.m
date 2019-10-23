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
Model = fitcsvm(Xv1Train,Yv1Train,'Standardize',true,'KernelFunction',...
    'gaussian','KernelScale','auto','IterationLimit', 1e3);

CModel = crossval(Model,'kfold',3);


% _Step 4: Compute performance for each model and plot ROC curves_
for i = 1:3
    EvModel = CModel.Trained{i};
    label = predict(EvModel,Xv1Test);
    % Confusion matrix generation
    [C, ~] = confusionmat(Yv1Test,label);
    Cm = confusionchart(Yv1Test,label);
    % These values hold for a 2x2 matrix confusion. In order to observe the
    % performance of a certain characteristic given the characteristic itself
    % or another one, the calculations must be adjusted.
    TP = C(1,1); FP = C(2,1); FN = C(1,2); TN = C(2,2);
    All = TP + TN; P = TP + FN; N = FP + TN; Pp = TP + FP; Np = FN + TN;
    
    Accuracy(i) = (TP+TN)/All;
    ErrorRate(i) = (FP+FN)/All;
    Sensitivity(i) = TP/P;
    Specificity(i) = TN/N;
    
    Precision(i) = TP/(TP+FP);
    Recall(i) = TN/(TN+FN);
    FScore(i) = (2*Precision(i)*Recall(i))/(Precision(i)+Recall(i));
end