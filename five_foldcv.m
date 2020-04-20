% 5-fold CV of the ratings column
cv = cvpartition(data(:,3), 'KFold', 5); 
movies = 1682; users = 943;
for i=1:5
    %reshape data into proper format
    trainMask{1,i} = double(reshape(cv.training(i),movies,users));
    testMask{1,i} = double(reshape(cv.test(i),movies,users));
    
    %replace zeros with NaN
    trainMask{1,i}(trainMask{1,i}==0) = NaN;
    testMask{1,i}(testMask{1,i}==0) = NaN; 
end