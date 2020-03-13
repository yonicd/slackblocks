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
#' @return block element class
#' @details 
#'   - Works with block types: *Section*, *Actions*
#'   - **primary** gives buttons a green outline and text, ideal for affirmation or confirmation actions. 
#'   - **primary** should only be used for one button within a set.
#'   - **danger** gives buttons a red outline and text, and should be used when the action is destructive. 
#'   - Use **danger** even more sparingly than primary.
#'   - If you don't include this field, the **default** button style will be used.
#' @examples 
#' # A regular interactive button:
#' button_element(text = 'Click Me', value = 'click_me_123', id = 'button')
#' 
#' # A button with a primary style attribute:
#' button_element(text = 'Click Me', value = 'click_me_123', id = 'button',style = 'primary')
#' 
#' # A link button:
#' 
#' button_element(text = 'Link Button', url = 'https://api.slack.com/block-kit', id = 'button')
#' 
#' @rdname button_element
#' @family elements
#' @export 

button_element <- function(id,
                   text, 
                   value = NULL,
                   url = NULL, 
                   style = NULL, 
                   confirm = NULL){
  
  if(!is.null(confirm))
    checkmate::expect_class(confirm,'block_confirm')
  
  payload <- list(
    type = 'button',
    text = block_text(text,type = 'plain_text'),
    action_id = id,
    value = value,
    url = url,
    style = style,
    confirm = confirm
  )
  
  structure(compact(payload),class = c('block','element', 'list'))
  
}

#' @title Checkbox groups
#' @description A checkbox group that allows a user to choose multiple 
#' items from a list of possible options.
#' @param id character, an identifier for the action triggered when the 
#' checkbox group is changed.
#' @param options An list of block_option objects.
#' @param initial_options An list of block_option objects that exactly 
#' matches one or more of the options within options. Default: NULL
#' @param confirm A confirm object that defines an optional confirmation
#'  dialog that appears after clicking one of the checkboxes in this element.
#'   Default: NULL
#' @return block element class
#' @details Works with block types: *Section*, *Actions*, *Input*
#' @examples 
#' section_block(
#' text = 'Check out these charming checkboxes',
#' accessory = checkbox_element(
#'  id = 'my_checkbox',
#'  options = wrap_blocks(
#'  block_option(
#'    value = 'A1',
#'    text = 'Checkbox 1'
#'  ),
#'  block_option(
#'    value = 'A2',
#'    text = 'Checkbox 2'
#'  )
#'  ),
#'  initial_options = wrap_blocks(
#'    block_option(
#'      value = 'A1',
#'      text = 'Checkbox 1'
#'    )
#'  )
#' )
#' )
#' @seealso 
#'  \code{\link[checkmate]{checkClass}}
#' @rdname checkbox_element
#' @family elements
#' @export 
#' @importFrom checkmate check_class
checkbox_element <- function(id, options, initial_options = NULL, confirm = NULL){
  
  checkmate::check_class(options,classes = 'block_option')
  
  if(!is.null(confirm))
    checkmate::expect_class(confirm,'block_confirm')
  
  payload <- list(
    type = 'checkboxes',
    action_id = id,
    options = options,
    initial_options = initial_options,
    confirm = confirm
  )
  
  structure(compact(payload),class = c('block','element', 'list'))
  
}

#' @title Date picker element
#' @description An element which lets users easily 
#' select a date from a calendar style UI.
#' @param id character, an identifier for the action triggered 
#' when a menu option is selected.
#' @param placeholder character, placeholder text shown on the datepicker. Default: NULL
#' @param initial_date Date, The initial date that is 
#' selected when the element is loaded. 
#' This should be in the [strftime][base::strftime] 
#' format '%Y-%m-%d'. Default: NULL
#' @param confirm block_confirm, defines an optional 
#' confirmation dialog after the button is clicked. Default: NULL
#' @return block element class
#' @details 
#' 
#'   - Works with block types: *Section*, *Actions*, *Input*
#' 
#' @examples 
#' datepicker_element(id = 'datepicker123',initial_date = "1990-04-28", 
#' placeholder = 'Select a date')
#' @seealso [parse_date][parsedate::parse_date]
#' @rdname datepicker_element
#' @family elements
#' @importFrom parsedate parse_date
#' @export 
datepicker_element <- function(id, 
                             placeholder = NULL,
                             initial_date = NULL,
                             confirm = NULL){
  
  if(!is.null(confirm))
    checkmate::expect_class(confirm,'block_confirm')
  
  payload <- list(
    type = 'datepicker',
    placeholder = block_text(placeholder,type = 'plain_text'),
    action_id = id,
    initial_date = as.character(parsedate::parse_date(initial_date)),
    confirm = confirm
  )
  
  structure(compact(payload),class = c('block','element','list'))
  
}

