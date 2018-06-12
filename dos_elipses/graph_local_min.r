#! /usr/bin/Rscript
## El archivo con el mínimo es:
## dos_elipses_0.70_0.006.mse

args <- commandArgs(trailingOnly=TRUE)
if (length(args) != 1) {
    message("Missing file name")
    quit()
}

mseAvgFile <- paste0(args[1], ".mse.avg")
outputFile <- paste0(args[1], ".png")

table = read.table(mseAvgFile,header=FALSE)
col5 = table[,"V2"]
col6 = table[,"V3"]
col7 = table[,"V4"]
xvals = seq(400, 40000, 400)
# After prunning node count
# png("nodecap3.png")
# limy <- c(min(p_nodes_ap, d_nodes_ap),max(p_nodes_ap,d_nodes_ap))
# plot(n, d_nodes_ap, col="red", ylim=limy,type="o", xlab="Valor de C", ylab="Decision tree nodes")
# lines(n, p_nodes_ap, col="blue", type="o")
# legend(  x="topright",
#        , legend=c("Diagonal", "Parallel")
#        , col=c("red", "blue")
#        , lty=c(1,1)
#        )
# dev.off()
col1 <- lowess(col5~xvals, f=0.4)
col2 <- lowess(col6~xvals, f=0.4)
col3 <- lowess(col7~xvals, f=0.4)

print(xvals)
print(col5)
png(outputFile)
plot(xvals, col5, col="red", xlim=c(400,40000), xlab="Epocas", ylab="Error de Clasificación")
points(xvals,col6, col="blue")
points(xvals,col7, col="green")
lines(col1, col="red")
lines(col2, col="blue")
lines(col3, col="green")
legend(x="topright", legend=c("Entrenamiento", "Validación", "Test"),
       col=c("red", "blue", "green"), lty=c(1,1))
#dev.off()

#png("mse_graph_zoom.png")
#plot(xvals, col5, col="red", xlim=c(15000,40000), ylim=c(0,0.15), xlab="Epocas", ylab="Error de Clasificación")
#points(xvals,col6, col="blue")
#points(xvals,col7, col="green")
#lines(col1, col="red")
#lines(col2, col="blue")
#lines(col3, col="green")
#legend(x="topright", legend=c("Entrenamiento", "Validación", "Test"),
#       col=c("red", "blue", "green"), lty=c(1,1))
#dev.off()
