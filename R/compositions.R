#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @param type PARAM_DESCRIPTION, Default: c("mrkdwn", "plain-text")
#' @param emoji PARAM_DESCRIPTION, Default: NULL
#' @param verbatim PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname block_text
#' @export 

block_text <- function(text, type = c('mrkdwn', 'plain-text'), emoji = NULL, verbatim = NULL){

  payload <- list(
    type = match.arg(type,c('mrkdwn', 'plain-text')),
    text = text,
    emoji = yesno(emoji),
    verbatim = yesno(verbatim)
  )
  
  structure(compact(payload),class = c('block','block_text','list'))

}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @param value PARAM_DESCRIPTION
#' @param description PARAM_DESCRIPTION, Default: NULL
#' @param url PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname block_option
#' @export 

block_option <- function(text, value, description = NULL, url = NULL){
  
  payload <- list(
    text = as.block_text(text),
    value = value,
    description = as.block_text(description),
    url = url
  )
  
  structure(compact(payload),class = c('block','block_option','list'))
  
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param opts PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname block_option_groups
#' @export 

block_option_groups <- function(opts){
  
  if(is.null(names(opts)))
    names(opts) <- sprintf('group_%02d',seq_along(opts))
  
  og <- mapply(function(l,o){
    list(label = as.block_text(l, emoji = NULL,verbatim = NULL), 
         options = compact(o)) 
  }, l = names(opts), o = opts,SIMPLIFY = FALSE,USE.NAMES = FALSE)
  
  payload <- list(option_groups = og)
  
  structure(payload,class = c('block','block_option_groups','list'))
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param title PARAM_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @param confirm PARAM_DESCRIPTION
#' @param deny PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname block_confirm
#' @export 

block_confirm <- function(title, text, confirm, deny){
 
  payload <- list(
    title = as.block_text(title),
    text = as.block_text(text),
    confirm = as.block_text(confirm),
    deny = as.block_text(deny)
  )
  
  structure(compact(payload),class = c('block','block_confirm','list'))
   
}