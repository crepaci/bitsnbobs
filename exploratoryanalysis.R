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
