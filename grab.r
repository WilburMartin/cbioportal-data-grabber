// Used for importing Data:
// samples_studies <- read.table(pipe("pbpaste"), sep="\t", header = TRUE)

## Use this to build survival table

survival <- vector(mode="character", length=length(samples_studies$sample));
patient <- character();
patIds <-  vector(mode="character", length=length(samples_studies$sample));
sampleIds <- vector(mode="character", length=length(samples_studies$sample));

x <- 1;
y <- 1;

while(x < length(samples_studies$sample)){
	sample <- httr::content(cbio$getAllClinicalDataOfSampleInStudyUsingGET(sampleId = samples_studies$sample[x], studyId = samples_studies$study[x], attributeId = "MUTATION_COUNT"));
if(length(sample) != 0 && !is.null(sample[[1]]$patientId)){
		print(x);
		patId <- sample[[1]]$patientId;
		
		patient <- httr::content(cbio$getAllClinicalDataOfPatientInStudyUsingGET(patientId =patId, studyId = samples_studies$study[x], attributeId = "OS_STATUS"));
		
		if(length(patient) != 0 && is.null(patient$message) && !is.null(patient[[1]])){
		patIds[y] <- patId
		sampleIds[y] <- samples_studies$sample[x];
		survival[y] <- patient[[1]]$value;
			y <- y+1;		}
	}
	x <- x+1;
}


//Alternatives to using y var:
//patIds <- c(patIds, patId);
//survival <- c(survival, patient[[1]]$value);

// Used for importing Data:
// expanded_mut_data <- read.table(pipe("pbpaste"), sep="\t", header = TRUE)


survival_mut <- vector(mode="character", length=length(samples_mut$Sample.ID));
patient_mut <- vector(mode="character", length=length(samples_mut$Sample.ID));
sample_mut <- vector(mode="character", length=length(samples_mut$Sample.ID));
protein_mut <- vector(mode="character", length=length(samples_mut$Sample.ID));
type_mut <- vector(mode="character", length=length(samples_mut$Sample.ID));

x <- 1;
y <- 1;
index <-1; 

while(x < length(samples_mut$Sample.ID)){
	print(x);
	while(y < length(sampleIds)){	
		if(samples_mut$Sample.ID[x] == sampleIds[y]){
			protein_mut[index] <- samples_mut$Protein.Change[x];
			sample_mut[index] <- samples_mut$Sample.ID[x];
			type_mut[index] <- samples_mut$Mutation.Type[x]
			patient_mut[index] <- patIds[y];
			survival_mut[index] <- survival[y];
			index <- index + 1
		}
	y <- y+1;
	}
y <- 1;
x <- x + 1;
}

barplot(table(survival_mut));

barplot(table(survival_mut, type_mut, exclude = ""), las=3);



//For Bar plot stuff



par(mai = c(2.5,1,1,1))


barplot(table(samples_mut$Protein.Change, samples_mut$Cancer.Type), col = brewer.pal(5, name = "Set2"), legend = TRUE, args.legend=list(x="top",ncol = 10, cex = 0.4, inset=c(0,-0.23)), cex.names = 0.45, las=3)

/*barplot(table(expanded_mut_data$Protein.Change, expanded_mut_data$Cancer.Type), col = brewer.pal(5, name = "Set2"), legend = TRUE, args.legend=list(x="top",ncol = 10, cex = 0.4, inset=c(0,-0.23)), cex.names = 0.45, las=3)*/

//With more distinct colors
par(mai = c(2.5,1,1,1))

library(RColorBrewer)
n <- 60
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
pie(rep(1,n), col=sample(col_vector, n))


barplot(table(expanded_mut_data$Protein.Change, expanded_mut_data$Cancer.Type), col = col_vector, legend = TRUE, args.legend=list(x="top",ncol = 10, cex = 0.4, inset=c(0,-0.23)), cex.names = 0.45, las=3)


par(mai = c(2.5,1,1,1))



