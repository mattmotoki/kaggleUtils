kaggleUtils
============

Overview
--------
`kaggleUtils` is an R library that offers helper functions for kaggle competitions. Functions support:
- easy loading and saving of data in various file formats (csv, txt, rds, xgb, json)
- encoding of categorical variables


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
# saves "./input/clusters/skmeans/train_features.csv"
saveData("train_features", folder="clusters", subfolder="skmeans")

# saves "./input/train_features.csv"
saveData("train", suffix="features")

# saves "./input/train_features.rds"
saveData("train", suffix="features", file_ext="rds")
```

