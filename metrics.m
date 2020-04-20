RMSE(i) = sqrt(mean((gsubtract(testTargets,y).^2),'all','omitnan'));
MAE(i) = mean(abs(gsubtract(testTargets,y)),'all','omitnan');

RMSE = mean(RMSE, 'all')
MAE = mean(MAE,'all')