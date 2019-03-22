source("./src/move_raw_data.R")

number_re = "[0-9]+"
patterns = c(paste("ratio=", number_re, sep = ""), 
             paste("diameter=", number_re, "mm", sep = ""), 
             paste("mu=", number_re, "cSt", sep = ""),
             paste("degree=", number_re, sep = ""))
list_files("/home/ilberto/Desktop/fluidos/datos", ".csv", patterns)