barplot(table(samples_mut$Protein.Change, samples_mut$Cancer.Type, exclude = c("X62_splice","X287_splice","X26_splice","X220_splice","X219_splice","X186_splice","X164_splice","T203Nfs*4","T203Lfs*7","NUPL2-EPCAM","NRXN1-EPCAM fusion", "MSH2-EPCAM", "L148_K151del","G79Dfs*6","EPCAM-ABCG8","D128Lfs*3","Ampullary Carcinoma???, ???Cervical Squamous Cell Carcinoma", "Esophageal Squamous Cell Carcinoma", "Ewing Sarcoma", "Gastric Type Mucinous Carcinoma", "Mucosal Melanoma of the Vulva/Vagina", "Serous Ovarian Cancer", "Undifferentiated Malignant Neoplasm"), useNA = "no???), col = brewer.pal(5, name = "Set2"), legend = TRUE, args.legend=list(x="top",ncol = 10, cex = 0.4, inset=c(0,-0.23)), cex.names = 0.45, las=3)


barplot(table(samples_mut$Protein.Change, samples_mut$Cancer.Type, exclude = c("X62_splice","X287_splice","X26_splice","X220_splice","X219_splice","X186_splice","X164_splice","T203Nfs*4","T203Lfs*7","NUPL2-EPCAM","NRXN1-EPCAM fusion", "MSH2-EPCAM", "L148_K151del","G79Dfs*6","EPCAM-ABCG8","D128Lfs*3")), col = brewer.pal(5, name = "Set2"), legend = TRUE, args.legend=list(x="top",ncol = 10, cex = 0.4, inset=c(0,-0.23)), cex.names = 0.45, las=3)

par(mai = c(2.5,1,1,1)

barplot(table(samples_mut$Protein.Change, samples_mut$Cancer.Type, exclude = c("X62_splice","X287_splice","X26_splice","X220_splice","X219_splice","X186_splice","X164_splice","T203Nfs*4","T203Lfs*7","NUPL2-EPCAM","NRXN1-EPCAM fusion", "MSH2-EPCAM", "L148_K151del","G79Dfs*6","EPCAM-ABCG8","D128Lfs*3","Ampullary Carcinoma???, ???Cervical Squamous Cell Carcinoma", "Esophageal Squamous Cell Carcinoma", "Ewing Sarcoma", "Gastric Type Mucinous Carcinoma", "Mucosal Melanoma of the Vulva/Vagina", "Serous Ovarian Cancer", "Undifferentiated Malignant Neoplasm"), useNA = "no"), col = brewer.pal(5, name = "Set2"), legend = TRUE, args.legend=list(x="top",ncol = 10, cex = 0.4, inset=c(0,-0.23)), cex.names = 0.45, las=3) 

barplot(table(expanded_mut_data$Mutation.Type, expanded_mut_data$Cancer.Type), col = col_vector, las=2, legend=TRUE)

barplot(table(expanded_mut_data$Mutation.Type, samples_mut$Cancer.Type, useNA = "no"), col = brewer.pal(5, name = "Set2"), legend = TRUE, args.legend=list(x="top",ncol = 2, cex = 0.4, inset=c(0,-0.23)), cex.names = 0.45, las=3)

par(mai = c(2.5,1,1,1)
barplot(table(expanded_mut_data$Protein.Change, exclude = c(""), useNA = "no"), col = "Light Green", cex.names = 0.45, las=2, main = "Protein Mutation Frequency")  


barplot(table(samples_mut$Protein.Change, samples_mut$Cancer.Type, exclude = c("X62_splice","X287_splice","X26_splice","X220_splice","X219_splice","X186_splice","X164_splice","T203Nfs*4","T203Lfs*7","NUPL2-EPCAM","NRXN1-EPCAM fusion", "MSH2-EPCAM", "L148_K151del","G79Dfs*6","EPCAM-ABCG8","D128Lfs*3","Ampullary Carcinoma", "Acute Myeloid Leukemia","Cervical Squamous Cell Carcinoma", "Esophageal Squamous Cell Carcinoma", "Ewing Sarcoma", "Gastric Type Mucinous Carcinoma", "Mucosal Melanoma of the Vulva/Vagina", "Serous Ovarian Cancer", "Undifferentiated Malignant Neoplasm"), useNA = "no"), col = brewer.pal(5, name = "Set2"), legend = TRUE, args.legend=list(x="top",ncol = 10, cex = 0.4, inset=c(0,-0.23)), cex.names = 0.45, las=3) 

