get_os = function(){
  sysinf = Sys.info()
  if (!is.null(sysinf)){
    os = sysinf['sysname']
    if (os == 'Darwin')
      os = "osx"
  } else { ## mystery machine
    os = .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      os = "osx"
    if (grepl("linux-gnu", R.version$os))
      os = "linux"
  }
  tolower(os)[[1]]
}


sys_bar = function(system = get_os()){
  if (grepl("windows", system)){
    bar = "\\"
  }
  else{
    bar = "/"
  }
  return(bar)
}


browser_folders = function(folder, file_format, patterns, files_list){
  bar = sys_bar()
  for (i in seq_along(patterns)){
    folders = list.dirs(folder, recursive = FALSE)
    files = list.files(folder, recursive = FALSE)
    if (length(folders) == 0 & length(files) > 0){
      for (file in files){
        if (grepl(file_format, file)){
          files_list
        }
      }
    }
    else if (length(folders) == 1){
      my_match = unlist(regmatches(folder, gregexpr(pattern, folders[[1]])))
      if (grepl(my_match, folder)){
        files_list = c(files_list, my_match = list())
        folder_ref = paste(folder_ref, my_match, sep=bar)
      }
    }
    else if (length(folders) > 1){
      for (folder in folders){
        my_match = unlist(regmatches(folder, gregexpr(patterns[[i]], folder)))
        if (grepl(my_match, folder)){
          next_folder = paste(folder_ref, my_match, sep=bar)
          files_list = c(files_list, my_match = list())
          files_list = browser_folders(next_folder, file_format, 
                            patterns[i:length(patterns)], files_list)
        }
      }
      break
    }
  }
}


list_files = function(folder_in, file_format, patterns){
  files_list = list()
  return(browser_folders(folder_in, file_format, patterns, files_list))
}  

number_re = "[0-9]+"
patterns = c(paste("ratio=", number_re, sep = ""), 
             paste("diameter=", number_re, "mm", sep = ""), 
             paste("mu=", number_re, "cSt", sep = ""),
             paste("degree=", number_re, sep = ""))
list_files("/home/ilberto/Desktop/fluidos/datos", ".csv", patterns)
