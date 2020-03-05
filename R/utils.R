compact <- function(obj){
  
  obj[lengths(obj)>0]
  
} 

#' @importFrom jsonlite toJSON
#' @export
print.block <- function(x,...){
  print(jsonlite::toJSON(x,auto_unbox = TRUE,pretty = TRUE,...))
} 

#' @importFrom jsonlite toJSON
#' @export
print.blocks <- function(x,...){
  print(jsonlite::toJSON(x,auto_unbox = TRUE,pretty = TRUE,...))
}
