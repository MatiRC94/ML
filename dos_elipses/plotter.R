#! /usr/bin/Rscript

args <- commandArgs(trailingOnly=TRUE)
if (length(args) != 1) {
    message("Missing file name")
    quit()
}

dataFile <- paste0(args[1], ".predic")

outputFile <- paste0(args[1], ".png")

data <- read.table(dataFile, header=FALSE)
if (ncol(data) != 3) {
    message("File format not supported. Expected 2-dimensional vectors.")
    quit()
}

# Class 0
c0 <- subset(data, V3==0)

# Class 1
c1 <- subset(data, V3==1)

# Get bounds
minX <- min(data$V1)
maxX <- max(data$V1)
minY <- min(data$V2)
maxY <- max(data$V2)

# Show parameters:
message("Distribution parameters:")
message("Class 0")
message(paste0("mu: (", mean(c0$V1), ", ", mean(c0$V2), ")"))
message(paste0("sd: (", sd(c0$V1), ", ", sd(c0$V2), ")"))
message("Class 1")
message(paste0("mu: (", mean(c1$V1), ", ", mean(c1$V2), ")"))
message(paste0("sd: (", sd(c1$V1), ", ", sd(c1$V2), ")"))

png(outputFile)
plot(c0$V1, c0$V2, xlim=c(minX, maxX), ylim=c(minY, maxY), col="green", xlab="X", ylab="Y")
par(new=T)
plot(c1$V1, c1$V2, xlim=c(minX, maxX), ylim=c(minY, maxY), col="red", xlab="X", ylab="Y")
abline(h=0, v=0)

message(paste0("Graph file: ", outputFile))
message("Plotting done")

