source("http://www.bioconductor.org/biocLite.R")
options(BioC_mirror = c("Cambridge" = "http://mirrors.ebi.ac.uk/bioconductor/"))
options(repos = c("CRAN" = "http://cran.ma.imperial.ac.uk"))
biocLite(c("limma","affy","affyPLM","beadarray","GEOquery","genefilter","illuminaHumanv3.db","cluster",
           "ggplot2","GOstats","breastCancerVDX","breastCancerTRANSBIG","breastCancerNKI","pamr","survival",
           "estrogen","ArrayExpress","RColorBrewer","cgdsr"))