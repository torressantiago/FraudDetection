%% LMS Train
load Xtrain.mat
load Ytrain.mat
load XwPCATrain.mat
load XwPCATTrain.mat
%% LMS 1: Without PCA
% _Step 1: Implement classifier_
LMSwoPCA = LMS(XTrain',YTrain',1e-20,100e3);

%% LMS 2: with PCA but no space transformation
LMSwPCA = LMS(XwPCATrain',YTrain',1e-20,1e5);

%% LMS 3: with PCA with transformation
LMSwPCAT = LMS(XwPCATTrain',YTrain',1e-20,1e5);

%% Save models
save LMSwoPCA.mat LMSwoPCA
save LMSwPCA.mat LMSwPCA
save LMSwPCAT.mat LMSwPCAT

%% LMS implementation
function w = LMS(X,Y,eta,max_iter)
    epsilon = 1e-12; % Desired precision
    d = size(X,1); % Number of features
    w_next = ones(d,1);
    for i = 1:max_iter
    w = w_next;
    w_next = w - eta*de(w,X,Y);
    step = w_next - w;
        if norm(step) <= epsilon
            break;
        end
        %disp(['Error function in iteration ',num2str(i),': ',num2str(e(w,X,Y))]);
    end
    disp(['Error function in iteration ',num2str(i),': ',num2str(e(w,X,Y))]);
end

function error = e(w,x,y)
    error = 0;
    for i1 = 1:size(x,2)
        error = error + 0.5*((w'*x(:,i1)-y(i1))^2);
    end
end


function grad = de(w,x,y)
    d = size(x,1); % Number of features
    grad = ones(d,1);
    for i2 = 1:size(x,1)
        grad = grad + x(:,i2)*(w'*x(:,i2)-y(i2));
    end
end