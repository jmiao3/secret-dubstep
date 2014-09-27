James Miao

// Objective

The idea is to develop some Machine Learning/Stats/Time Series Analysis tools for analysis of data.

// Structure

numerics.q	numerical routines, e.g. LAPACK
stats.q		time series/statistics related functions
ml.q		machine learning related functions
optim.q		optimisation related functions

// Commenting Style

Here is an example from olsfit. 

/olsfit
/   Obtain Ordinary Least Squares (OLS) coefficients.
/INPUT
/   x: predictors (as a N x M list)
/   y: responses (as an N x 1 list)
/OUTPUT
/   out: M x 1 list of coefficients

