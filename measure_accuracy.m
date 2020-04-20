%another metric is accuracy via confusion matrix
%however, percentages cannot be precise since values are not rounded

[c,cm] = confusion(t,y);

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);
