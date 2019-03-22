check_dependencies = function(){
  project_dependencies = c("ggplot2", "dplyr", "tidyr", "stringr", "lubridate",
                           "xts")
  for (dependency in project_dependencies){
    check_install_dependency(dependency)
  }
}

check_install_dependency = function(dependency){
  if (!require(dependency, character.only = TRUE, quietly = TRUE)){
    install.packages(x, dependencies = TRUE)
    if (!require(dependency, character.only = TRUE, quietly = TRUE)){
      stop("Package not found")
    } 
  }
}