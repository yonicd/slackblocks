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
#' @importFrom jsonlite toJSON
slack_reprex <- function(..., text, channel, token = Sys.getenv('SLACK_API_TOKEN')){
  
  channel <- validate_channel(channel)
  
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
    ret <- list(
      block_section(block_text(text,type = 'mrkdwn'),id = 'section_q'),
      block_section(block_text(rx_txt,type = 'mrkdwn'),id = 'section_md'),
      block_image(rx_img)
    )
  }else{
    ret <- list(
      block_section(block_text(text,type = 'mrkdwn'),id = 'section_q'),
      block_section(block_text(rx_txt,type = 'mrkdwn'),id = 'section_md')
    )
  }
  
  post_block(block = jsonlite::toJSON(ret,auto_unbox = TRUE,pretty = TRUE),
             channel = channel, 
             token = token)
             
  
}

#' @importFrom slackcalls post_slack
post_block <- function(block, channel, token = Sys.getenv('SLACK_API_TOKEN')){
  
  invisible(slackcalls::post_slack('chat.postMessage',channel = channel,
                         token = token,
                         as_user = TRUE,
                         blocks = block,paginate = FALSE))
  
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