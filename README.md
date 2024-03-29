# Function_KEGG


## 画通路标记图
library(pathview)  
k="05010"  
gens=c("GAPDH","gapA","SDHA","SDH1","SDHB","SDH2","SDHC","SDH3","SDHD","SDH4","UQCRFS1","RIP1","petA","CYTB","petB","CYC1","CYT1","petC","QCR1","UQCRC1","QCR2","UQCRC2","QCR6","UQCRH","QCR7","UQCRB","QCR8","UQCRQ","QCR9","UCRC","QCR10","UQCR","PIK3C3","VPS34","IDE","ide","CTNNB1","ATPeF08","MTATP8","ATP8","ATPeF0A","MTATP6","ATP6","ATPeF0B","ATP5F1","ATP4","ATPeF0C","ATP5G","ATP9","ATPeF0F6","ATP5J","ATPeF1A","ATP5A1","ATP1","ATPeF1B","ATP5B","ATP2","ATPeF1D","ATP5D","ATP16","ATPeF1E","ATP5E","ATP15","ATPeF1G","ATP5C1","ATP3","ATPeF0O","ATP5O","ATP5","ATPeF0D","ATP5H","ATP7","CALM","COX1","COX2","COX3","COX4","COX5A","COX5B","COX6A","COX6B","COX6C","COX7A","COX7B","COX7C","COX8","FZD6","PIK3R1_2_3","PSMA1","PSMA2","PSMA3","PSMA4","PSMA5","PSMA6","PSMA7","PSMB1","PSMB2","PSMB3","PSMB4","PSMB5","PSMB6","PSMB7","HRAS","PSMD2","RPN1","PSMD4","RPN10","PSMD14","RPN11","POH1","PSMD8","RPN12","PSMD1","RPN2","PSMD3","RPN3","PSMD12","RPN5","PSMD11","RPN6","PSMD6","RPN7","PSMD7","RPN8","PSMD13","RPN9","PSMC2","RPT1","PSMC1","RPT2","PSMC4","RPT3","PSMC6","RPT4","PSMC3","RPT5","PSMC5","RPT6","GSK3B","FRAT2","CSNK2A","CSNK2B","TNF","TNFA","EIF2S1","ND1","ND2","ND3","ND4","ND4L","ND5","ND6","NDUFS2","NDUFS3","NDUFS4","NDUFS5","NDUFS6","NDUFS7","NDUFS8","NDUFV1","NDUFV2","NDUFV3","NDUFA1","NDUFA2","NDUFA3","NDUFA4","NDUFA5","NDUFA6","NDUFA7","NDUFA8","NDUFA9","NDUFA10","NDUFAB1","NDUFA11","NDUFB1","NDUFB2","NDUFB3","NDUFB4","NDUFB5","NDUFB6","NDUFB7","NDUFB8","NDUFB9","NDUFB10","NDUFC1","NDUFC2","PPP3C","CNA","MAP2K2","MEK2","ERK","MAPK1_3","ATF4","CREB2","IL1A","IL1B","APOE","NAE1","APPBP1","BID","IL6","ATP2A","PLCB","SLC25A4S","ANT","PPID","CYPD","PSENEN","PEN2","APH1","PPP3R","CNB","RPN13","PSMD9","RPN4","MTOR","FRAP","TOR","TUBA","TUBB","KRAS","KRAS2","NRAS","ATG13","BECN","VPS30","ATG6","HSD17B10","CYC","ERN1","CSNK1E","XBP1","PPIF","KIF5","SHFM1","DSS1","RPN15","NDUFB11","NDUFA12","NDUFA13","SLC39A1_2_3","ZIP1_2_3","SLC39A4","ZIP4","SLC39A7","KE4","ZIP7","SLC39A9")  
pathview(gene.data = gens, pathway.id = k, species = "hsa", gene.idtype="symbol",kegg.native = TRUE)  


## gprofiler2
https://biit.cs.ut.ee/gprofiler/gost
### KO enrichment
library(gprofiler2)  
gostres <- gost(query = c("GO:0003700", "GO:0005524", "GO:0005886", "GO:0009401", "GO:0016021"), 
                organism = "hsapiens", ordered_query = FALSE, 
                multi_query = FALSE, significant = TRUE, exclude_iea = FALSE, 
                measure_underrepresentation = FALSE, evcodes = FALSE, 
                user_threshold = 0.05, correction_method = "fdr", 
                domain_scope = "annotated", custom_bg = NULL, 
                numeric_ns = "", sources = NULL, as_short_link = FALSE, highlight = TRUE)  
gostplot(gostres, capped = TRUE, interactive = TRUE)  


### ID convert
gconvert_id=gconvert(query = c("GO:0005030", "rs17396340", "NLRP1"), organism = "hsapiens", 
         target="ENSG", mthreshold = Inf, filter_na = TRUE) #Uniprot, RefSeq, Entrez, HUGO, HGNC,ENSG  

gconvert_id_2=gorth(query = c("Klf4", "Sox2", "71950"), source_organism = "mmusculus", 
      target_organism = "hsapiens", mthreshold = Inf, filter_na = TRUE,
      numeric_ns = "ENTREZGENE_ACC")  
      
## Reduce redundancy of human GO terms
library(rutils)  
pathway_df=data.frame(
  go_type=rep("BP",5),
  go_id=c("GO:0003700","GO:0005524","GO:0005886","GO:0009401","GO:0016021")
)  

result=go_reduce(
  pathway_df = pathway_df,
  orgdb = "org.Hs.eg.db",threshold = 0.6,measure = "Wang")  

## mulea
https://github.com/ELTEbioinformatics/mulea  
https://github.com/SysMednet/Gscore  
