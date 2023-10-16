library(readr)
library(clusterProfiler)
library(org.Sc.sgd.db)

BiocManager::install("org.Sc.sgd.db")

data <- read.csv(file = "IP9_Enr.csv", header = T, sep = '\t', dec ='.')
gene = data$Loss

columns(org.Sc.sgd.db)


eco_kegg <- enrichGO(
  gene,
  org.Sc.sgd.db,
  keyType = "GENENAME",
  ont = "CC",
  pvalueCutoff = 0.1,
  qvalueCutoff = 0.2
)

results_DF = data.frame(eco_kegg)
ID_DF = data.frame(results_DF$ID,results_DF$Description,results_DF$p.adjust,results_DF$Count)

dotplot(eco_kegg, showCategory = 10, title = "CC", orderBy = "Count")



