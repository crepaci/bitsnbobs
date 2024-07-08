# file stores helpful math functions in code form


# function created by Lauren Vanderlinden
# convert DNA methylation M values to beta values 
getBeta <- function(m){
  b = 2^m/(1 + 2^m)  
  return(b)
}

# function created by Lauren Vanderlinden
# convert DNA methylation beta values to M values 
getM <- function(b){ 
  m = log2(b/(1-b))  
  return(m) 
}
