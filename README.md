
<!-- README.md is generated from README.Rmd. Please edit that file -->

# slackblocks

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-win build
status](https://github.com/yonicd/slackblocks/workflows/R-win/badge.svg)](https://github.com/yonicd/slackblocks)
[![R-mac build
status](https://github.com/yonicd/slackblocks/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackblocks)
[![R-linux build
status](https://github.com/yonicd/slackblocks/workflows/R-linux/badge.svg)](https://github.com/yonicd/slackblocks)
[![Covrpage
Summary](https://img.shields.io/badge/covrpage-Last_Build_2020_02_06-brightgreen.svg)](http://tinyurl.com/tf2xf4d)
<!-- badges: end -->

The goal of slackblocks is to build Slack block elements in `R`.

## Installation

``` r
# install.packages("remotes")
remotes::install_github("yonicd/slackblocks")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(slackblocks)
library(magrittr)
```

``` r
slackblocks::block_text('my text')
#> {
#>   "type": "mrkdwn",
#>   "text": "my text"
#> }
```

``` r
slackblocks::block_image('url_to_image')
#> {
#>   "type": "image",
#>   "image_url": "url_to_image",
#>   "alt_text": "image"
#> }
```

``` r
(b <- block_section(
  text = block_text(
    text = 'A message *with some bold text* and _some italicized text_.'),
  fields = list(
    block_text('*Priority*'),
    block_text('*Type*'),
    block_text('High'),
    block_text(':heavy_check_mark:')
    )
  ))
#> {
#>   "type": "section",
#>   "text": {
#>     "type": "mrkdwn",
#>     "text": "A message *with some bold text* and _some italicized text_."
#>   },
#>   "fields": [
#>     {
#>       "type": "mrkdwn",
#>       "text": "*Priority*"
#>     },
#>     {
#>       "type": "mrkdwn",
#>       "text": "*Type*"
#>     },
#>     {
#>       "type": "mrkdwn",
#>       "text": "High"
#>     },
#>     {
#>       "type": "mrkdwn",
#>       "text": ":heavy_check_mark:"
#>     }
#>   ]
#> }
```

## Posting Blocks to Slack

``` r
post_block(b,channel = 'yonicd')
```

<img src="man/figures/sections.png" width="100%" />

## Reprex

``` r
slackteams::load_team_dcf(team = 'r4ds')
slackteams::activate_team('r4ds')
```

``` r
slackblocks::slack_reprex({
  x <- 10
  hist(runif(x))
  hist(runif(2*y))
},
text = 'My question is ...) ',
channel = 'yonicd')
```

<img src="man/figures/plot_example.png" width="100%" />

## Reprex Under the Hood

### Convert reprex `gh` output to slack blocks

``` r
reprex_block <- reprex::reprex({
x <- 10
hist(runif(x))
hist(runif(2*y))
},
venue = 'gh', advertise = FALSE, show = FALSE)%>%
reprex_to_blocks()
#> Rendering reprex...
```

    #> [
    #>   {
    #>     "type": "section",
    #>     "text": {
    #>       "type": "mrkdwn",
    #>       "text": "```\nx <- 10\nhist(runif(x))\n```"
    #>     }
    #>   },
    #>   {
    #>     "type": "image",
    #>     "image_url": "https://i.imgur.com/T3SAbjA.png",
    #>     "alt_text": "image"
    #>   },
    #>   {
    #>     "type": "section",
    #>     "text": {
    #>       "type": "mrkdwn",
    #>       "text": "```\nhist(runif(2*y))\n#> Error in runif(2 * y): object 'y' not found\n```"
    #>     }
    #>   }
    #> ]

### post the blocks

``` r
reprex_block%>%
  post_block(
    channel = 'yonicd'
  )
```

### Post with a question and attach the reprex into a thread.

``` r
q_txt <- block_text(
  text = 'My Question is ...'
)
```

    #> {
    #>   "type": "mrkdwn",
    #>   "text": "My Question is ..."
    #> }

``` r

q_txt%>%
post_block(
  channel = 'yonicd'
    )%>%
post_thread(
  block = reprex_block
)
```
