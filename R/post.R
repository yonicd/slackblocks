#' @title Post Block Element
#' @description Post block to slack channel
#' @param block block element(s)
#' @param channel character, Channel ID, label or a URL link to a message
#' @param thread_ts character slack api timestamp of the format 
#' xxxxxxxxxx.xxxxxx, Default: NULL
#' @param token Slack API token, Default: Sys.getenv("SLACK_API_TOKEN")
#' @return [response][httr::response]
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[slackcalls]{post_slack}}
#' @family post
#' @rdname post_block
#' @export 
post_block <- function(block, channel, thread_ts = NULL, token = Sys.getenv('SLACK_API_TOKEN')){

  post(prep_channel(channel, thread_ts),prep_block(block), token = token)

}

#' @title Post Block Element to Thread
#' @description Post block to slack channel thread
#' @param res [response][httr::response] from [post_block][slackblocks::post_block]
#' @param block block element(s)
#' @return [response][httr::response]
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname post_thread
#' @family post
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
  
  split_message <- strsplit(message_link,'\\?')[[1]]
  
  if(length(split_message)==1){
    link_attr <- split_message[1]
    thread_ts <- gsub('^p','',basename(link_attr))
    thread_ts <- sprintf('%s.%s',substr(thread_ts,1,10),substr(thread_ts,11,16))
    channel <- basename(dirname(link_attr))  
  }else{
    link_attr <- strsplit(split_message[2],'\\&')[[1]]
    thread_ts <- gsub('^(.*?)=','',link_attr[1])
    channel <- gsub('^(.*?)=','',link_attr[2])
  }
  
  list(thread_ts = thread_ts, channel = channel)
}

#' @title Prepare Channel
#' @description Function that will parse multiple types of channel inputs.
#' @param channel character
#' @param ts character slack api timestamp of the format 
#' xxxxxxxxxx.xxxxxx, Default: NULL
#' @return channel
#' @details 
#'   channel can be either
#'     - channel label
#'     - channel id
#'     - link to a message from slack
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[slackteams]{validate_channel}}
#' @rdname prep_channel
#' @export 
#' @family post
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
  
  structure(
    channel, 
    class = c(sprintf('post_%s',type),'channel','character'), 
    thread_ts = ts
  )
  
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