#' @title Image element
#' @description A simple image block
#' @param url character, URL of the image to be displayed, Default: NULL
#' @param alt_text character, text summary of the image, Default: 'image'
#' @return block element class
#' @details
#'
#'   - Works with block types: *Section*, *Context*
#'
#' @examples 
#' 
#' image_element(
#'   url = 'http://placekitten.com/700/500',
#'   alt_text = 'Multiple cute kittens.'
#' )
#' 
#' @rdname image_element
#' @family elements
#' @export 

image_element <- function(url = NULL, alt_text = 'image'){
  
  if(!is.null(title))
    title <- block_text(title,type = 'plain_text')
  
  payload <- list(
    type = 'image',
    image_url = url,
    alt_text = alt_text
  )
  
  structure(compact(payload),class = c('block','element','list'))
  
}

#' @title Radio button group element
#' @description A radio button group that allows a 
#' user to choose one item from a list of possible options.
#' @param id character, An identifier for the action triggered 
#' when the radio button group is changed.
#' @param options list, a list of block_options.
#' @param initial_option An option_block that exactly 
#' matches one of the options within options, Default: NULL
#' @param confirm block_confirm, defines an optional 
#' confirmation dialog after the button is clicked. Default: NULL
#' @return block element class
#' @details
#' 
#'   - Works with block types: *Section*, *Actions*, *Input*
#' 
#' @rdname radiobuttons_element
#' @family elements
#' @export 
#' @importFrom checkmate check_class
radiobuttons_element <- function(id, options, initial_option = NULL, confirm = NULL){
  
  checkmate::check_class(options,classes = 'block_option')

  if(!is.null(confirm))
    checkmate::expect_class(confirm,'block_confirm')
  
  payload <- list(
    type = 'radio_buttons',
    action_id = id,
    options = options,
    initial_option = initial_option,
    confirm = confirm
  )
  
  structure(compact(payload),class = c('block','element', 'list'))
  
}

#' @title Plain-text input element
#' @description A plain-text input, similar to the HTML input tag, 
#' creates a field where a user can enter freeform data. 
#' It can appear as a single-line field or a larger textarea 
#' using the multiline flag.
#' @param id character, an identifier for the input value when the parent modal
#'  is submitted.
#' @param placeholder character, A text object that defines the placeholder text
#'  shown in the plain-text input.
#' @param initial_value character, the initial value in the plain-text 
#' input when it is loaded. Default: NULL
#' @param multiline logical, indicates whether the input will be a single 
#' line (FALSE) or a larger textarea (TRUE). Default: NULL
#' @param min_length integer, the minimum length of input that the user must 
#' provide. If the user provides less, they will receive an error. Default: NULL
#' @param max_length integer, The maximum length of input that the user can provide. 
#' If the user provides more, they will receive an error in the response. Default: NULL
#' @return block element object
#' @details Works with block types: *Section*, *Actions*, *Input*
#' @examples 
#' plaintext_element(
#'   id = 'plain_input',
#'   placeholder = 'Enter some plain text'
#' )
#' @family elements
#' @rdname plaintext_element
#' @export 

plaintext_element <- function(id, placeholder, initial_value = NULL, multiline = NULL, min_length = NULL, max_length = NULL){

  if(!is.null(multiline))
    multiline <- checkmate::check_class(multiline,'logical')
  
  payload <- list(
    type = 'plain_text_input',
    action_id = id,
    placeholder = block_text(placeholder,type = 'plain_text'),
    initial_value = initial_value,
    multiline = multiline,
    min_length = force_integer(min_length),
    max_length = force_integer(max_length)
  )
  
  structure(compact(payload),class = c('block','element', 'list'))
  
}

#' @title Overflow menu element
#' @description This is like a cross between a button and a select menu when a 
#' user clicks on this overflow button, they will be presented with a list of 
#' options to choose from. Unlike the select menu, there is no typeahead field, 
#' and the button always appears with an ellipsis ("…") rather than 
#' customisable text.
#' @param id character, An identifier for the action triggered when a menu 
#' option is selected.
#' @param options An list of block_option objects.
#' @param confirm A confirm object that defines an optional confirmation 
#' dialog that appears after a menu item is selected.
#' @return block menu class 
#' @details Works with block types: *Section*, *Actions*
#' @examples 
#' section_block(
#'  id = 'section 890',
#'  text = block_text('This is a section block with an overflow menu.'),
#'  accessory =  overflow_menu(
#'       id = 'overflow',
#'       options = as.blocks(
#'         lapply(sprintf('value-%d',1:4),block_option,
#'         text = '*this is plain_text text*')
#'        )
#'     )
#' )
#' @rdname overflow_menu
#' @family elements
#' @export 
#' @importFrom checkmate check_class
overflow_menu <- function(id, options, confirm = NULL){
  
  checkmate::check_class(options,classes = 'block_option')
  
  if(!is.null(confirm))
    checkmate::expect_class(confirm,'block_confirm')
  
  payload <- list(
    type = 'overflow',
    action_id = id,
    options = options,
    confirm = confirm
  )
  
  structure(compact(payload),class = c('block','menu', 'list'))
  
}

