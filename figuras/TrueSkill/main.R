if(!require(fields)) install.packages("fields")
if(!require(stringi)) install.packages("fields")

args <- commandArgs(trailingOnly = TRUE)

if (length(args)>0){
  files <- args
}else{
  files <- list.files(pattern = "\\.R")
  files <- files[files != "main.R"]
}

for (f in files){
  print(paste("Abre Archivo", f))
  source(f)
} 

