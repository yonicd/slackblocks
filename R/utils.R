yesno <- function(x){
  
  if(is.null(x))
    return(x)
  
  if(x){
    'true'
  }else{
    'false'
  }
}


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

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname is.block_option
#' @export 

is.block_option <- function(x,...){
  inherits(x,'block_option')
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname as.block_text
#' @export 

as.block_text <- function(x,...){
  UseMethod('as.block_text')
}



#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname is.block_text
#' @export 

is.block_text <- function(x,...){
  inherits(x,'block_text')
}

#' @export
#' @rdname is.block_text
as.block_text.block_text <- function(x,...){
  x
}

#' @export
#' @rdname is.block_text
as.block_text.NULL <- function(x,...){
  NULL
}

#' @export
#' @rdname is.block_text
as.block_text.character <- function(x,...){
  if(!is.block_text(x))
    x <- block_text(x,...)
  
  x
}
