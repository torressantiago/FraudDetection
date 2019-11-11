%% Data analysis
load X.mat
load Y.mat

%% PCA analysis
% Step 1: Remove the mean
xvar = var(X);
xvarp = xvar(xvar>0);
xmean = mean(X);
rmean = X-xmean;

% Step 2: Compute covariance matrix
E = cov(rmean);
clear rmean

% Step 3: Find eigenvalues and eigenvectors
[Evect, Eval] = eig(E);

% Step 4: Remove unwanted characteristics
temp = Eval(Eval >= 0.01); % Threshold for wanted variances

NEvect = ones(376,18);
NEval = ones(376,376);

for i = 1:17
    [row, col] = find(Eval == temp(i));
    NEvect(:,i) = Evect(:, col);
    NEval(:,i) = Eval(:, col);
end

NEval = NEval(360:end,1:18);

% Step 5: Transform original matrix to new space
XwPCAT = NEvect'*X';
XwPCAT = XwPCAT';

xNoFraudp = XwPCAT(Y == 0, :);
xIsFraudp = XwPCAT(Y == 1, :);

xNoFraud = X(Y == 0, :);
xIsFraud = X(Y == 1, :);

% Step 6: Save results without space transform
Eval1 = diag(E);
temp1 = Eval1(Eval1 > 0);

row1 = ones(1,17);
col1 = ones(1,17);
XwPCA = ones(590540,17);

for j = 1:17
    [row1(j), col1(j)] = find(Eval1 == temp1(j));
    XwPCA(:,j) = X(:, row1(j));
end

clear X
clear Y

% Save results
save XwPCAT.mat XwPCAT
save XwPCA.mat XwPCA

%% Whitening transformation
% X = bsxfun(@minus, X, mean(X));
% A = X'*X;
% [V,D] = eig(A);
% X = X*V*diag(1./(diag(D)).^(1/2))*V';
% % XwWhit = whiten(X);

%% Plot some data
% sump = sum(Eval);
% 
% % Eigenvalues of covariance matrix
% figure
% bar(sump);
% title('Eigenvalues of covariance matrix')
% xlabel('Characteristic')
% ylabel('Eigenvalue')
% grid on
% ylim([0 4])
% 
% 
% % Characteristic space between values of greater covariance
% figure
% scatter3(xNoFraudp(:,1),xNoFraudp(:,10),xNoFraudp(:,18))
% hold on
% scatter3(xIsFraudp(:,1),xIsFraudp(:,10),xIsFraudp(:,18))
% title('Feature space transformed')
% xlabel('Feature 1')
% ylabel('Feature 2')
% zlabel('Feature 3')
% grid on
% legend('No Fraud', 'Fraud')
% 
% figure
% scatter3(xNoFraud(:,1),xNoFraud(:,2),xNoFraud(:,3))
% hold on
% % diag(E); % Look for the greatest values in the resulting matrix, those
% % will have greater variance.
% scatter3(xIsFraud(:,1),xIsFraud(:,2),xIsFraud(:,10))
% title('Original feature space')
% xlabel('Feature 1')
% ylabel('Feature 2')
% zlabel('Feature 3')
% grid on
% legend('No Fraud', 'Fraud')

%% Whitening function
% https://www.projectrhea.org/rhea/index.php/ECE662_Whitening_and_Coloring_Transforms_S14_MH
% https://xcorr.net/2011/05/27/whiten-a-matrix-matlab-code/