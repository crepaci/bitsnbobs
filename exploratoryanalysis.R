
# view dataframe metadata: pos, variable, label, col_type, N missing, levels, value_labels
library(labelled)
View(look_for(data))

# find index of any NA values
which(is.na(data), arr.ind=TRUE)

# find any duplicated column names after joining
grep(pattern=".x",names(data),value=TRUE)

# table 1 package
# use in RMD file
library(table1)
table1(~. | explanatoryvar, data=d)

# gg pairs from GGally package
# https://www.r-bloggers.com/2021/06/ggpairs-in-r-a-brief-introduction-to-ggpairs/
library(GGally)
ggpairs(data, columns = 2:4, ggplot2::aes(colour=categoryvariable))

# SPLIT CATEGORICAL AND CONTINUOUS DATA into two datasets
# note that categorical data may be numeric values which will be "continuous" by this method unless it is binary
# adapted from: https://stackoverflow.com/questions/18150801/is-there-an-easy-way-to-separate-categorical-vs-continuous-variables-into-two-da
is.cat = function (variable) {
  ifelse (is.factor(variable)==TRUE, TRUE,
          ifelse(is.character(variable)==TRUE, TRUE,
                 ifelse(is.logical(variable)==TRUE, TRUE,
                        ifelse(length(unique(variable))<=2, TRUE, FALSE))))
}
categoricaldata = data[,sapply(data, is.cat)]
continuousdata = data[,!sapply(data, is.cat)]
categoricaldata$outcome = data$outcome
continuousdata$outcome = data$outcome

# CATEGORICAL FREQUENCY TABLES: all explanatory variables in data set by specific outcome variable
# code modified from: https://stackoverflow.com/questions/50071625/how-to-make-contingency-table-over-a-list-in-r
freqtabs = function (exposure) { table(exposure, data$outcome) }
lapply(data, freqtabs)

# CONTINUOUS SUMMARY INFORMATION: IQR, missing by outcome variable
summaryna = function (exposure) {
  s = summary(exposure)
  na = table(ifelse(is.na(exposure), "NA", "!NA"), data$outcome, exclude=F)
  list(s, na)
}
lapply(data, summaryna)

# CONTINUOUS SUMMARY INFO: mean and standard deviation by outcome variable
meansd = function (exposure) {
  m1 = mean(data[data$outcome==1, exposure], na.rm =T)
  sd1 = sd(data[data$outcome==1, exposure], na.rm =T)
  m2 = mean(data[data$outcome==2, exposure], na.rm =T)
  sd2 = sd(data[data$outcome==2, exposure], na.rm =T)
  mall = mean(data[,exposure], na.rm =T)
  sdall = sd(data[,exposure], na.rm =T)
  list(exposure, m1, sd1, m2, sd2, mall, sdall)
}
lapply(colnames(data), meansd)
