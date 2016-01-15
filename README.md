# microarray-analysis
Materials on the analysis of microarray expression data; focus on re-analysis of public data


## Day one

- Intro to microarray technology (Illumina / affy) & Data analysis
    + probes, target terminology
    + Bioconductor introduction
    
- Prac; 1st look at microarray data and R refresher
    + Existing Bioc practical
    
-Specific technologies
    + Affy workflow
    + Illumina workflow
    + Diagnostic plots
    + Quality control / normalisation
    
- Linear models and statistics for differential expression

## Day two

- Practical on differential expression

- Advanced aspects of analysis
    + Annotation
    + Batch effects
    
- Clustering, PCA, (survival?)

- Existing prac


Use this?

source("https://bioconductor.org/biocLite.R")
biocLite("Affyhgu133Plus2Expr")
