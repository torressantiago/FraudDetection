%% Data Cleanse
load TrainData.mat
load TrainDataH.mat

%% Quantity of NaN's
NaNNum = isnan(TrainData); % Determine NaN placement
NaNNum = double(NaNNum);

% Determine quantity of NaN per characteristic
IsNaNSum = sum(NaNNum);

% % Show in plot
% figure
% bar(IsNaNSum)
% xlabel('Characteristic')
% ylabel("Number of NaN's")
% grid on

%% Data removal

NTrainData = zeros(590540,379);
NTrainDataH = strings(1,379);

% Remove all characteristics that have way too much NaN
for i = 1:394
    if IsNaNSum(:,i) < 12 % Adjust threshold for NaN elimination
        NTrainData(:,i) = TrainData(:,i); % For data
        NTrainDataH(:,i) = TrainDataH(:,i); % For headers
    end
end

% It is important to note that by doing this, there is a reduction in the
% number of characteristics from 394 to 379. This implies that 3.8% of
% characteristics were lost.

% % Verify that there are no arrays with NaN
% NaNNum = isnan(NTrainData); % Determine NaN placement
% NaNNum = unique(NaNNum);
% 
% if sum(NaNNum) == 0
%     fprintf("The matrix is NaN free\n")
% else
%     fprintf("The matrix has NaN numbers\n")
% end

% Remove product code and separate y array
X = NTrainData(:, 4:end);
Y = double(~(NTrainData(:, 2)));

% save X.mat X
% save Y.mat Y