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
slack_reprex <- function(..., text = NULL, channel, token = Sys.getenv('SLACK_API_TOKEN')){
  
  rx <- reprex::reprex(
    ...,
    venue = 'gh',
    advertise = FALSE,
    show = FALSE)
  
  reprex_block <- reprex_to_blocks(rx)
  
  if(!is.null(text)){
    
    res <- post_block(
      channel = channel, 
      block   = block_text(text = text),
      token   = token
    )
    
    post_thread(
      res   = res,
      block = reprex_block
    )
    
  }else{

    post_block(
      channel = channel, 
      block   = reprex_block,
      token   = token
    )
        
  }

}


reprex_to_blocks <- function(x){
  
  rx_chr <- x[nzchar(x)]
  
  rx_txt <- grep('^```',rx_chr)
  
  rx_txt_mat <- matrix(rx_txt,ncol=2,byrow = TRUE)
  
  rx_txt_list <- split(rx_txt_mat, 1:nrow(rx_txt_mat))
  
  rx_txt_idx <- lapply(unname(rx_txt_list),function(x) x[1]:x[2])
  
  rx_txts <- lapply(rx_txt_idx,function(x){
    y <- rx_chr[x]
    y <- gsub('^``` r','```',y)
    block_section(text = block_text(paste0(y,collapse = '\n') ))
  })
  
  rx_combine_idx <- rx_txt_idx 
  rx_combine <- rx_txts
  
  rx_img_idx <- as.list(grep('^!\\[\\]',rx_chr))
  
  if(length(rx_img_idx)>0){
    
    rx_imgs <- lapply(rx_img_idx,function(x){
      block_image(gsub('^!\\[\\]\\(|\\)','',rx_chr[x]))
    })
    
    rx_combine_idx <- c(rx_combine_idx,rx_img_idx)
    rx_combine <- c(rx_txts,rx_imgs)
    
    rx_order <- order(unlist(lapply(rx_combine_idx,max)))
    rx_combine <- rx_combine[rx_order]
    
  }
  
  reprex_block <- as.blocks(rx_combine)
}