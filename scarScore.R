#!/usr/bin/env Rscript

options(stringsAsFactors=FALSE)
library(scarHRD)

args = commandArgs(trailingOnly=TRUE)

# arguments
facets_seg_file <- args[1]
ploidy_file <- args[2]
sample_name <- args[3]

if (length(args) != 3 ){
  stop('One or more arguemnts is missing.\nUsage: Rscript scarScore.R [facets.segmentation.file.txt] [ploidy.file.txt] [sample_name]')
}

# read inputs
cnv_table <- read.table(facets_seg_file, sep = "\t", header = TRUE)
cnv_table <- cnv_table[!is.na(cnv_table$cf.em) & !is.na(cnv_table$mafR.clust),]
ploidy_table <- read.table(ploidy_file, sep = "\t", header = TRUE)

# make input table
# Note: package documentation is outdated; see https://github.com/sztup/scarHRD/issues/7#issuecomment-767525024
scarHRD_input_table <- data.frame(
  sample = rep(sample_name, nrow(cnv_table)),
  chrom = cnv_table$chrom,
  start = cnv_table$start,
  end = cnv_table$end,
  probes = cnv_table$nhet,
  total_cn = cnv_table$tcn.em,
  acn = cnv_table$tcn.em - cnv_table$lcn.em,
  bcn = cnv_table$lcn.em,
  ploidy = rep(ploidy_table$ploidy, nrow(cnv_table)),
  purity = rep(ploidy_table$purity, nrow(cnv_table))
  )

# input table in & out as intermediate file
write.table(scarHRD_input_table, paste0(sample_name, '_HRDinputs.txt'), sep = "\t", col.names = TRUE, row.names = FALSE, quote = FALSE)  
# get SCAR data & outputs
scar_data <- scar_score(paste0(sample_name, '_HRDinputs.txt'), reference = "grch38", seqz=FALSE, chr.in.names=FALSE, ploidy=ploidy_table$ploidy)
scar_data <- as.data.frame(scar_data)
cols <- colnames(scar_data)
scar_data$sampleID <- sample_name
scar_data <- scar_data[, c('sampleID', cols)] # reorder columns
colnames(scar_data) <- make.names(scar_data) # make column names valid R names
write.table(scar_data, paste0(sample_name, '_HRDresults.txt'), sep = "\t", col.names = TRUE, row.names = FALSE, quote = FALSE)  