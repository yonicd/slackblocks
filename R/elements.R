#' @title Button element
#' @description An interactive component that inserts a button. 
#' The button can be a trigger for anything from opening a 
#' simple link to starting a complex workflow.
#' @param text character, text of the button
#' @param id character, An identifier for this action.
#' @param value The value to send along with the interaction 
#' payload. Default: NULL
#' @param url character, A URL to load in the user's browser 
#' when the button is clicked. Default: NULL
#' @param style Decorates buttons with alternative visual 
#' color schemes, Default: NULL
#' @param confirm block_confirm, defines an optional 
#' confirmation dialog after the button is clicked. Default: NULL
#' @return block_button class
#' @details 
#'   - Works with block types: *Section*, *Actions*
#'   - **primary** gives buttons a green outline and text, ideal for affirmation or confirmation actions. 
#'   - **primary** should only be used for one button within a set.
#'   - **danger** gives buttons a red outline and text, and should be used when the action is destructive. 
#'   - Use **danger** even more sparingly than primary.
#'   - If you don't include this field, the **default** button style will be used.
#' @examples 
#' # A regular interactive button:
#' block_button(text = 'Click Me', value = 'click_me_123', id = 'button')
#' 
#' # A button with a primary style attribute:
#' block_button(text = 'Click Me', value = 'click_me_123', id = 'button',style = 'primary')
#' 
#' # A link button:
#' 
#' block_button(text = 'Link Button', url = 'https://api.slack.com/block-kit', id = 'button')
#' 
#' @rdname block_button
#' @family elements
#' @export 

block_button <- function(id,
                   text, 
                   value = NULL,
                   url = NULL, 
                   style = NULL, 
                   confirm = NULL){
  
  
  
  payload <- list(
    type = 'button',
    text = block_text(text,type = 'plain_text'),
    action_id = id,
    value = value,
    url = url,
    style = style,
    confirm = confirm
  )
  
  structure(compact(payload),class = c('block','block_button', 'list'))
  
}


#' @title Date picker element
#' @description An element which lets users easily 
#' select a date from a calendar style UI.
#' @param id An identifier for the action triggered 
#' when a menu option is selected.
#' @param placeholder character, placeholder text shown on the datepicker. Default: NULL
#' @param initial_date Date, The initial date that is 
#' selected when the element is loaded. 
#' This should be in the [strftime][base::strftime] 
#' format '%Y-%m-%d'. Default: NULL
#' @param confirm block_confirm, defines an optional 
#' confirmation dialog after the button is clicked. Default: NULL
#' @return block_datepicker class
#' @details 
#' 
#'   - Works with block types: *Section*, *Actions*, *Input*
#' 
#' @examples 
#' block_datepicker(id = 'datepicker123',initial_date = "1990-04-28", 
#' placeholder = 'Select a date')
#' @seealso [parse_date][parsedate::parse_date]
#' @rdname block_datepicker
#' @family elements
#' @importFrom parsedate parse_date
#' @export 
block_datepicker <- function(id, 
                             placeholder = NULL,
                             initial_date = NULL,
                             confirm = NULL){
  
  payload <- list(
    type = 'datepicker',
    placeholder = block_text(placeholder,type = 'plain_text'),
    action_id = id,
    initial_date = as.character(parsedate::parse_date(initial_date)),
    confirm = confirm
  )
  
  structure(compact(payload),class = c('block','block_datepicker','list'))
  
}

#' @title Image element
#' @description A simple image block
#' @param url character, URL of the image to be displayed, Default: NULL
#' @param alt_text character, text summary of the image, Default: 'image'
#' @param title An optional title for the image, Default: NULL
#' @param id character, unique identifier for a block, Default: NULL
#' @return block_image class
#' @details
#'
#'   - Works with block types: *Section*, *Context*
#'
#' @examples 
#' 
#' block_image(
#'   url = 'http://placekitten.com/500/500',
#'   alt_text = 'An incredibly cute kitten.'
#' )
#' 
#' block_image(
#'   title = "Please enjoy this photo of a kitten",
#'   id = 'image4',
#'   url = 'http://placekitten.com/500/500',
#'   alt_text = 'An incredibly cute kitten.'
#' )
#' @rdname block_image
#' @family elements
#' @export 

block_image <- function(url = NULL, alt_text = 'image', title = NULL, id = NULL){
  
  if(!is.null(title))
    title <- block_text(title,type = 'plain_text')
  
  payload <- list(
    type = 'image',
    title = title,
    block_id = id,
    image_url = url,
    alt_text = alt_text
  )
  
  structure(compact(payload),class = c('block','block_image','list'))
  
}

#' @title Radio button group element
#' @description A radio button group that allows a 
#' user to choose one item from a list of possible options.
#' @param id character, An identifier for the action triggered 
#' when the radio button group is changed.
#' @param opts list, a list of block_options.
#' @param initial_options An option_block that exactly 
#' matches one of the options within options, Default: NULL
#' @param confirm block_confirm, defines an optional 
#' confirmation dialog after the button is clicked. Default: NULL
#' @return block_radio_buttons class
#' @details
#' 
#'   - Works with block types: *Section*, *Actions*, *Input*
#' 
#' @rdname block_radio_buttons
#' @family elements
#' @export 
#' @importFrom checkmate check_class
block_radio_buttons <- function(id, opts, initial_options = NULL, confirm = NULL){
  
  checkmate::check_class(opts,classes = 'block_options')

  payload <- list(
    type = 'radio_buttons',
    action_id = id,
    options = opts,
    initial_options = initial_options,
    confirm = confirm
  )
  
  structure(compact(payload),class = c('block','block_radio_buttons', 'list'))
  
}
