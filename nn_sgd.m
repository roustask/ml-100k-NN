% This script assumes these variables are defined:
%   onehot - input data.
%   hack - target data.

%%uncomment the parameters or functions needed for implementation
%five fold CV
for i=1:5
x = input';
t = targets';

%%used for A3
trainFcn = 'traingdm';  


% Create a Fitting Network
hiddenLayerSize = [10];
net = fitnet(hiddenLayerSize,trainFcn);

% Performance function aka loss function
net.performFcn = 'mse';  % Mean Square Error
%net.performParam.regularization = 0.1;

net.layers{2}.transferFcn = 'purelin'; %default 
net.layers{1}.transferFcn = 'logsig';
%net.layers{3}.transferFcn = 'logsig';

net.trainParam.epochs = 200;

%used for A3 
net.trainParam.lr = 0.05;
net.trainParam.mc = 0.6;

net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
};

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y);


% Recalculate Training, Validation and Test Performance
trainTargets = t .* trainMask{1,i};
valTargets = t .* testMask{1,i};
testTargets = t .* testMask{1,i};
trainPerformance = perform(net,trainTargets,y);
valPerformance = perform(net,valTargets,y);
testPerformance = perform(net,testTargets,y);

%used for 5-fold CV
RMSE(i) = sqrt(mean((gsubtract(testTargets,y).^2),'all','omitnan'));
MAE(i) = mean(abs(gsubtract(testTargets,y)),'all','omitnan');
end

% View the Network
view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotinerrcorr(x,e)
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)