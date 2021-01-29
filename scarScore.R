#!/usr/bin/env Rscript

options(stringsAsFactors=FALSE)
library(scarHRD)

args = commandArgs(trailingOnly=TRUE)

# arguments
facets_seg_file <- args[1]
ploidy_file <- args[2]

if (length(args) != 2 ){
  stop('One or more arguemnts is missing.\nUsage: Rscript scarScore.R [facets.segmentation.file.txt] [ploidy.file.txt]')
}

# read inputs
cnv_table <- read.table(facets_seg_file, sep = "\t", header = TRUE)
cnv_table <- cnv_table[!is.na(cnv_table$cf.em) & !is.na(cnv_table$mafR.clust),]

ploidy_table <- read.table(ploidy_file, sep = "\t", header = TRUE)

# make input table
scarHRD_input_table <- data.frame(
  # SampleID = rownames(cnv_table),
  Chromosome = cnv_table$chrom,
  Start_position = cnv_table$start,
  End_position = cnv_table$end,
  total_cn = cnv_table$tcn.em,
  A_cn = cnv_table$tcn.em - cnv_table$lcn.em,
  B_cn = cnv_table$lcn.em,
  ploidy = rep(ploidy_table$Ploidy, nrow(cnv_table))
  )
# input table in & out as intermediate file
write.table(scarHRD_input_table, 'scarHRD_input.tsv', sep = "\t", col.names = TRUE, row.names = FALSE, quote = FALSE)  

# get SCAR data & outputs
scar_data <- scar_score('scarHRD_input.tsv', reference = "grch38", seqz=FALSE)
write.table(scar_data, 'scarHRD_results.tsv', sep = "\t", col.names = TRUE, row.names = FALSE, quote = FALSE)