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
#' @importFrom jsonlite toJSON
post_block <- function(block, channel, token = Sys.getenv('SLACK_API_TOKEN')){

  if(!inherits(block,'blocks'))
    block <- wrap_blocks(block)
  
  if(!inherits(block,'json'))
    block <- jsonlite::toJSON(block,auto_unbox = TRUE,pretty = TRUE)
  
  channel <- validate_channel(channel)
  
  res <- slackcalls::post_slack('chat.postMessage',
                                channel = channel,
                                token = token,
                                as_user = TRUE,
                                blocks = block,
                                paginate = FALSE)
  
  invisible(res)
  
}

#' @importFrom slackteams get_team_channels get_active_team
validate_channel <- function(channel){
  
  # Strip leading # or @ to allow user flexibility.
  channel <- sub("^#", "", channel)
  channel <- sub("^@", "", channel)
  
  team_channels <- slackteams::get_team_channels(
    slackteams::get_active_team(),
    fields = c('id','name')
  )
  
  # Check both the id and name, in case the user passed in an id.
  if (channel %in% team_channels$id) {
    return(channel)
  } else if (channel %in% team_channels$name) {
    return(team_channels$id[grepl(channel, team_channels$name)])
  } else {
    stop("Unknown channel.")
  }

}
