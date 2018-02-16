#!/usr/bin/env Rscript

# -- Kevin Troule Feb 2018
# -- M. Rajoy

# -- Install and/or load needed packages
if (!require('qusage')) {
  source("https://bioconductor.org/biocLite.R")
  biocLite("qusage")
  }
if (!require('optparse')) {
  source("https://bioconductor.org/biocLite.R")
  biocLite("optparse")
  }
if (!require('cogena')) {
  source("https://bioconductor.org/biocLite.R")
  biocLite("cogena")
}

# -- Menu options list
option_list = list(make_option(c("-i","--input", type="character", default=NULL, help="Input gmt file", metavar="character")), 
                   make_option(c("-d","--database", type="character", default=NULL, help="mouse2hum_biomart_ens87 file", metavar="character")), 
                   make_option(c("-o","--output", type="character", default=NULL, help="Output file path", metavar="character")), 
                   make_option(c("-t","--translation", type="character", default=NULL, help="Translation output; MM (gmt to Mouse), HS (gmt to Human)", metavar="character")))

opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

# -- Checking the presence of all four inputs
if (is.null(opt$input) | is.null(opt$database) | is.null(opt$output) | is.null(opt$translation)){
  print_help(opt_parser)
  stop("There is an error in at least one iput argument.\n", call.=FALSE)
}

# -- Load input gmt file
gmt.file <- read.gmt(opt$input)

# -- Load biomart db
ensembl.db <- read.table(opt$database, sep='\t', header = T)

# -- Initialization output list
gmt.out <- list()

# -- Progress
print("This process may take a few minutes ")
pb <- txtProgressBar(min = 0, max = length(gmt.file), style = 3)

# -- To translate from Mus musculus to Homo sapiens
if(opt$translation == 'HS'){
  for(i in 1:length(gmt.file)){
    gmt.out[[i]] <- as.vector(unlist(lapply(gmt.file[[i]], function(x) (ensembl.db$Associated.Gene.Name[(match(x , ensembl.db$Human.associated.gene.name))]))))
    setTxtProgressBar(pb, i)
  }    
  names(gmt.out) <- names(gmt.file)
}

# -- To translate from Homo sapiens to Mus musculus  
if(opt$translation == 'MM'){
  for(i in 1:length(gmt.file)){
    gmt.out[[i]] <- as.vector(unlist(lapply(gmt.file[[i]], function(x) (ensembl.db$Human.associated.gene.name[(match(x , ensembl.db$Associated.Gene.Name))]))))
    setTxtProgressBar(pb, i)
  }    
  names(gmt.out) <- names(gmt.file)
}

# -- Output gmt file
gmtlist2file(gmt.out,opt$output)
