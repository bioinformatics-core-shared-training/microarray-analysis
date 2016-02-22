library(Biobase)
library(breastCancerNKI)

datadir <- system.file("extdata", package="estrogen")
dir.create("data/estrogen",showWarnings = FALSE)
sapply(list.files(datadir), function(x) file.copy(paste(datadir,x,sep="/"),"estrogen"))


remotefile <- 'ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE1nnn/GSE1729/matrix/GSE1729_series_matrix.txt.gz'
destfile <- "data/GSE1729_series_matrix.txt.gz"
if(!file.exists(destfile)) download.file(remotefile, destfile)

remotefile <- 'ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE18nnn/GSE18088/matrix/GSE18088_series_matrix.txt.gz'
destfile <- "data/GSE18088_series_matrix.txt.gz"
if(!file.exists(destfile)) download.file(remotefile, destfile)

url <- "ftp://ftp.ncbi.nih.gov/pub/geo/DATA/SeriesMatrix/GSE33126/GSE33126_series_matrix.txt.gz"
filenm <- "data/GSE33126_series_matrix.txt.gz"
if(!file.exists(filenm)) download.file(url, destfile=filenm)