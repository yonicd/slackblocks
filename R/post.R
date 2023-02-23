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
#' @family post
#' @rdname post_block
#' @export
post_block <- function(block, channel, thread_ts = NULL, token = Sys.getenv('SLACK_API_TOKEN')){

  chnl <- prep_channel(channel, thread_ts)
  
  if(inherits(chnl,'slackpost')){
    channel <- chnl$channel
    if(!is.null(chnl$thread_ts)){
      thread_ts <- chnl$thread_ts  
    }else{
      thread_ts <- chnl$ts
    }
  }

  slackposts::chat_message(
    channel = channel,
    blocks  = prep_block(block),
    thread_ts = thread_ts,
    token   = token
  )

}
