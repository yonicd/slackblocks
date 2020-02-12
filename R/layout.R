#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @param id PARAM_DESCRIPTION, Default: NULL
#' @param fields PARAM_DESCRIPTION, Default: NULL
#' @param accessory PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname block_section
#' @export 
block_section <- function(text, id = NULL, fields = NULL, accessory = NULL){
  
  payload <- list(
    type = 'section',
    text = text,
    block_id = id, 
    fields = fields,
    accessory = accessory
  )
  
  structure(compact(payload),class = c('block','block_section','list')) 
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param id PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname block_divider
#' @export 

block_divider <- function(id = NULL){
  
  payload <- list(
    type = 'divider',
    block_id = id
  )
  
  structure(compact(payload),class = c('block','block_divider','list')) 
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname wrap_blocks
#' @export 

wrap_blocks <- function(...){
  structure(list(...),class = c('blocks','list'))
}

#' @export 
as.blocks.list <- function(x){
  structure(x,class = c('blocks','list'))
}

#' @export 
as.blocks <- function(x){
  UseMethod('as.blocks')
}
