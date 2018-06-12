#!/usr/bin/env Rscript

#require(plot3D)
#require(oce)
#require(spatstat)
#require(imager)
#require(xtable)


diagonal_dtree_data <- read.csv("../../TP1/ej7/temp/ej7_diagonal.errors", header = TRUE)
parallel_dtree_data <- read.csv("../../TP1/ej7/temp/ej7_paralelo.errors", header = TRUE)

diagonal_ann_data <- read.table("../../TP2/dimens/temp_e/calc/diagonal.discrete.errors", header=T)
parallel_ann_data <- read.table("../../TP2/dimens/temp_e/calc/paralelo.discrete.errors", header=T)

diagonal_bys_data <- read.csv("temp_e/e_diagonal.errors", header=T)
parallel_bys_data <- read.csv("temp_e/e_paralelo.errors", header=T)


#diag_train_dtree = diagonal_dtree_data$TrainEAP
diag_test_dtree = diagonal_dtree_data$TestEAP

#par_train_dtree = parallel_dtree_data$TrainEAP
par_test_dtree = parallel_dtree_data$TestEAP

diag_test_ann = diagonal_ann_data$DiscreteError
par_test_ann = parallel_ann_data$DiscreteError




diag_test_bys = diagonal_bys_data$Test

par_test_bys = parallel_bys_data$Test



#dims = diagonal_dtree_data$dim
dims_names = c("2", "4", "8", "16", "32") 

dims = diagonal_ann_data$Dimensions




minY <- min(diag_test_dtree, par_test_dtree, diag_test_ann, par_test_ann, diag_test_bys, par_test_bys )
maxY <- max(diag_test_dtree, par_test_dtree, diag_test_ann, par_test_ann, diag_test_bys, par_test_bys)




png("anns_vs_dtree_vs_bys.png")
par(mar=c(4,4,1,1))
plot(dims, diag_test_dtree,  col="red", ylim=c(minY,maxY), pch=20, lwd=2, type="o", ylab="Test error percentage", xlab="Dimensions") # xaxt="n")
points(dims, diag_test_ann, col="blue", pch=20, lwd=2, type="o")
points(dims, par_test_dtree, col="green", pch=20, lwd=2, type="o")
points(dims, par_test_ann, col="orange", pch=20, lwd=2, type="o")
points(dims, diag_test_bys, col="black", pch=20, lwd=2, type="o")
points(dims, par_test_bys, col="pink", pch=20, lwd=2, type="o")
legend(x = "topleft",legend = c("Diagonal_DT", "Parallel_DT", "Diagonal_ANN", "Parallel_ANN","Diagonal_BYS","Parallel_BYS"), col=c("red", "green", "blue", "orange", "black", "pink"), lwd=2)
#axis(1, at=dims, labels=dims_names)
