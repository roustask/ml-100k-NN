How to run:

* import data from ml-100k (u.data) in numeric matrix format
* run preprocess function with 
```matlab
[data,targets] = preprocess_data(u);
```
* run `one_hot_input.m`
* run `five_foldcv.m`
* run `nn.m` with customable parameters or
* run `nn_sgd.m` for A3 or
* run `nn_dr.m` for A4 