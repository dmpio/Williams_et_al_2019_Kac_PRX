# Williams_et_al_2019_Kac_PRX

Proteomic Data Analysis for the following publication:

> Williams, A.S., Koves, T.R., Davidson, M.T., Crown, S.B., Fisher-Wellman, K.H., Torres, M.J., Draper, J.A., Narowski, T.M., Slentz, D.H., Lantier, L., Wasserman, D.H., Grimsrud, P.A., Muoio, D.M. (2020). Disruption of Acetyl-Lysine Turnover in Muscle Mitochondria Promotes Insulin Resistance and Redox Stress without Overt Respiratory Dysfunction. Cell Metabolism 31, 131-147.e11. [DOI: 10.1016/j.cmet.2019.11.003](https://doi.org/10.1016/j.cmet.2019.11.003). [PMID: 31813822](https://pubmed.ncbi.nlm.nih.gov/31813822/)

## Raw Data
The raw data for the proteomics experiments was submitted to the Proteome Xchange Consortium via PRIDE and can be accessed with the following identifier:  [PXD014586](http://proteomecentral.proteomexchange.org/cgi/GetDataset?ID=PXD014586)

## Directory Structure

### `Data_Analysis.ipynb`
A jupyter notebook containing the python code used to analyze the data produced from Proteome Discoverer 2.2.

### `pd22_exports`
Contains the proteomic data produced from Proteome Discoverer 2.2 and exported in a tab delimited format. One file contains the peptide information, the other contains protein information.

### `limma`
Contains the R code used to analyze the data with the *limma* library, along with the input for and the output from this analysis. The *limma* analysis is an intermediate step in processes detailed/performed in the `Data_Analysis.ipynb` file.

### `processed_files`
Contains the analysis results from `Data_Analysis.ipynb` in both Excel files and Comma Separated Value format. See below for more information

## Information about files within `processed_files` 

There are 3 Excel files within the directory:
    
1. The File ending with "plex" contains the processed data for the acetylpeptides corrected for the "relative occupancy" (abb. "RO"), acetylpeptides only corrected for loading content, and the proteins

2. The file ending with "Top25" contains processed data derived from the data in file #1 that shows the top 25 most differentially abundant acetylpeptides (corrected for the relative occupancy) along with basic information about the acetylated residues involved and the protein information
    
All of the sheets within the these Excel files are also stored in ".csv" formatted files.

1. The file starting with "SKM" containes the processed data for th acetylpeptides corrected for the "relative occupancy" (abb. "RO"), acetylpeptides only corrected for loading content, and the proteins. This file was bundled with the paper (after minor formatting modifications) in the supplemental materials. 
___

Within the first Excel file (and corresponding .csv files), a basic nomenclature is utilized. 
In the Acetylpeptide sheets: 

   There are 2 sheets for the acetylpeptide data. One contains the "relative occupancy" data which is subsequently analyzed within the *limma* software. The other doesn't contain the "relative occupancy data" and only analyzes the load-normalized data. In the paper, for consistency all numbers and graphs utilize the "relative occupancy" data. 
    
- columns that end in `_Acetyl` are the "raw" quantification values exported from Proteome Discoverer 2.2
- columns that end in `_norm` are the quantification values corrected for differences in loading between the individual channels
- columns that end in `_norm_log2` are simply the log2 transformation of the load-normalized columns
- columns that end in `_norm_log2_ro` have used the log2 transformation data of the **protein** (not peptide) to correct for any protein expression changes that may account for differences in the acetyl-peptide abundance. The `ro` stands for "relative occupancy". The relative occupancy of the post-translational modification is calculated by subtracting changes in the protein abundance from the acetyl-peptide abundance. For example, if a PTM site is found to be increasing by 2 fold, but the protein abundance is also increasing by 2 fold, then the relative occupancy would be 0.
- The results from the *limma* analysis start after the last `_ro` column until the end of each table
    

The Proteins Sheet follows a similar nomenclature. The difference is that the columns ending in `_Protein` are the "raw" quantification values exported from Proteome Discoverer 2.2


In the *limma* analysis, columns ending in `_significant` indicate the statistical significance of the specified comparison after multiple hypothesis correction with the Benjamini-Hochberg method and an FDR of <0.05.
    
- 0 indicates not significantly different
- 1 indicates significantly different, increased in the listed comparison
- -1 (negative one) indicates significantly different, decreased in the listed comparison
    
    
## Abbreviations:

- `DKO` Dual Knock-out. (Crat and Sirt3 ablation via cre-recombinase induced under the muscle creatine kinase promoter)
- `DFC`  Dual Flox control. (Floxed controls for the DKO animals)
- `S3KO`  Sirt3 Knock-out. (Sirt3 ablation via cre-recombinase induced under the muscle creatine kinase promoter)
- `S3FL` Sirt3 Flox control. (Floxed controls for the S3KO animals)
- `CrATKO` CrAT Knock-out. (CrAT ablation via cre-recombinase induced under the muscle creatine kinase promoter)
- `CrATFL` CrAT Flox control. (Floxed controls for the CrATKO animals)
- `FC` Fold Change
- `Log2FC` Fold Change in the Log2 space
- `Kac` Peptide containing an acetylated lysine residue (K=abbreviation for lysine)
- `RO` relative occupancy
