
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

`slackblocks` is a part of `slackverse`

|                                                                                                                                 |                                                                                                                                     |                                                                                                                                    |
| :-----------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------: |
|                                                                                                                                 | slackcalls<br>[![](https://github.com/yonicd/slackcalls/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackcalls)<br>↙️⬇️↘️ |                                                                                                                                    |
| slackthreads<br>[![](https://github.com/yonicd/slackthreads/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackthreads) |  slackteams<br>[![](https://github.com/yonicd/slackteams/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackteams)<br>⬅️➡️  | slackblocks<br>[![](https://github.com/yonicd/slackblocks/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackblocks)<br>⬇️ |
|                                                                                                                                 |                                                                                                                                     |    slackreprex<br>[![](https://github.com/yonicd/slackreprex/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackreprex)    |

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
slackteams::load_team_dcf(team = 'r4ds')
slackteams::activate_team('r4ds')
```

``` r
post_block(b,channel = 'yonicd')
```

<img src="man/figures/sections.png" width="100%" />
