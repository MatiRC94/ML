#! /usr/bin/Rscript

# Given a vector, returns a string with its components separated by commas,
# between parentheses
vector2point <- function(v) {
    n <- length(v)
    temp <- paste0("(", v[1])
    for (i in 2:n) {
        temp <- paste0(temp, ", ", v[i])
    }
    temp <- paste0(temp, ")")

    return(temp)
}

args <- commandArgs(trailingOnly=TRUE)
if (length(args) != 1) {
    message("USAGE: ./dataset_stats.R data_file")
    quit()
}

data <- read.csv(args[1], header=FALSE)

# Number of columns in the data matrix.
n = ncol(data)

# Class 0
c0 <- subset(data, data[,n]==0)

# Class 1
c1 <- subset(data, data[,n]==1)

mus0 <- c(1:(n - 1))
mus1 <- c(1:(n - 1))
sds0 <- c(1:(n - 1))
sds1 <- c(1:(n - 1))

for (i in 1:(n - 1)) {
    mus0[i] <- mean(c0[,i])
    sds0[i] <- var(c0[,i])
    mus1[i] <- mean(c1[,i])
    sds1[i] <- var(c1[,i])
}

cat("Distribution parameters:", sep = "\n")
cat("Class 0", sep = "\n")
cat(paste0("mu: ", vector2point(mus0)), sep = "\n")
cat(paste0("sd: ", vector2point(sds0)), sep = "\n")
cat("Class 1", sep = "\n")
cat(paste0("mu: ", vector2point(mus1)), sep = "\n")
cat(paste0("sd: ", vector2point(sds1)), sep = "\n")
cat("", sep="\n")

# # Get bounds
# minX <- min(data$V1)
# maxX <- max(data$V1)
# minY <- min(data$V2)
# maxY <- max(data$V2)
# 
# # Show parameters:
# message("Distribution parameters:")
# message("Class 0")
# message(paste0("mu: (", mean(c0$V1), ", ", mean(c0$V2), ")"))
# message(paste0("sd: (", sd(c0$V1), ", ", sd(c0$V2), ")"))
# message("Class 1")
# message(paste0("mu: (", mean(c1$V1), ", ", mean(c1$V2), ")"))
# message(paste0("sd: (", sd(c1$V1), ", ", sd(c1$V2), ")"))
# 
# png(outputFile)
# plot(c0$V1, c0$V2, xlim=c(minX, maxX), ylim=c(minY, maxY), col="green", xlab="X", ylab="Y")
# par(new=T)
# plot(c1$V1, c1$V2, xlim=c(minX, maxX), ylim=c(minY, maxY), col="red", xlab="X", ylab="Y")
# abline(h=0, v=0)
# 
# message(paste0("Graph file: ", outputFile))
# message("Plotting done")
