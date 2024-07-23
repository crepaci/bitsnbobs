  # SEPARATE MODEL COEFFICENTS
  beta = c("b1", "b2", "b3", "b4")
  for (i in 1:length(beta)) {
    assign(beta[i], model$coefficients[i])
  }
