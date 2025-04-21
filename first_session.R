# Data Visualization Seminar in R

# 1. Basics of Graphics in R
# --------------------------
# Understanding base R plotting functions

# Basic plot with points
plot(1:10, 1:10, main="Basic Scatter Plot", xlab="X Axis", ylab="Y Axis", pch=16, col="blue")

# Line plot
plot(1:10, 1:10, type="l", col="red", lwd=2, main="Line Plot Example")

# Adding shapes
rect(2, 2, 8, 8, border="black", col=rgb(0.2,0.4,0.6,0.3))
abline(h=5, col="blue", lty=2)
points(5, 5, pch=19, col="red", cex=2)

# 2. Introduction to ggplot2
# ---------------------------
library(ggplot2)

# Basic ggplot2 scatter plot
data(mtcars)
ggplot(mtcars, aes(x=wt, y=mpg)) + 
  geom_point(color="blue") + 
  labs(title="Weight vs MPG", x="Weight", y="Miles per Gallon")

# 3. Genomic Data Visualization
# -----------------------------
library(pheatmap)
library(ComplexHeatmap)
library(ggplot2)
library(ggrepel)
library(factoextra)
library(qqman)

# Example Heatmap
data_matrix <- matrix(rnorm(100), nrow=10)
pheatmap(data_matrix, main="Heatmap Example")

# Example Volcano Plot with ggplot2
data <- data.frame(logFC = rnorm(100), pval = runif(100))
data$significant <- data$pval < 0.05
ggplot(data, aes(x=logFC, y=-log10(pval), color=significant)) +
  geom_point() +
  labs(title="Volcano Plot", x="Log Fold Change", y="-log10 P-value")

# Example Volcano Plot using Base R
plot(data$logFC, -log10(data$pval), pch=16, col=ifelse(data$significant, "red", "black"), 
     xlab="Log Fold Change", ylab="-log10 P-value", main="Volcano Plot (Base R)")
abline(h=-log10(0.05), col="blue", lty=2)

# Example PCA Plot with ggplot2
data_pca <- prcomp(mtcars[,c("mpg", "hp", "wt")], scale.=TRUE)
fviz_pca_biplot(data_pca)

# Example PCA Plot using Base R
biplot(data_pca, main="PCA Biplot (Base R)", col=c("blue", "red"))

# Example Manhattan Plot with ggplot2
data_gwas <- data.frame(SNP=1:100, CHR=rep(1:5, each=20), BP=1:100, P=runif(100))
manhattan(data_gwas, main="Manhattan Plot")

# Example Manhattan Plot using Base R
plot(data_gwas$BP, -log10(data_gwas$P), pch=16, col=data_gwas$CHR, 
     xlab="Genomic Position", ylab="-log10 P-value", main="Manhattan Plot (Base R)")

# 4. Customization & Exporting
# ----------------------------
ggplot(data, aes(x=logFC, y=-log10(pval), color=significant)) +
  geom_point(size=3) +
  theme_minimal() +
  labs(title="Customized Volcano Plot") +
  ggsave("./volcano_plot.png", width=6, height=4, dpi=300)
