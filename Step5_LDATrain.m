%% LDA Train
load Xtrain.mat
load Ytrain.mat
load XwPCATrain.mat
load XwPCATTrain.mat
%% LDA 1: Without PCA
% _Step 1: Implement classifier_
LDAwoPCA = LDA(XTrain,YTrain);

%% LDA 2: with PCA but no space transformation
LDAwPCA = LDA(XwPCATrain,YTrain);

%% LDA 3: with PCA with transformation
LDAwPCAT = LDA(XwPCATTrain,YTrain);

%% Save models
save LDAwoPCA.mat LDAwoPCA
save LDAwPCA.mat LDAwPCA
save LDAwPCAT.mat LDAwPCAT

%% LDA implementation
function model = LDA(X,Y)
    class1 = X(Y == 0,:);
    class2 = X(Y == 1,:);
    % Algorithm
    %Step 1: Compute the mean for each class
    meanc1 = mean(class1);
    meanc2 = mean(class2);

    %Step 2: Find the scatter matrices
    %Sx = (d-1).*cov(classX)
    S1 = (length(class1)-1).*cov(class1);
    S2 = (length(class2)-1).*cov(class2);

    %Step 3: Find the Within Class scatter matrix and its inverse
    Sw = S1+S2;
    SwINV = pinv(Sw);

    %Step 4: Find the eigenvector
    v = SwINV*((meanc1-meanc2)');
    model = v;
end