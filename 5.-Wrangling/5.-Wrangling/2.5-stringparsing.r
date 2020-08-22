url <- "https://en.wikipedia.org/w/index.php?title=Gun_violence_in_the_United_States_by_state&direction=prev&oldid=810166167"
murders_raw <- read_html(url) %>%
  html_nodes("table")  %>% html_table() %>% .[[1]] %>%
  setNames(c("state", "population", "total", "murder_rate"))

head(murders_raw)

s <- '10"'    # correct
# cat shows what the string actually looks like inside R
cat(s)

s <- "5'"
cat(s)

s <- '5\'10"'    # correct
cat(s)
s <- "5'10\""    # correct
cat(s)

# direct conversion to numeric fails because of commas
murders_raw$population[1:3]
as.numeric(murders_raw$population[1:3])

library(stringr)
# detect whether there are commas
commas <- function(x) any(str_detect(x, ","))
murders_raw %>% summarize_all(funs(commas))

commas(murders_raw$state)

# replace commas with the empty string and convert to numeric
test_1 <- str_replace_all(murders_raw$population, ",", "")
test_1 <- as.numeric(test_1)

# parse_number also removes commas and converts to numeric
test_2 <- parse_number(murders_raw$population)
identical(test_1, test_2)

murders_new <- murders_raw %>% mutate_at(2:3, parse_number)

#continue
