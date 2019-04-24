# Libraries needed
library(limma)

# Import Acetylpeptides
p1_log2 <- read.csv("p1_limma_export_RO_kac.csv", row.names=1)
p2_log2 <- read.csv("p2_limma_export_RO_kac.csv", row.names=1)

# Don't convert to log2 - it is already!


# Design linear model with no intercept and no interaction
# Group is the Genotype
p1_group <- factor(c("CrATFL", "CrATFL", "CrATFL", 
                     "CrATKO", "CrATKO", "CrATKO", 
                     "DFC", "DFC", "DKO", "DKO"))

p2_group <- factor(c("DFC", "DFC", 
                     "DKO", "DKO", "DKO", 
                     "S3FL", "S3FL", 
                     "S3KO", "S3KO", "S3KO"))

p1_design <- model.matrix(~0+p1_group)
p2_design <- model.matrix(~0+p2_group)

# Rename column names in the design
colnames(p1_design) <- c('CrATFL','CrATKO', 'DFC','DKO')
colnames(p2_design) <- c('DFC','DKO', 'S3FL', 'S3KO')

# Limma Step 1: Least Squares Estimates 
p1_fit <- lmFit(p1_log2, p1_design)
p2_fit <- lmFit(p2_log2, p2_design)

# Generate the contrast maps
p1_contMat <- makeContrasts(DKOvsDFC = DKO - DFC, 
                            CrATKOvsCrATFL = CrATKO - CrATFL,
                            DKOvsCrATKO = DKO - CrATKO, 
                            DFCvsCrATFL = DFC - CrATFL,
                            levels=p1_design)

p2_contMat <- makeContrasts(DKOvsDFC = DKO - DFC, 
                            S3KOvsS3FL = S3KO - S3FL,
                            DKOvsS3KO = DKO - S3KO, 
                            DFCvsS3FL = DFC - S3FL,
                            levels=p2_design)

# Fit the Contrasts to the product of lmFit
p1_fit_cont <- contrasts.fit(p1_fit, p1_contMat)
p2_fit_cont <- contrasts.fit(p2_fit, p2_contMat)

# Now perform the eBayes on this new fit
p1_fit_cont_eb <- eBayes(p1_fit_cont)
p2_fit_cont_eb <- eBayes(p2_fit_cont)


# Perform the comparisons, with each contrast individually
# Use Benj. Hoch. for With FDR = 0.05
p1_fit_cont_eb_decide <- decideTests(p1_fit_cont_eb, 
                                     method="separate", 
                                     adjust.method = "BH", 
                                     p.value = 0.05)

p2_fit_cont_eb_decide <- decideTests(p2_fit_cont_eb, 
                                     method="separate", 
                                     adjust.method = "BH", 
                                     p.value = 0.05)

# Export the data
write.fit(p1_fit_cont_eb, p1_fit_cont_eb_decide, "p1_eb_fit_RO_kac.tsv")
write.fit(p2_fit_cont_eb, p2_fit_cont_eb_decide, "p2_eb_fit_RO_kac.tsv")