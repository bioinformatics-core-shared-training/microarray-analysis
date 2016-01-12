library(Biobase)
library(breastCancerNKI)
data(nki)
dir.create("data/nki")
write.table(exprs(nki), file="data/nki/NKI.exprs.txt",sep="\t",quote=FALSE)
write.table(pData(nki), file="data/nki/NKI.pData.txt",sep="\t",quote=FALSE)
write.table(fData(nki), file="data/nki/NKI.fData.txt",sep="\t",quote=FALSE)

datadir <- system.file("extdata", package="estrogen")
dir.create("data/estrogen")
sapply(list.files(datadir), function(x) file.copy(paste(datadir,x,sep="/"),"estrogen"))

remotefile <- 'ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE3nnn/GSE3156/matrix/GSE3156_series_matrix.txt.gz'
download.file(remotefile, destfile="data/GSE3156_series_matrix.txt.gz")

url <- "ftp://ftp.ncbi.nih.gov/pub/geo/DATA/SeriesMatrix/GSE33126/"
filenm <- "GSE33126_series_matrix.txt.gz"
if(!file.exists("GSE33126_series_matrix.txt.gz")) download.file(paste(url, filenm, sep=""), destfile=paste0("data/",datafilenm))