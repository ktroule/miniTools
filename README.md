# miniTools

### translatorGMT.R


Script to translate mouse or human gene id gmt files to the opposite organism. 

The first time you run the script, it will try to automatically check and/or install the required packages.

**To run the script:** ./translatorGMT.R **-i** input.gmt **-d** mouse2hum_biomart_ens87.txt **-t** HS/MS **-o** output.gmt **-c** TRUE/FALSE

Option **-t**: HS to translate gmt to from mouse to human. MS to translate gmt from human to mouse  
Option **-c**: when translating to mouse, 0 keeps genes as normal, 1 capitalizes the gene name (i.e. FALSE:Kras, TRUE:KRAS)

Whenever one gene from one organism matches multiple genes id from the other, all genes from the last will be added to the new gmt file.  
E.g. input Mouse gmt contains (Dcaf4), the output Human gmt will contain (DCAF4, DCAF4L2, DCAF4L1)

The **mouse2hum_biomart_ens87.txt** file was obtained from: http://genomespot.blogspot.com.es/2016/12/msigdb-gene-sets-for-mouse.html The file **mouse2hum_biomart_ens87_reduced.txt** contains the same information (gene ids) without taking into account the name of transcripts (as this is a shorter table it will let the script to perform faster).

-------------------------------------------------------------------------------------------------------------------------------
