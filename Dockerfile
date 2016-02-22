FROM bioconductor/release_base
MAINTAINER Mark Dunning<mark.dunning@cruk.cam.ac.uk>

###Get repository of the course. Install data and R packages
RUN git clone https://github.com/bioinformatics-core-shared-training/microarray-analysis.git /home/rstudio/
WORKDIR /home/rstudio
RUN mkdir -p estrogen
RUN mkdir data/
RUN R -f installBiocPkgs.R
RUN R -f getData.R