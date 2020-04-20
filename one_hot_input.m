%%one-hot input encoding
foronehot = [1:943]';
onehot = ((foronehot./[1:943]) == 1);
input = sparse(double(onehot));