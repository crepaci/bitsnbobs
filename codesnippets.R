  # SEPARATE MODEL COEFFICENTS
  beta = c("b.i", "b.x1", "b.x2", "b.c")
  for (i in 1:length(beta)) {
    assign(beta[i], model$coefficients[i])
  }


  # SEPARATE VARIANCE-COVARIANCE
  vcovvars = c("i.i", "i.x1", "i.x2", "i.c", 
                "x1.x1", "x1.x2", "x1.c", 
                "x2.x2", "x2.c", 
                "c.c")
  k = 1
  for (r in 1:nrow(model$vcov)) {
    for (c in r:ncol(model$vcov)) {
      assign(vcovvars[k], model$vcov[r,c])
      k=k+1
    }
  }
