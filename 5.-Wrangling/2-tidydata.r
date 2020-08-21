library(tidyverse)
library(dslabs)
data (gapminder)

# import and inspect example of original Gapminder data in wide format
path <- system.file("extdata", package="dslabs")
filename <- file.path(path,  "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)

wide_data

select(wide_data, country, `1960`:`1967`)

