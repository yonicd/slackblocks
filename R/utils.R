#' Pipe operator
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

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

#' @title Array of blocks
#' @description wrap block class objects in a list
#' @param ... block elements
#' @return list of blocks elements
#' @examples 
#' wrap_blocks(
#'     image_element(
#'       url = 'https://image.freepik.com/free-photo/red-drawing-pin_1156-445.jpg',
#'       alt_text = 'images'
#'     ),
#'     block_text(
#'       text = 'Location: **Dogpatch**'
#'     )
#'   )
#' @rdname wrap_blocks
#' @family layout
#' @export 

wrap_blocks <- function(...){
  structure(list(...),class = c('blocks','list'))
}

#' @title Coerce into Blocks
#' @description Turns existing object into block elements
#' @param x object
#' @return block object
#' @rdname as.blocks
#' @family layout
#' @export 
as.blocks <- function(x){
  UseMethod('as.blocks')
}

#' @export 
as.blocks.list <- function(x){
  structure(x,class = c('blocks','list'))
}


force_integer <- function(obj){
  
  if(!is.null(obj)){
    if(is.numeric(obj))
      obj <- as.integer(obj)
    
    checkmate::check_class(obj,'integer')
  }
  
  obj
}