#' @title Select menu element
#' @description A select menu, just as with a standard HTML select tag, 
#' creates a drop down menu with a list of options for a user to choose. 
#' The select menu also includes type-ahead functionality, 
#' where a user can type a part or all of an option string to filter the list.
#' @param id character, an identifier for the action triggered when a menu option is selected.
#' @param placeholder character, defines the placeholder text shown on the menu. 
#' @param options list, a list of option objects. 
#' @param option_groups a list of option group objects. Default: NULL
#' @param initial_option a single option that exactly matches one of the 
#' options within options or option_groups, Default: NULL
#' @param confirm A confirm object that defines an optional 
#' confirmation dialog that appears after a menu item is selected. Default: NULL
#' @param max_select_items integer, Specifies the maximum number of items that can be selected in the menu, Default: NULL
#' @return block menu class
#' @details 
#' 
#' Works with block types: *Section*, *Actions*, *Input*
#' 
#' If `options` is specified, then `option_groups` should not be and vice versa.
#' 
#' @examples 
#' section_block(
#' id = 'section678',
#' text = 'Pick an item from the dropdown list',
#' accessory = select_menu(
#'  id = 'text1234',
#'  placeholder = 'Select an item',
#'  options = as.blocks(
#'    lapply(sprintf('value-%d',1:4),block_option,
#'      text = '*this is plain_text text*')
#'    )
#'  )
#' )
#' @rdname select_menu
#' @family elements
#' @export 
#' @importFrom checkmate check_class
select_menu <- function(id, placeholder, options, option_groups = NULL, initial_option = NULL, confirm = NULL, max_select_items = NULL){
  
  if(!is.null(options))
    checkmate::check_class(options,classes = 'block_option')
  
  if(!is.null(option_groups))
    checkmate::check_class(option_groups,classes = 'block_option')
  
  if(!is.null(initial_option))
    checkmate::check_class(initial_option,classes = 'block_option')
 
  if(!is.null(confirm))
    checkmate::expect_class(confirm,'block_confirm')
   
  max_select_items <- force_integer(max_select_items)
  
  type <- 'static_select'
  
  if(!is.null(max_select_items))
    type <- 'multi_static_select'

  
  payload <- list(
    type = type,
    action_id = id,
    placeholder = block_text(placeholder,type='plain_text'),
    options = options,
    option_groups = option_groups,
    initial_option = initial_option,
    confirm = confirm,
    max_select_items = max_select_items
  )
  
  structure(compact(payload),class = c('block','menu', 'list'))
  
}

#' @title Type specific select menu lists
#' @description menu lists that populate with team specific elements, such as 
#' users, conversations and channels
#' @param id character, an identifier for the action triggered 
#' when a menu option is selected. 
#' @param type type of elements to populate,
#'  Default: c("users", "conversations", "channels")
#' @param placeholder character, placeholder text shown on the menu.
#' @param initial initial value of the menu, must by an slack ID, Default: NULL
#' @param confirm A confirm object that defines an optional 
#' confirmation dialog that appears after a menu item is selected. Default: NULL
#' @param max_select_items integer, Specifies the maximum number of items that can be selected in the menu, Default: NULL
#' @return block menu class
#' @details Works with block types: *Section*, *Actions*, *Input*
#' @rdname select_type_menu
#' @family elements
#' @export 
select_type_menu <- function(id, type = c('users','conversations','channels'), placeholder, initial = NULL, confirm = NULL, max_select_items = NULL){
  
  type_arg <- match.arg(type, c('users','conversations','channels'))
  
  if(!is.null(confirm))
    checkmate::expect_class(confirm,'block_confirm')
  
  max_select_items <- force_integer(max_select_items)
  
  type <- sprintf('%s_select',type_arg)
  
  if(!is.null(max_select_items))
    type <- sprintf('multi_%s_select',type_arg)
  
  payload <- list(
    type = type,
    placeholder = block_text(text = placeholder,type = 'plain_text'),
    action_id = id,
    confirm = confirm,
    max_select_items = max_select_items
  )
  
  payload[[sprintf('initial_%s',gsub('s$','',type_arg))]] <- initial
  
  structure(compact(payload),class = c('block','menu', 'list'))
  
}
