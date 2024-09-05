
# NOTE: when there are NAs in a variable, a logical vector will also return NA, seemingly introducing an NA row where it doesn't exist or an NA in a different column
# I fixed this by grabbing the index of TRUE values only using which()
id=c(1,2,3,4,5)
y=c("yes", NA, "no", "yes", "no")
d = data.frame(id, y)
d
#   id    y
# 1  1  yes
# 2  2 <NA>
# 3  3   no
# 4  4  yes
# 5  5   no
d[d$y=="yes", ]
#    id    y
# 1   1  yes
# NA NA <NA>
# 4   4  yes
d[d$y=="yes", "id"]
#  1 NA  4
d$y=="yes"
# TRUE  NA  FALSE  TRUE  FALSE
d[which(d$y=="yes"), ]
#   id   y
# 1  1 yes
# 4  4 yes
d[which(d$y=="yes"), "id"]
# 1 4

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
