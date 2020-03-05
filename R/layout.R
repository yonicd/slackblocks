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
#' @return block_section class
#' @details Available in surfaces: *Modals*, *Messages*, *Home tabs*
#' @examples 
#' block_section(
#'   text = block_text(
#'     text = "A message *with some bold text* and _some italicized text_."
#'   )
#' )
#' 
#' block_section(
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
#' block_section(
#'   text = block_text(
#'     text = "*Sally* has requested you set the deadline for the Nano launch project"
#'   ),
#'   accessory = block_datepicker(
#'     id = 'datepicker123',
#'     initial_date = "1990-04-28", 
#'     placeholder = 'Select a date'
#'    )
#'   )
#' 
#' @rdname block_section
#' @family layout
#' @export 
block_section <- function(text, id = NULL, fields = NULL, accessory = NULL){
  
  payload <- list(
    type = 'section',
    text = text,
    block_id = id, 
    fields = fields,
    accessory = accessory
  )
  
  structure(compact(payload),class = c('block','block_section','list')) 
}

#' @title Context Block
#' @description Displays message context, which can include both images and text.
#' @param elements An array of image elements and text objects. Maximum number of items is 10.
#' @param id character, A string acting as a unique identifier for a block. 
#' Default: NULL
#' @return block_context class
#' @details Available in surfaces: *Modals*, *Messages*, *Home tabs*
#' @examples 
#' block_context(
#'   elements = wrap_blocks(
#'     block_image(
#'       url = 'https://image.freepik.com/free-photo/red-drawing-pin_1156-445.jpg',
#'       alt_text = 'images'
#'     ),
#'     block_text(
#'       text = 'Location: **Dogpatch**'
#'     )
#'   )
#' )
#' @rdname block_context
#' @family layout
#' @export 
block_context <- function(elements, id = NULL){
  
  payload <- list(
    type = 'context',
    elements = elements,
    block_id = id
  )
  
  structure(compact(payload),class = c('block','block_context','list')) 
}

#' @title Divider Block
#' @description A content divider, like an hr HTML DOM, 
#' to split up different blocks inside of a message.
#' @param id character, unique identifier for a block. Default: NULL
#' @return block_divider class
#' @details Available in surfaces: *Modals*, *Messages*, *Home tabs*
#' @examples 
#' block_divider()
#' @rdname block_divider
#' @family layout
#' @export 

block_divider <- function(id = NULL){
  
  payload <- list(
    type = 'divider',
    block_id = id
  )
  
  structure(compact(payload),class = c('block','block_divider','list')) 
}

#' @title Array of blocks
#' @description wrap block class objects in a list
#' @param ... block elements
#' @return list of blocks elements
#' @examples 
#' wrap_blocks(
#'     block_image(
#'       url = 'https://image.freepik.com/free-photo/red-drawing-pin_1156-445.jpg',
#'       alt_text = 'images'
#'     ),
#'     block_text(
#'       text = 'Location: **Dogpatch**'
#'     )
#'   )
#' @rdname wrap_blocks
#' @family layout
#' @export 

wrap_blocks <- function(...){
  structure(list(...),class = c('blocks','list'))
}

#' @title Coerce into Blocks
#' @description Turns existing object into block elements
#' @param x object
#' @return block object
#' @rdname as.blocks
#' @family layout
#' @export 
as.blocks <- function(x){
  UseMethod('as.blocks')
}

#' @export 
as.blocks.list <- function(x){
  structure(x,class = c('blocks','list'))
}
