% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/elements.R
\name{datepicker_element}
\alias{datepicker_element}
\title{Date picker element}
\usage{
datepicker_element(id, placeholder = NULL, initial_date = NULL, confirm = NULL)
}
\arguments{
\item{id}{character, an identifier for the action triggered
when a menu option is selected.}

\item{placeholder}{character, placeholder text shown on the datepicker. Default: NULL}

\item{initial_date}{Date, The initial date that is
selected when the element is loaded.
This should be in the \link[base:strptime]{strftime}
format '\%Y-\%m-\%d'. Default: NULL}

\item{confirm}{block_confirm, defines an optional
confirmation dialog after the button is clicked. Default: NULL}
}
\value{
block element class
}
\description{
An element which lets users easily
select a date from a calendar style UI.
}
\details{
\itemize{
\item Works with block types: \emph{Section}, \emph{Actions}, \emph{Input}
}
}
\examples{
datepicker_element(id = 'datepicker123',initial_date = "1990-04-28", 
placeholder = 'Select a date')
}
\seealso{
\link[parsedate:parse_date]{parse_date}

Other elements: 
\code{\link{button_element}()},
\code{\link{checkbox_element}()},
\code{\link{image_element}()},
\code{\link{overflow_menu}()},
\code{\link{plaintext_element}()},
\code{\link{radiobuttons_element}()},
\code{\link{select_menu}()},
\code{\link{select_type_menu}()}
}
\concept{elements}
