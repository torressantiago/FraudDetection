%% Data analysis
load xtrain.mat
load ytrain.mat

%% PCA analysis
% Step 1: Remove the mean
xvar = var(xtrain);
xvarp = xvar(xvar>0);
xmean = mean(xtrain);
rmean = xtrain-xmean;

% Step 2: Compute covariance matrix
E = cov(rmean);

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
xtrainp = NEvect'*xtrain';
xtrainp = xtrainp';

xtrainNoFraudp = xtrainp(ytrain == 0, :);
xtrainIsFraudp = xtrainp(ytrain == 1, :);

xtrainNoFraud = xtrain(ytrain == 0, :);
xtrainIsFraud = xtrain(ytrain == 1, :);

% % Save results
save xtrainp.mat xtrainp

%% Plot some data
sump = sum(Eval);

% Eigenvalues of covariance matrix
figure
bar(sump);
title('Eigenvalues of covariance matrix')
xlabel('Characteristic')
ylabel('Eigenvalue')
grid on
ylim([0 4])


% Characteristic space between values of greater covariance
figure
scatter3(xtrainNoFraudp(:,1),xtrainNoFraudp(:,10),xtrainNoFraudp(:,18))
hold on
scatter3(xtrainIsFraudp(:,1),xtrainIsFraudp(:,10),xtrainIsFraudp(:,18))
title('Feature space transformed')
xlabel('Feature 1')
ylabel('Feature 2')
zlabel('Feature 3')
grid on
legend('No Fraud', 'Fraud')

figure
scatter3(xtrainNoFraud(:,1),xtrainNoFraud(:,2),xtrainNoFraud(:,3))
hold on
% diag(E); % Look for the greatest values in the resulting matrix, those
% will have greater variance.
scatter3(xtrainIsFraud(:,1),xtrainIsFraud(:,2),xtrainIsFraud(:,10))
title('Original feature space')
xlabel('Feature 1')
ylabel('Feature 2')
zlabel('Feature 3')
grid on
legend('No Fraud', 'Fraud')