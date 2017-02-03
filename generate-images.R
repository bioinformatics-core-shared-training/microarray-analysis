library(beadarrayExampleData)
data("exampleSummaryData")
data <- channel(exampleSummaryData,"G")
M <- exprs(data)[,1] - exprs(data)[,8]
A <- 0.5*(exprs(data)[,1] + exprs(data)[,8])
library(ggplot2)
df <- data.frame(M,A)
p<- ggplot(df, aes(x = A,y=M)) + geom_point() + geom_smooth() + geom_hline(yintercept=0,col="red",lty=2)
ggsave(p, file="images/non-linear.png",width=4,height=4)


library(affy)
targetsFile <- "estrogen/estrogen.txt"
targetsFile
pd <- read.AnnotatedDataFrame(targetsFile,header=TRUE,sep="",row.names=1)
pData(pd)

raw <-ReadAffy(celfile.path = "estrogen", filenames=rownames(pData(pd)),phenoData = pd)

png("images/linear-effects.png")
boxplot(raw,las=2)

x <- raw
tmp <- unlist(indexProbes(x, which="both"))
tmp <- tmp[seq(1, length(tmp), len = 5000)]
df <- data.frame(log2(intensity(x)[tmp, ]))
med <- median(as.matrix(df))

abline(h=med,lty=2,col="red")

dev.off()

eset <- rma(raw)

suppressPackageStartupMessages(library(genefilter))
eset.filt <- varFilter(eset)
corMat <- 1- cor(exprs(eset.filt))
png("images/affy-clustering.png")
plot(hclust(as.dist(corMat)))
dev.off()

pca <- prcomp(exprs(eset))

pd <- data.frame(pData(eset),pca$rotation)
p <- ggplot(pd, aes(x=PC1,y=PC2,col=estrogen,pch=as.factor(time.h))) + geom_point()
ggsave(p, file="images/affy-pca.png",width=8,height=4)


library(beadarrayExampleData)
data("exampleSummaryData")
data <- channel(exampleSummaryData, "G")
d <- dist(t(exprs(data)))
png("images/array-clustering.png")
plot(hclust(d))
dev.off()

library(WGCNA)
data.noout <- data[,-c(7,8)]
d <- dist(t(exprs(data.noout)))
pd <- pData(data.noout)
cols <- ifelse(pd[,2] =="UHRR", "red","blue")
cols2 <- ifelse(strtrim(sampleNames(data.noout),5) == "46137","yellow","green")

colM <- cbind(cols,cols2)
colnames(colM) <- c("Group","Batch")
png("images/annotated-clustering.png")
plotDendroAndColors(hclust(d), as.matrix(colM))
dev.off()


par(mfrow=c(1,1))
arrays <- 1:10
gene2 <- c(-1, -0.5, 0.3, -0.4,0.7,0.9, 1.1,0.8,1.5,1.3)
gene1 <- gene2+2
gene3 <- gene1 + runif(10,min = -0.4,0.4)
png("images/cor-vs-dist.png")
plot(arrays,gene1,type="b",pch=16,col="blue",ylim=c(-2,4))
lines(arrays,gene2,type="b",col="red",pch=16)
lines(arrays,gene3,type="b",col="green",pch=16)
legend("topleft",legend=c("Gene1","Gene2","Gene3"),col=c("red","blue","green"),lty=1,lwd=2)

dev.off()



download.file("https://www.mathstat.strath.ac.uk/outreach/nessie/datasets/whiskies.txt",destfile = "whiskies.txt")
whisky <- read.csv("whiskies.txt")
scores <- whisky[,c(3:14)]
rownames(scores) <- whisky$Distillery

pca <- prcomp(scores)
df <- data.frame(whisky,pca$x)
library(ggplot2)
p <- ggplot(df, aes(x=PC1,y=PC2,label=Distillery)) + geom_point() + geom_text(alpha=0.3)
ggsave(p, file="images/whisky-pca.png",width=10,height=5)

pca <- prcomp(scores)
df <- data.frame(whisky,pca$x)
library(ggplot2)
p <- ggplot(df, aes(x=PC1,y=PC2,label=Distillery,cex=Smoky,col=as.factor(Floral))) + geom_point() + geom_text(cex=5,alpha=0.3)
ggsave(p, file="images/whisky-pca-annotated.png",width=12,height=5)


suppressPackageStartupMessages(library(MAQCsubsetILM))


data(refA);data(refB);data(refC);data(refD)
gse = combine(refA, refB, refC, refD)
sites = pData(gse)[,2]
shortlabels = substr(sampleNames(gse), 7,8)
rnasource = pData(gse)[,3]
levels(rnasource) = c("UHRR", "Brain", "UHRR75", "UHRR25")

d <- dist(t(exprs(gse)))
pc <- princomp(d)


Lab <- paste("Lab",sites,sep="")
df <- data.frame(Lab,rnasource,PC1=pc$loadings[,1],PC2=pc$loadings[,2])
p <- ggplot(df, aes(x = PC1,y=PC2, col=rnasource,pch=Lab)) + geom_point(cex=5)
ggsave(p, file="images/MAQC-pca.png")


suppressPackageStartupMessages(library(limma))
gse.batchcorrect <- removeBatchEffect(log2(exprs(gse)), batch=sites)
d2 <- dist(t(gse.batchcorrect))
pc2 <- princomp(d2)

df <- data.frame(Lab,rnasource,PC1=pc2$loadings[,1],PC2=pc2$loadings[,2])
p <- ggplot(df, aes(x = PC1,y=PC2, col=rnasource,pch=Lab)) + geom_point(cex=5)
ggsave(p, file="images/MAQC-pca-corrected.png")