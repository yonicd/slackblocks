#' @title Create a block for text
#' @description Create slack block that contains text
#' @param text character, the text for the block.
#' @param type character, type of block, Default: c("mrkdwn", "plain_text")
#' @param emoji logical, Indicates whether emojis in a text field should be
#'  escaped into the colon emoji format. This field is only usable 
#'  when type is plain_text. Default: NULL
#' @param verbatim When set to FALSE (Default value when NULL) URLs 
#'  will be auto-converted into links, conversation names will be 
#'  link-ified, and certain mentions will be automatically parsed. 
#'  Default: NULL
#' @return block_text class
#' @details For more details see [slack documentation](https://api.slack.com/reference/block-kit/composition-objects#text)
#' @examples 
#' block_text('A message *with some bold text* and _some italicized text_.')
#' @rdname block_text
#' @export 

block_text <- function(text, type = c('mrkdwn', 'plain_text'), emoji = NULL, verbatim = NULL){

  payload <- list(
    type = match.arg(type,c('mrkdwn', 'plain_text')),
    text = text,
    emoji = yesno(emoji),
    verbatim = yesno(verbatim)
  )
  
  structure(compact(payload),class = c('block','block_text','list'))

}


#' @title Create a block for options
#' @description An object that represents a single selectable item 
#' in a select menu, multi-select menu, radio button group, 
#' or overflow menu.
#' @param text character, text that defines the text 
#' shown in the option on the menu. 
#' @param value character, The string value that will be 
#' passed to your app when this option is chosen. 
#' @param description character, text that defines a line 
#' of descriptive text shown below the  text field beside
#' the radio button. Default: NULL
#' @param url character, A URL to load in the user's browser 
#' when the option is clicked. Default: NULL
#' @return block_option class
#' @examples 
#' block_option(text = 'Maru',value = 'maru')
#' @rdname block_option
#' @export 

block_option <- function(text, value, description = NULL, url = NULL){
  
  if(!is.null(description))
    description <- block_text(description, type = 'plain_text')
  
  payload <- list(
    text = block_text(text, type = 'plain_text'),
    value = value,
    description = description,
    url = url
  )
  
  structure(compact(payload),class = c('block','block_option','list'))
  
}


#' @title Group Option Blocks
#' @description Provides a way to group options in a 
#' select menu or multi-select menu.
#' @param opts list, A named list of option objects that belong to 
#' this specific group. Maximum of 100 items.
#' @return block_option_groups class
#' @details if the input list is not named a templated name will be given
#' in the form 'Group 01', 'Group 02', ...
#' @examples 
#' block_option_groups(
#' list(
#'   'Group 1' = list(
#'   block_option(text = '*this is plain_text text*',value = 'value-0'),
#'   block_option(text = '*this is plain_text text*',value = 'value-1'),
#'   block_option(text = '*this is plain_text text*',value = 'value-2')
#'   ),
#'   'Group 2' = list(
#'   block_option(text = '*this is plain_text text*',value = 'value-3')
#'   )
#'   )
#'  )
#'  
#' block_option_groups(
#' list(
#'   list(
#'   block_option(text = '*this is plain_text text*',value = 'value-0'),
#'   block_option(text = '*this is plain_text text*',value = 'value-1'),
#'   block_option(text = '*this is plain_text text*',value = 'value-2')
#'   ),
#'   list(
#'   block_option(text = '*this is plain_text text*',value = 'value-3')
#'   )
#'   )
#'  )
#' @rdname block_option_groups
#' @export 

block_option_groups <- function(opts){
  
  if(is.null(names(opts)))
    names(opts) <- sprintf('Group %02d',seq_along(opts))
  
  og <- mapply(function(l,o){
    list(label = block_text(l,type = 'plain_text'), 
         options = compact(o)) 
  }, l = names(opts), o = opts,SIMPLIFY = FALSE,USE.NAMES = FALSE)
  
  payload <- list(option_groups = og)
  
  structure(payload,class = c('block','block_option_groups','list'))
}


#' @title Confirmation dialog object
#' @description An object that defines a dialog that provides 
#' a confirmation step to any interactive element. 
#' This dialog will ask the user to confirm their action 
#' by offering a confirm and deny buttons.
#' @param title character, dialog's title
#' @param text block_text, the explanatory text that
#'  appears in the confirm dialog
#' @param confirm character, text of the button that 
#' confirms the action.
#' @param deny character, text of the button that 
#' cancels the action.
#' @return block_confirm class
#' @examples 
#' block_confirm(
#'   title = "Are you sure?",
#'   text = block_text("Wouldn't you prefer a good game of _chess_?"),
#'   confirm = "Do it",
#'   deny = "Stop, I've changed my mind!"
#' )
#' @rdname block_confirm
#' @importFrom checkmate check_class
#' @export 

block_confirm <- function(title, text, confirm, deny){
 
  checkmate::check_class(text,'block_text')
  
  payload <- list(
    title = block_text(title, type = 'plain_text'),
    text = text,
    confirm = block_text(confirm, type = 'plain_text'),
    deny = block_text(deny, type = 'plain_text')
  )
  
  structure(compact(payload),class = c('block','block_confirm','list'))
   
}