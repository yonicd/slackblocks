
<!-- README.md is generated from README.Rmd. Please edit that file -->

# slackblocks

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
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
```

``` r
slackblocks::block_text('my text')
#> {
#>   "type": "plain-text",
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

## Reprex

``` r
slackteams::load_team_dcf(team = 'r4ds')
slackteams::activate_team('r4ds')

slackblocks::slack_reprex({
x <- 10
hist(runif(x))
},
text = 'i have a question about this plot',
channel = 'yonicd')
```