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
post_block <- function(block, channel, thread_ts = NULL, token = Sys.getenv('SLACK_API_TOKEN')){

  post(prep_channel(channel, thread_ts),prep_block(block), token = token)

}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param res PARAM_DESCRIPTION
#' @param block PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname post_thread
#' @export 
post_thread <- function(res,block){
  post_block(block = block, channel = res$channel, thread_ts = res$ts, token = attr(res,'body')[['token']])
}

post <- function(channel, block, token = Sys.getenv('SLACK_API_TOKEN')){
  UseMethod('post')
}

#' @importFrom slackcalls post_slack
post.default <- function(channel, block, token = Sys.getenv('SLACK_API_TOKEN')){
  
  res <- slackcalls::post_slack(
    slack_method = 'chat.postMessage',
    channel = channel,
    token = token,
    as_user = TRUE,
    blocks = block)
  
  invisible(res)
  
}

#' @importFrom slackcalls post_slack
post.post_thread <- function(channel, block, token = Sys.getenv('SLACK_API_TOKEN')){
  
  res <- slackcalls::post_slack(
    slack_method = 'chat.postMessage',
    channel = channel,
    token = token,
    as_user = TRUE,
    blocks = block,
    thread_ts = attr(channel,'thread_ts'))
  
  invisible(res)
}


parse_link <- function(message_link){
  
  link_attr <- strsplit(message_link,'\\?')[[1]][1]
  thread_ts <- gsub('^p','',basename(link_attr))
  thread_ts <- sprintf('%s.%s',substr(thread_ts,1,10),substr(thread_ts,11,16))
  channel <- basename(dirname(link_attr))
  
  list(thread_ts = thread_ts, channel = channel)
}

#' @importFrom slackteams validate_channel
prep_channel <- function(channel, ts = NULL){
  
  type <- 'default'
  
  if(!is.null(ts))
    type <- 'thread'
  
  if(grepl('^https(.*?)\\.slack\\.com',channel)){
    
    msg_attrs <- parse_link(channel)
    channel <- msg_attrs$channel
    ts <- msg_attrs$thread_ts
    type <- 'thread'
    
  }

  channel <- slackteams::validate_channel(channel)
  
  structure(channel, class = c(sprintf('post_%s',type),'channel','character'), thread_ts = ts)
  
}

#' @importFrom jsonlite toJSON
prep_block <- function(block){
  
  if(!inherits(block,'blocks')){
    
    if(inherits(block,'block_text')){
      block <- block_section(text = block)
    }
    
    block <- wrap_blocks(block)
  }
  
  if(!inherits(block,'json'))
    block <- jsonlite::toJSON(block,auto_unbox = TRUE,pretty = TRUE)
  
  block
}
