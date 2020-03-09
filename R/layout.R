#' @title Actions Block
#' @description A block that is used to hold interactive elements.
#' @param elements An array of interactive element objects:
#' buttons, select menus, overflow menus, or date pickers. 
#' There is a maximum of 5 elements in each action block.
#' @param id character, A string acting as a unique identifier for a block. 
#' Default: NULL
#' @return actions_block class
#' @details Available in surfaces: *Modals*, *Messages*, *Home tabs*
#' @examples 
#' 
#' # An actions block with a select menu and a button:
#' 
#' actions_block(
#'   id = 'actions1',
#'   elements = wrap_blocks(
#'     select_menu(
#'       placeholder = 'Which witch is the witchiest witch?',
#'       id = 'select_2',
#'       options = as.blocks(
#'         lapply(c('Matilda','Glinda','Granny Weatherwax','Hermione'),
#'         FUN = function(x){
#'           block_option(
#'             text = x, 
#'             value = gsub('\\s','',tolower(x))
#'            )
#'         })
#'      )
#'     ),
#'     button_element(
#'       text = 'Cancel',
#'       value = 'cancel',
#'       id = 'button_1'
#'     )
#'  )
#' )
#' 
#' # An actions block with a datepicker, an overflow, and a button:
#' 
#' actions_block(
#'   id = 'actionblock789',
#'   elements = wrap_blocks(
#'     datepicker_element(
#'       id = 'datepicker123',
#'       initial_date = '1990-04-28',
#'       placeholder = 'Select a date'
#'     ),
#'     overflow_menu(
#'       id = 'overflow',
#'       options = as.blocks(
#'         lapply(sprintf('value-%d',1:4),block_option,
#'         text = '*this is plain_text text*')
#'        )
#'     ),
#'     button_element(
#'       text = 'Click Me',
#'       value = 'click_me_123',
#'       id = 'button'
#'     )
#'   )
#' )
#' 
#' @rdname actions_block
#' @family layout
#' @export 
actions_block <- function(elements, id = NULL){
  
  payload <- list(
    type = 'actions',
    elements = elements,
    block_id = id
  )
  
  structure(compact(payload),class = c('block','actions_block','list')) 
}

#' @title Context Block
#' @description Displays message context, which can include both images and text.
#' @param elements An array of image elements and text objects. Maximum number of items is 10.
#' @param id character, A string acting as a unique identifier for a block. 
#' Default: NULL
#' @return context_block class
#' @details Available in surfaces: *Modals*, *Messages*, *Home tabs*
#' @examples 
#' context_block(
#'   elements = wrap_blocks(
#'     image_element(
#'       url = 'https://image.freepik.com/free-photo/red-drawing-pin_1156-445.jpg',
#'       alt_text = 'images'
#'     ),
#'     block_text(
#'       text = 'Location: **Dogpatch**'
#'     )
#'   )
#' )
#' @rdname context_block
#' @family layout
#' @export 
context_block <- function(elements, id = NULL){
  
  payload <- list(
    type = 'context',
    elements = elements,
    block_id = id
  )
  
  structure(compact(payload),class = c('block','context_block','list')) 
}

#' @title Divider Block
#' @description A content divider, like an hr HTML DOM, 
#' to split up different blocks inside of a message.
#' @param id character, unique identifier for a block. Default: NULL
#' @return divider_block class
#' @details Available in surfaces: *Modals*, *Messages*, *Home tabs*
#' @examples 
#' divider_block()
#' @rdname divider_block
#' @family layout
#' @export 

divider_block <- function(id = NULL){
  
  payload <- list(
    type = 'divider',
    block_id = id
  )
  
  structure(compact(payload),class = c('block','divider_block','list')) 
}

#' @title File Block
#' @description Displays a [remote file](https://api.slack.com/messaging/files/remote)
#' @param external_id character, the external unique ID for this file.
#' @param id character, A string acting as a unique identifier for a block. 
#' Default: NULL
#' @return block_file class
#' @details Available in surfaces: *Messages*
#' @examples 
#' file_block(
#'   external_id = 'ABCD1'
#' )
#' @rdname block_file
#' @family layout
#' @export 
file_block <- function(external_id, id = NULL){
  
  payload <- list(
    type = 'file',
    external_id = external_id, 
    source = 'remote',
    id = id
  )
  
  structure(compact(payload),class = c('block','file_block','list')) 
}

