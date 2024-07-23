
# initialize empty data frame with specific dimensions and column names
# source: https://stackoverflow.com/questions/32712301/create-empty-data-frame-with-column-names-by-assigning-a-string-vector
df <- data.frame(matrix(ncol = 3, nrow = 0))
colnames(df) <- c("name", "age", "gender")

# add row to data frame 
# source: https://stackoverflow.com/questions/28467068/how-to-add-a-row-to-a-data-frame-in-r
df[nrow(df) + 1,] = c("v1","v2")

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
