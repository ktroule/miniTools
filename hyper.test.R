library("GeneOverlap")

# -- Function to perform hypergeometric test
# -- Input 2 list + universe length 
hyper.test <- function(genes.list, geneSet.list, universe.length){
  
  over.pval <- c() # -- ovelap pval
  geneSet.list.name <- c() # --  store geneSet/drugSet names
  genes.list.name <- c() #  -- store gene/drugs names
  # -- Loop over gene names, then over geneSets
  for (i in 1:length(genes.list)){
    for (j in 1:length(geneSet.list)){
      # -- Hyper function
      over <- newGeneOverlap(genes.list[[i]], geneSet.list[[j]], genome.size = universe.length)
      # -- Store data
      over.pval <- c(over.pval, testGeneOverlap(over)@pval)
      geneSet.list.name <- c(geneSet.list.name, names(geneSet.list)[j])
      genes.list.name <- c(genes.list.name, names(genes.list)[i])
    }
  }
  # -- FDR calculation + table sorting
  over.pval <- p.adjust(over.pval, method = 'fdr')
  over.results <- cbind(geneSet.list.name, genes.list.name, over.pval)
  over.results.ordered <- over.results[order(over.pval),]
  return(over.results.ordered)
}
# -- Use of jyper.test
# -- univ <- c(1:20000)
# -- gs <- list(a = sample(1:100, 40), b = sample(univ, 40))
# -- genes <- list(genes.A = c(1:20), genes.B = c(90:120))
# -- hyper.test(genes,gs,length(univ))
