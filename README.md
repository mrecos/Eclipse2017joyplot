# Eclispe 2017 Joyplot
This repo contains the code and data for creating a "Joy Division" style joyplot of the elevation profiles along the 2017 Eclipse Path of Totality.  The aesthetic of the joyplot is meant to mimic the amazing design by [Peter Saville](https://en.wikipedia.org/wiki/Peter_Saville_(graphic_designer)) for the Joy Division's [Unknown Pleasure](https://en.wikipedia.org/wiki/Unknown_Pleasures) (1979) album cover.

Plots of this style have been around for quite some time as it is a good way to show data that is continuous in the X axis, discreet along the Y axis, but correlated across both axis.  Recently, this style of plot was made populate by [@ClausWilke](https://twitter.com/ClausWilke) with the [`ggjoy`](https://github.com/clauswilke/ggjoy) package for the R statistical programing language. The `ggjoy` package functions as an add-on to the very popular [`ggplot2`](http://ggplot2.org/) plotting and visualization package in R.

The other bit of heavy lifting that makes this plot is the extraction of elevation data with the [`elevatr`](https://github.com/usepa/elevatr) package by the US Department of Environmental Protection; maintained by Jeffrey Hollister. This package provides a wrapper to loop over elevation points to extract data from different sources. It is a great package that makes life much easier!

So with the heavy lifting from `elevatr` and `ggjoy` the rest of the code is simply stylizing the plot in `ggplot2`. I also provide a csv of the extracted elevation points so that you don't have to go through that step (took about an hour for 10k coordinates).

![Eclispe2017joyplot](https://github.com/mrecos/Eclipse2017joyplot/blob/master/images/readme_plot.png)

