#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param block PARAM_DESCRIPTION
#' @param channel character, Channel ID, label or a URL link to a message
#' @param thread_ts character slack api timestamp of the format 
#' xxxxxxxxxx.xxxxxx, Default: NULL
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
#'  \code{\link[slackcalls]{post_slack}}
#' @rdname post_block
#' @export 
#' @importFrom slackcalls post_slack
#' @importFrom slackteams validate_channel
#' @importFrom jsonlite toJSON
post_block <- function(block, channel, thread_ts = NULL, token = Sys.getenv('SLACK_API_TOKEN')){

  if(!inherits(block,'blocks')){
    
    if(inherits(block,'block_text')){
      block <- block_section(text = block)
    }
    
    block <- wrap_blocks(block)
  }
    
  
  if(!inherits(block,'json'))
    block <- jsonlite::toJSON(block,auto_unbox = TRUE,pretty = TRUE)
  
  post_type <- 'standard'
  
  if(!is.null(thread_ts))
    post_type <- 'thread'
  
  if(grepl('^https(.*?)\\.slack\\.com',channel))
    post_type <- 'link'
  
  res <- switch(post_type,
         'link' = {
           
           msg_attrs <- parse_link(channel)
           
           res <- slackcalls::post_slack(
             slack_method = 'chat.postMessage',
             channel = slackteams::validate_channel(msg_attrs$channel),
             token = token,
             as_user = TRUE,
             blocks = block,
             thread_ts = msg_attrs$thread_ts)
         },
         'thread' = {
           slackcalls::post_slack(
             slack_method = 'chat.postMessage',
             channel = slackteams::validate_channel(channel),
             token = token,
             as_user = TRUE,
             blocks = block,
             thread_ts = thread_ts)
         },
         {
           slackcalls::post_slack(
             slack_method = 'chat.postMessage',
             channel = slackteams::validate_channel(channel),
             token = token,
             as_user = TRUE,
             blocks = block)
         })
    
  invisible(res)
  
}

parse_link <- function(message_link){
  
  link_attr <- strsplit(message_link,'\\?')[[1]][1]
  thread_ts <- gsub('^p','',basename(link_attr))
  thread_ts <- sprintf('%s.%s',substr(thread_ts,1,10),substr(thread_ts,11,16))
  channel <- basename(dirname(link_attr))
  
  list(thread_ts = thread_ts, channel = channel)
}
