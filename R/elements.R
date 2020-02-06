#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @param id PARAM_DESCRIPTION
#' @param value PARAM_DESCRIPTION, Default: NULL
#' @param url PARAM_DESCRIPTION, Default: NULL
#' @param style PARAM_DESCRIPTION, Default: NULL
#' @param confirm PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
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
#' @export 

block_button <- function(id,
                   text, 
                   value = NULL,
                   url = NULL, 
                   style = NULL, 
                   confirm = NULL){
  
  
  
  payload <- list(
    type = 'button',
    text = as.block_text(text),
    action_id = id,
    value = value,
    url = url,
    style = style,
    confirm = confirm
  )
  
  structure(compact(payload),class = c('block','list'))
  
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param id PARAM_DESCRIPTION
#' @param placeholder PARAM_DESCRIPTION, Default: NULL
#' @param initial_date PARAM_DESCRIPTION, Default: NULL
#' @param confirm PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' block_datepicker(id = 'datepicker123',initial_date = "1990-04-28", 
#' placeholder = 'Select a date')
#' @rdname block_datepicker
#' @export 
block_datepicker <- function(id, 
                             placeholder = NULL,
                             initial_date = NULL,
                             confirm = NULL){
  
  # verify initial_date is %Y-%m-%d

  payload <- list(
    type = 'datepicker',
    placeholder = as.block_text(placeholder),
    action_id = id,
    initial_date = initial_date,
    confirm = confirm
  )
  
  structure(compact(payload),class = c('block','list'))
  
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param url PARAM_DESCRIPTION, Default: NULL
#' @param alt_text PARAM_DESCRIPTION, Default: 'image'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname block_image
#' @export 

block_image <- function(url = NULL, alt_text = 'image'){
  
  payload <- list(
    type = 'image',
    image_url = url,
    alt_text = alt_text
  )
  
  structure(compact(payload),class = c('block','list'))
  
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param id PARAM_DESCRIPTION
#' @param opts PARAM_DESCRIPTION
#' @param initial_options PARAM_DESCRIPTION, Default: NULL
#' @param confirm PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname radio_buttons
#' @export 
#' @importFrom checkmate check_class
radio_buttons <- function(id, opts, initial_options = NULL, confirm = NULL){
  
  checkmate::check_class(opts,classes = 'block_options')

  payload <- list(
    type = 'radio_buttons',
    action_id = id,
    options = opts,
    initial_options = initial_options,
    confirm = confirm
  )
  
  structure(compact(payload),class = c('block','list'))
  
}
