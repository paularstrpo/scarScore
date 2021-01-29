FROM rocker/tidyverse:4.0.2

RUN apt-get update 

# libraries
RUN Rscript -e "devtools::install_github('aroneklund/copynumber')"
RUN Rscript -e "devtools::install_github('sztup/scarHRD')"
COPY scarScore.R /bin/
RUN chmod +x /bin/scarScore.R

CMD ["/bin/bash"]