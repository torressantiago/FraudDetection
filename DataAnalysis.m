%% Data analysis
load xtrain.mat
load ytrain.mat

%% PCA analysis
% Step 1: Remove the mean
xmean = mean(xtrain);
rmean = xtrain-xmean;

% Step 2: Compute covariance matrix
E = cov(rmean);

% Step 3: Find eigenvalues and eigenvectors
[Evect, Eval] = eig(E);

% Step 4: Remove unwanted characteristics
temp = Eval(Eval >= 0.01); % Threshold for wanted variances

NEvect = ones(377,18);
NEval = ones(377,377);

for i = 1:18
    [row, col] = find(Eval == temp(i));
    NEvect(:,i) = Evect(:, col);
    NEval(:,i) = Eval(:, col);
end

NEval = NEval(360:end,:);

% Step 5: Transform original matrix to new space
xtrainp = xtrain*NEval';

% Save results
save xtrainp.mat xtrainp