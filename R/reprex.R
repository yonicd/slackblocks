#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @param channel PARAM_DESCRIPTION
#' @param token PARAM_DESCRIPTION, Default: Sys.getenv("SLACK_API_TOKEN")
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[reprex]{reprex}}
#' @rdname slack_reprex
#' @export 
#' @importFrom reprex reprex
slack_reprex <- function(..., text, channel, token = Sys.getenv('SLACK_API_TOKEN')){
  
  rx <- reprex::reprex(...,venue = 'gh',
                       advertise = FALSE,show = FALSE)
  
  img_idx <- grep('^!\\[\\]',rx)
  
  if(length(img_idx)>0){
    rx_txt <- rx[-img_idx]
    rx_txt <- paste0(rx_txt,collapse = '\n')
    rx_img <- gsub('^!\\[\\]\\(|\\)','',rx[img_idx])  
  }else{
    rx_txt <- paste0(rx,collapse = '\n')
  }
  
  rx_txt <- gsub('^``` r','```',rx_txt)
  
  if(length(img_idx)>0){
    ret <- wrap_blocks(
      block_section(block_text(text),id = 'section_q'),
      block_section(block_text(rx_txt),id = 'section_md'),
      block_image(rx_img)
    )
  }else{
    ret <- wrap_blocks(
      block_section(block_text(text),id = 'section_q'),
      block_section(block_text(rx_txt),id = 'section_md')
    )
  }
  
  post_block(block = ret,
             channel = channel, 
             token = token)
  
}