#' @title Image Block
#' @description A simple image block, designed to make those cat photos really pop.
#' @param image_url character, The URL of the image to be displayed.
#' @param alt_text character, A plain-text summary of the image. 
#' This should not contain any markup.
#' @param title character, an optional title for the image. Default: NULL
#' @param id character, unique identifier for a block. Default: NULL
#' @return block_divider class
#' @details Available in surfaces: *Modals*, *Messages*, *Home tabs*
#' @examples 
#' image_block(
#'  image_url = 'http://placekitten.com/500/500',
#'  alt_text = 'An incredibly cute kitten.',
#'  title = 'Please enjoy this photo of a kitten',
#'  id = 'image4'
#' )
#' @rdname image_block
#' @family layout
#' @export 

image_block <- function(image_url, alt_text, title = NULL, id = NULL){
  
  if(!is.null(title))
    title <- block_text(text = title, type = 'plain_text')
  
  payload <- list(
    type = 'image',
    image_url = image_url,
    alt_text= alt_text,
    title = title,
    block_id = id
  )
  
  structure(compact(payload),class = c('block','image_block','list')) 
}

#' @title Input Block
#' @description A block that collects information from users - 
#' it can hold a plain-text input element, a select menu element, 
#' a multi-select menu element, or a datepicker.
#' @param label character, a label that appears above an input element.
#' @param element An plain-text input element, a select menu element, 
#' a multi-select menu element, or a datepicker.
#' @param id character, A string acting as a unique identifier for a block. 
#' Default: NULL
#' @param hint An optional hint that appears below an input element in a lighter grey.
#' Default: NULL
#' @param optional A boolean that indicates whether the input element may be 
#' empty when a user submits the modal. Default: NULL
#' @return input_block class
#' @details Available in surfaces: *Modals*, *Messages*, *Home tabs*
#' @examples 
#' input_block(
#'   id = 'input123',
#'   label = 'Label of input',
#'   element = plaintext_element(
#'     id = 'plain_input',
#'     placeholder = 'Enter some plain text'
#'   )
#' )
#' @rdname input_block
#' @family layout
#' @export 
input_block <- function(label, element, id = NULL, hint = NULL, optional = NULL){
  
  if(!is.null(hint))
    hint <- block_text(hint,type='plain_text')
  
  if(!is.null(optional))
    optional <- checkmate::check_class(optional,'logical')
  
  payload <- list(
    type = 'input',
    block_id = id, 
    label = block_text(label,type='plain_text'),
    element = element,
    hint = hint,
    optional = optional
  )
  
  structure(compact(payload),class = c('block','input_block','list')) 
}

#' @title Section Block
#' @description A section is one of the most flexible blocks available, it can 
#' be used as a simple text block, in combination with text fields, 
#' or side-by-side with any of the available block elements.
#' @param text character, The text for the block, in the form of a text object. 
#' Maximum length for the text in this field is 3000 characters.
#' @param id character, A string acting as a unique identifier for a block. 
#' Default: NULL
#' @param fields 	An array of text objects. Any text objects included with 
#' fields will be rendered in a compact format that allows for 2 columns 
#' of side-by-side text. Maximum number of items is 10., Default: NULL
#' @param accessory One of the available element objects. Default: NULL
#' @return section_block class
#' @details Available in surfaces: *Modals*, *Messages*, *Home tabs*
#' @examples 
#' section_block(
#'   text = block_text(
#'     text = "A message *with some bold text* and _some italicized text_."
#'   )
#' )
#' 
#' section_block(
#'   text = block_text(
#'     text = "A message *with some bold text* and _some italicized text_."
#'   ),
#'   fields = wrap_blocks(
#'   block_text(text = 'High'),
#'   block_text(
#'     type = 'plain_text',
#'     text = 'string',
#'     emoji = TRUE)
#'   )
#' )
#' 
#' section_block(
#'   text = block_text(
#'     text = "*Sally* has requested you set the deadline for the Nano launch project"
#'   ),
#'   accessory = datepicker_element(
#'     id = 'datepicker123',
#'     initial_date = "1990-04-28", 
#'     placeholder = 'Select a date'
#'    )
#'   )
#' 
#' @rdname section_block
#' @family layout
#' @export 
section_block <- function(text, id = NULL, fields = NULL, accessory = NULL){
  
  payload <- list(
    type = 'section',
    text = text,
    block_id = id, 
    fields = fields,
    accessory = accessory
  )
  
  structure(compact(payload),class = c('block','section_block','list')) 
}
