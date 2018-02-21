kaggleUtils
============

Overview
--------
`kaggleUtils` is an R library that offers helper functions for kaggle competitions including:
- easily load and save data in various file formats including: csv, rds, xgb, json.
- functions for handling `xgb.DMatrix` and `lgb.Dataset` objects
- modern categorical encoders


Installation
------------

``` r
# install.packages("devtools")
devtools::install_github("mattmotoki/kaggleUtils")
```

Usage
-----

Loading data
``` r
# load "./input/**/train_features.csv"
loadData("train_features")

# loads "./input/**/train_features.csv"
loadData("train", suffix="features")

# loads "./input/**/train_features.rds"
loadData("train", suffix="features", file_ext="rds")
```

Saving data
``` r
# save "./input/clusters/skmeans/train_features.csv"
saveData("train_features", folder="clusters", subfolder="skmeans")

# save "./input/train_features.csv"
saveData("train", suffix="features")

# save "./input/train_features.rds"
saveData("train", suffix="features", file_ext="rds")
```

