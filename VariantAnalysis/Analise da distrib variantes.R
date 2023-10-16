##Variant stats

# load tidyverse package
library(tidyverse)

#Variant quality
var_qual <- read_delim("vcf_stats_JP14.lqual", delim = "\t",
                       col_names = c("chr", "pos", "qual"), skip = 1)

a <- ggplot(var_qual, aes(qual)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3) + xlim(0, 7500)
a + theme_light()

#mean depth
var_depth <- read_delim("vcf_stats_JP14.ldepth.mean", delim = "\t",
                        col_names = c("chr", "pos", "mean_depth", "var_depth"), skip = 1)

a <- ggplot(var_depth, aes(mean_depth)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3) + xlim(0, 500)
a + theme_light()+ xlim(0, 300)

summary(var_depth$mean_depth)

#Missingness

var_miss <- read_delim("vcf_stats_JP14.lmiss", delim = "\t",
                       col_names = c("chr", "pos", "nchr", "nfiltered", "nmiss", "fmiss"), skip = 1)

a <- ggplot(var_miss, aes(fmiss)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a + theme_light()

summary(var_miss$fmiss)

#minor allele frequency


var_freq <- read_delim("vcf_stats_JP14.frq", delim = "\t",
                       col_names = c("chr", "pos", "nalleles", "nchr", "a1", "a2"), skip = 1)
# find minor allele frequency
var_freq$maf <- var_freq %>% select(a1, a2) %>% apply(1, function(z) min(z))

a <- ggplot(var_freq, aes(maf)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a + theme_light()

summary(var_freq$maf)

#Mean_depth_per individual

ind_depth <- read_delim("vcf_stats_JP14.idepth", delim = "\t",
                        col_names = c("ind", "nsites", "depth"), skip = 1)


a <- ggplot(ind_depth, aes(depth)) + geom_histogram(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a + theme_light()


ind_miss  <- read_delim("vcf_stats_JP14.imiss", delim = "\t",
                        col_names = c("ind", "ndata", "nfiltered", "nmiss", "fmiss"), skip = 1)

a <- ggplot(ind_miss, aes(fmiss)) + geom_histogram(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a + theme_light()

ind_het <- read_delim("vcf_stats_JP14.het", delim = "\t",
                      col_names = c("ind","ho", "he", "nsites", "f"), skip = 1)

a <- ggplot(ind_het, aes(f)) + geom_histogram(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a + theme_light()








