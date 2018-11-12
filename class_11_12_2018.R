# If gene ids are in form of Ensembl ids, then one can use "BiomaRt" library.
# Gene set enrichment

library("biomaRt") # load library biomaRt

# using homo sapiens annotation file by function useMart
ensembl <- useMart("ensembl", dataset="hsapiens_gene_ensembl")# loading your species file

my_chr <- c(1:22, 'M','X','Y') # Making an object with chromosome names
my_chr

#Function (getBM) to get features form biomaRt library
my_ensembl_gene <- getBM(attributes='ensembl_gene_id',
				filters='chromosome_name',
				values=my_chr, mart=ensembl)

my_ensembl_gene # get your genes

#ensembl gene id: have some number and gene ID, eg 58639 ENSG00000251970
entrez gene id: only numbers

# Selecting first 5 ensembl gene ids
five_ensembl <- my_ensembl_gene[1:5,]# show you first five row of genes

# function to convert ensembl gene ids to entrez gene ids

five_ensembl_to_entrez <- getBM(attributes=c('ensembl_gene_id', 'entrezgene'),
filters='ensembl_gene_id',values=five_ensembl, mart=ensembl)

# select last 50 genes from object 'my_ensembl_gene' and convert into entrez gene ids,
export two columns into csv file named 'ensembl_to_entrez' and upload on github

last_five_ensembl <- my_ensembl_gene[58590:58639,] or tail(my_ensembl_gene, 50)
or my-ensembl_gene[58639-49:-1,]
last_five_ensembl_to_entrez <- getBM(attributes=c('ensembl_gene_id', 'entrezgene'),
filters='ensembl_gene_id',values=last_five_ensembl, mart=ensembl)

write.csv(last_five_ensembl_to_entrez[,1:2], file = "ensembl_to_entrez",row.names=TRUE)

# select diferent attributes from biomaRt library
# Made an object to retrive the following info
my_attribute <- c('entrezgene',
			'hgnc_symbol',
			'chromosome_name',
			'start_position',
			'end_position', 'strand')

# my_entrez_gene object has entrez gene ids with chromosome names
my_entrez_gene <- getBM(attributes = 'entrezgene',
filters = 'chromosome_name', values = my_chr, mart=ensembl)


my_entrez_gene_info <- getBM(attributes=my_attribute,
					filters = c('entrezgene', 'chromosome_name'),
					values = list(entrezgene = my_entrez_gene$entrezgene, chromosome_name=my_chr),
					mart=ensembl)

head(my_entrez_gene_info)





# 11122018 class notes
Generating heatmaps in r

install library gplotz

if (!requireNamespace("BiocManager", quitely = TRUE)
	install.pacakages("BiocManager")
BiocManager::install("gplots", version = "3.8")

library(gplots)

# installing library RColorBrewer

if (!requireNamespace("BiocManager", quitely = TRUE)
	install.pacakages("BiocManager")
BiocManager::install("RColorBrewer", version = "3.8")

library(RColorBrewer)

# data <- read your csv file heatmaps_in_r.csv

data <- read.csv(file = "C:/Users/Ling/Desktop/heatmaps_in_r.csv")
data
rnames <- data[,1]                            # assign labels in column 1 to "rnames"
mat_data <- data.matrix(data[,2:ncol(data)])  # transform column 2-5 into a matrix
rownames(mat_data) <- rnames                  # assign row names

library(gplots)
library(RColorBrewer)

# Assign the row names to an object called 'rnames
rnames <- data[,1] 
# class(data) to show data.frame

# converting data frame into a matrix

mat_data <- data.matrix(data[,2:ncol(data)])  # transform column 2-last coloumn of your data into a matrix

# assign row names to matrix object with the function "rownames"
rownames(mat_data) <- rnames                  # assign row names

mat_data # you will see the rownames now

# create a color template/palette with function 'colorRampPalette'

my_palette <- colorRampPalette(c("red","green","yellow"))(n=299)

n = 299 is  different color shades

# create a 5*5 inch of image

png("C:/Users/Ling/Desktop/sample_picture_1.png",
	width=5*300,
	height=5*300,
	res=300,
	pointsize=8
) # res is resolution

# Make a heatmap on this picture

heatmap.2(mat_data, main="Example Plot", notecol="black", margins=c(12, 9),
	    col=my_palette, dendrogram="row")

dev.off()# completing the file writing


# refernce can use for exam
https://sebastianraschka.com/Articles/heatmaps_in_r.html











