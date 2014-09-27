/bootstrap
/  Resamples the dataset and applies a specified function to each resample.
/INPUT
/  ls - original dataset as a list
/  stat - statistic to apply to each resample
/  nr - number of resamples
/OUTPUT
/  out - distribution of statistics
bootstrap:{[ls;stat;nr] stat flip (nr;count ls)#nr?ls}
 
/percentile 
/  Sorts list and grabs value nearest (rounding down) to the given percentile.
/INPUT
/  ls - original data as a list
/  pct - percentile
/OUTPUT
/  out - nearest value at percentile
percentile:{[ls;pct] (asc ls) ["i"$(1 xbar (pct*(count ls)%100) )] } 
 
/olsfit
/   Obtain Ordinary Least Squares (OLS) coefficients.
/INPUT
/   x: predictors (as a N x M list)
/   y: responses (as an N x 1 list)
/OUTPUT
/   out: M x 1 list of coefficients
olsfit:{[x;y] (inv (flip x) mmu x) mmu ((flip x) mmu y) }

/wlsfit
/   Obtain Weighted Least Squares (WLS) coefficients.
/INPUT
/   x: predictors (as a N x M list)
/   y: responses (as an N x 1 list)
/   W: weighting matrix (as an N x N list)
/OUTPUT
/   out: M x 1 list of coefficients 
wlsfit:{[x;y;W] (inv (flip x) mmu (inv W) mmu x) mmu ((flip x) mmu (inv W) mmu y) }

/eye
/   Create a identity matrix.
/INPUT
/   n: size of the square matrix.
/   val: value of the diagonal entries.
/OUTPUT
/   out: n x n diagonal matrix.
eye:{[n] (n,n)#(1,n#0f)@((til n*n) mod (n+1))}


/ covariance matrix (8 times faster than x cov/:\:x)
cvm:{(x+flip(not n=\:n)*x:(n#'0.0),'(x$/:'(n:til count x)_\:x)%count first x)-a*\:a:avg each x}
/ correlation matrix
crm:{cvm[x]%u*/:u:dev each x}

