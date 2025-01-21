#setwd("/home/landfried/gaming/presentaciones/2019_03_ICC_poster/imagenes")

args = commandArgs(trailingOnly=TRUE)
if(length(args)>0){
  R_files = args[grepl("*.R$", args)]
}else{
  R_files = list.files("./",pattern = "*.R$")
  R_files = R_files[R_files!="main.R" ]
}

for(f in R_files){#f="expF2.R"
  source(f)
  name = paste0(strsplit(f, ".", fixed = TRUE)[[1]][1],".pdf")
}

