#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param block PARAM_DESCRIPTION
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
#'  \code{\link[slackcalls]{post_slack}}
#' @rdname post_block
#' @export 
#' @importFrom slackcalls post_slack
#' @importFrom slackteams validate_channel
#' @importFrom jsonlite toJSON
post_block <- function(block, channel, token = Sys.getenv('SLACK_API_TOKEN')){

  if(!inherits(block,'blocks'))
    block <- wrap_blocks(block)
  
  if(!inherits(block,'json'))
    block <- jsonlite::toJSON(block,auto_unbox = TRUE,pretty = TRUE)
  
  channel <- slackteams::validate_channel(channel)
  
  res <- slackcalls::post_slack('chat.postMessage',
                                channel = channel,
                                token = token,
                                as_user = TRUE,
                                blocks = block)
  
  invisible(res)
  
}
