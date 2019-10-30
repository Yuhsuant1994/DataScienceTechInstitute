# Statistic

## 1) Foundations of Statistical Analysis 
  
### [FSML project](https://github.com/Yuhsuant1994/DataScienceTechInstitute/tree/master/Statistic/FSML_project)

[Questions](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Statistic/FSML_project/DSTIFundationsjuil19.pdf)

[Report](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Statistic/FSML_project/(Report_PDF)FSMLpart2_Yu-Hsuan_TING.pdf)

   -> Use R to compute probability and quantile 
    
   -> Estimator exercise
    
   -> Estimate distribution from raw data
    
   -> Exercise with exponential distribution

## 2) Advance Statistical Analysis 

## 3) CART: Classification and Regression Trees (final combine with Random Forest)

[rmarkdown report](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Statistic/CART.pdf)
 
   * Step 1: Build maximal tree
   * Step 2: Prunning
   * Step 3: Select tree
   * Unstability solution: bagging
   * Prediction and variable selection from CART
 
 Final part for the project is to combine it with Random Forest, which is commonly used in practice.
 
 * use random forest to perform variable selection
 * built CART from the selected variables
 * visualize the selected tree
 
 ## 4) Statistical analysis of massive data

[Descriptive statistic and clustering](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Statistic/Statistical%20analysis%20of%20massive%20data/1.%20Descriptive%20statistic%20and%20clustering.pdf)

**Descriptive statistic**

* Histogram: `hist` by R, `ggplot` (additional density lines by `lines`)
* Boxplot: `boxplot`
* Barplot:  `barplot`
* Pair plot: `pairs` to see the relationship between variable

**Unsupervised learning: clustering**

* K-means clustering: `kmeans` form `library(class)`
* hierarchical clustering: `hclust` from `library(class)`
* The Mixture model and the EM algorithm: `Mclust` from `library(mclust)`, `mixmodCluster` from `library(Rmixmod)`

[**Dimension reduction**](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Statistic/Statistical%20analysis%20of%20massive%20data/2.%20dimensional%20reduction.pdf)

* PCA: `princomp` in R, `PCA` in `library(FactoMineR)`
* Multidimensional scaling: `cmdscale`

[**Supervised learning, Learning in high-dimensional spaces**](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Statistic/Statistical%20analysis%20of%20massive%20data/3.%20Supervised%20learning%2C%20Learning%20in%20high%20dimention.pdf)


