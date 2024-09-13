# FILE TITLE HERE
# Written by Charlie Repaci
# Adapted from file/path/here

# REFERENCES:
# path/to/documentation
# any.tutorial.webpage.com

# PURPOSE:
#' What does this file do? How does that fit in with the rest of the pipeline?
#' What is given at the start of this problem and what is the outcome?

# NOTES:
#' Special considerations and decisions


#################################### SET UP ####################################
# SET YOUR WORKING DIRECTORY TO THE PROJECT FOLDER
setwd(paste0(Sys.getenv("RKJCOLLAB"), "/Project_Folder"))

# SETUP RUN LOG
start.time = paste0("Start Time: ", format(Sys.time(), "%a %b %d %Y %X"))
log.path = paste0("documentation/code/doc/path/run-log/THIS_FILE_NAME_", 
                  format(Sys.time(), "%Y-%m-%d.%H%M"), ".txt")
log.file = file(log.path, open = "wt")
sink(file=log.file, type="message")
sink(file=log.file, type="output")

# LIBRARIES
library(libname) # what do you use this library for

# LOAD IN DATA
data = read.csv("data/path/file.csv") # data used for...
load("data/path/file.Rdata") # data used for...

# SET FUNCTIONS ----------------------------------------------------------------


# DATA CLEANING ----------------------------------------------------------------


################################## SET UP END ##################################


# do stuff here


#################################### OUTPUT ####################################

# SAVE FILES
write.csv(data, "data/path/file.csv", row.names = F)
save(object, "data/path/file.RData")

# SESSION INFO OUTPUT
sink(file=NULL, type="output")
sink(file=NULL, type="message")
end.time = paste0("End Time: ", format(Sys.time(), "%a %b %d %Y %X"))
session.info = capture.output(sessionInfo())
info.text = c("\n***\n", start.time, end.time, "\n***\n", session.info)
write(info.text, log.file, append=TRUE)
unlink(log.file)
