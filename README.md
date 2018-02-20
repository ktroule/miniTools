# miniTools

### translatorGMT.R

Script to translate mouse or human gene id gmt files to the opposite organism. 

The first time you run the script, it will automatically install the required packages.

**To run the script:** ./translatorGMT.R **-i** input.gmt **-d** mouse2hum_biomart_ens87.txt **-t** HS/MS **-o** output.gmt **-c** 0/1

Option **-t**: HS to translate gmt to from mouse to human. MS to translate gmt from human to mouse

Option **-c**: when translating to mouse, 0 keeps genes as normal, 1 capitalizes the gene name (i.e. 0:Kras, 1:KRAS)

The mouse2hum_biomart_ens87.tx file was obtained from: http://genomespot.blogspot.com.es/2016/12/msigdb-gene-sets-for-mouse.html
