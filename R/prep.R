#' @title Prepare Channel
#' @description Function that will parse multiple types of channel inputs.
#' @param channel character
#' @param ts character slack api timestamp of the format 
#' xxxxxxxxxx.xxxxxx, Default: NULL
#' @return channel
#' @details 
#'   channel can be either
#'     - channel id
#'     - link to a message from slack
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname prep_channel
#' @export 
#' @family post
prep_channel <- function(channel, ts = NULL){

  if(inherits(channel,'slackpost'))
    return(channel)
  
  if(grepl('^https(.*?)\\.slack\\.com',channel)){
    
    msg_attrs <- parse_link(channel)
    
    channel <- msg_attrs$channel
    thread_ts <- msg_attrs$thread_ts
    
    ret <- list(
      channel = channel, 
      ts = NULL,
      thread_ts  = thread_ts
    )
    
    return(structure(ret,class = 'slackpost'))
    
  }

  if(!is.null(ts)){
    ret <- list(
      channel = channel, 
      ts = ts,
      thread_ts  = NULL
    )
    
    return(structure(ret,class = 'slackpost')) 
  }
  
  structure(channel,class = 'character')
  
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

#' @importFrom jsonlite toJSON
prep_block <- function(block){
  
  if(!inherits(block,'blocks')){
    
    if(inherits(block,'block_text')){
      block <- section_block(text = block)
    }
    
    block <- wrap_blocks(block)
  }
  
  if(!inherits(block,'json'))
    block <- jsonlite::toJSON(block,auto_unbox = TRUE,pretty = TRUE)
  
  block
}

