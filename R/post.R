#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param block PARAM_DESCRIPTION
#' @param channel Channel ID, label or a URL link to a message
#' @param token PARAM_DESCRIPTION, Default: Sys.getenv("SLACK_API_TOKEN")
#' @param message_link character, 
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
post_block <- function(block, channel, token = Sys.getenv('SLACK_API_TOKEN')){

  if(!inherits(block,'blocks')){
    
    if(inherits(block,'block_text')){
      block <- block_section(text = block)
    }
    
    block <- wrap_blocks(block)
  }
    
  
  if(!inherits(block,'json'))
    block <- jsonlite::toJSON(block,auto_unbox = TRUE,pretty = TRUE)
  
  if(grepl('^https(.*?)\\.slack\\.com',channel)){
    
    msg_attrs <- parse_link(channel)
    
    res <- slackcalls::post_slack('chat.postMessage',
                                  channel = slackteams::validate_channel(msg_attrs$channel),
                                  token = token,
                                  as_user = TRUE,
                                  blocks = block,
                                  thread_ts = msg_attrs$thread_ts)  
  }else{

    res <- slackcalls::post_slack('chat.postMessage',
                                  channel = slackteams::validate_channel(channel),
                                  token = token,
                                  as_user = TRUE,
                                  blocks = block)
  }

  invisible(res)
  
}

parse_link <- function(message_link){
  
  link_attr <- strsplit(message_link,'\\?')[[1]][1]
  thread_ts <- gsub('^p','',basename(link_attr))
  thread_ts <- sprintf('%s.%s',substr(thread_ts,1,10),substr(thread_ts,11,16))
  channel <- basename(dirname(link_attr))
  
  list(thread_ts = thread_ts, channel = channel)
}
