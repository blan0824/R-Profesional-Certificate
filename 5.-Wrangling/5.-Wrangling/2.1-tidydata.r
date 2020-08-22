library(tidyverse)
library(dslabs)
data (gapminder)

# import and inspect example of original Gapminder data in wide format
path <- system.file("extdata", package="dslabs")
filename <- file.path(path,  "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)

wide_data

select(wide_data, country, `1960`:`1967`)

new_tidy_data <- wide_data %>%
  gather(year, fertility, "1960":"2015")

head(new_tidy_data)

new_tidy_data<- wide_data %>%
  gather(year, fertility, -country, convert = TRUE)

class(new_tidy_data)

new_tidy_data %>% 
  ggplot(aes(year,fertility, color = country)) + geom_point()

new_wide_data <- new_tidy_data %>% spread(year, fertility) 
select(new_wide_data,country, "2000":"2013")

#Separeta and unite
path <- system.file("extdata",package = "dslabs")
filename <- file.path(path, "life-expectancy-and-fertility-two-countries-example.csv")
raw_dat <- read_csv(filename)
select(raw_dat,1:5)

#Gather all columns except country

dat <- raw_dat %>% gather(key, value, -country)
head(dat)
dat$key[1:5]

dat %>% separate (key, c("year", "variable1"), sep = "_")
dat %>% separate (key, c("year", "variable1"), sep = "_", extra = "merge")

dat %>% separate (key, c("year", "variable1"), sep = "_", extra = "merge") %>%
  spread(variable1, value)


#unite
dat %>%
  separate(key, c("year", "variable1", "variable2"), fill = "right") %>%
  unite(variable_name, variable1, variable2, sep = "_") %>% 
  spread(variable_name, value) %>% rename(fertility = fertility_NA)

head(murders)
murders %>% gather(key = "var", value = "people", population:total ) %>%
  spread(var,people)



key <- c("allen_height", "allen_hand_length", "allen_wingspan", "bamba_height", "bamba_hand_length", "bamba_wingspan")
value <- c(75,8.25,79.25,83.25,9.75,94)

stats <- data.frame(key,value)
stats %>% separate(col = key, into = c("player", "variable_name"), sep = "_" , extra = "merge") %>%
  spread(key = variable_name, value = value)
 

stats %>% separate(col = key, into = c("player", "variable_name1", "variable_name2"), sep = "_" , fill = "right") %>%
  unite(col = variable_name, variable_name1, variable_name2, sep = "_") %>% 
  spread(key = variable_name, value = value)

stats %>%
  separate(col = key, into = c("player", "variable_name"), sep = "_") %>% 
  spread(key = variable_name, value = value)

co2
co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>%
  setNames(1:12) %>% mutate(year = as.character(1959:1997))

co2_tidy <- co2_wide %>% gather(month,co2, -year)

co2_tidy %>% ggplot(aes(as.numeric(month), co2, color = year)) + geom_line()


data(admissions)
dat <- admissions %>% select(-applicants)
dat %>% spread(gender,admitted)

tmp <- gather(admissions, key, value, admitted:applicants)

tmp2 <- unite(tmp, column_name, c(key,gender))

tmp2 %>% spread(column_name, value)