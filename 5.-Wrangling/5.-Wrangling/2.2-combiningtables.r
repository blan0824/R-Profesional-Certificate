library(tidyverse)
library(ggrepel)
library(dslabs)
ds_theme_set()

#Import US election result data
identical(results_us_election_2016$state, murders$state)

tab <- left_join(murders, results_us_election_2016, by = "state")

tab %>% ggplot(aes(population/10^6, electoral_votes, label =abb)) +
  geom_point() + geom_text_repel() + 
  scale_x_continuous(trans = "log2") +
  scale_y_continuous(trans = "log2") + 
  geom_smooth(method = "lm", se = FALSE)

# make two smaller tables to demonstrate joins
tab1 <- slice(murders, 1:6) %>% select(state, population)
tab1
tab2 <- slice(results_us_election_2016, c(1:3, 5, 7:8)) %>% select(state, electoral_votes)
tab2


# experiment with different joins
left_join(tab1,tab2)
tab1 %>% left_join(tab2)
tab1 %>% right_join(tab2)
inner_join(tab1, tab2)
full_join(tab1,tab2)
semi_join(tab1, tab2)
anti_join(tab1, tab2)

bind_cols(a = 1:3, b= 4:6)

tab1 <- tab[,1:3]
tab2 <- tab[,4:6]
tab3<- tab[7:9]

new_tab <- bind_cols(tab1, tab2, tab3)
new_tab


tab1 <- tab[1:3,]
tab2 <- tab[4:6,]


bind_rows(tab1, tab2)


#Set Operators
tab1 <- tab[1:5,]
tab2 <- tab[3:7,]

#Intersect
intersect(tab1,tab2)

#Union
union(tab1,tab2)

#setdiff
setdiff(1:10, 6:15)
setdiff(6:15, 1:10)
setdiff(tab1, tab2)

#setequal 
setequal(1:5, 1:6)
setequal(1:5, 5:1)
setequal(tab1, tab2)


#Assessment 
tab1 <- murders %>% slice(c(1:3, 8:9)) %>% select(state,population)
tab1
dim(tab1)
tab2 <- results_us_election_2016 %>% arrange(state) %>% slice(c(1:3,5:7)) %>% select(state,electoral_votes)
tab2
dim(tab2)

dat <- left_join(tab1, tab2, by = "state")
inner_join(tab1, tab2, by = "state")


df1 <- data.frame(x = c("a", "b"), y = c("a", "a"))
df2 <- data.frame(x = c("a", "a"), y = c("a", "b"))
setdiff(df1,df2)
setdiff(df2,df1) #The setdiff() command returns rows in df1 but not df2

library(Lahman)
Batting
top <- Batting %>% filter(yearID == 2016) %>% 
  arrange(desc(HR)) %>%
  slice(1:10) 

top %>% as_tibble()

Master %>% as_tibble()


top_names <- top %>% left_join(Master) %>% select(playerID, nameFirst, nameLast,HR) 


top_salary <-  Salaries %>% filter(yearID == 2016) %>% right_join(top_names  ) %>% select(nameFirst, nameLast, teamID, HR, salary)


#Inspect the AwardsPlayers table. Filter awards to include only the year 2016.
awards <- AwardsPlayers %>% filter(yearID == 2016) %>% 
right_join(top) %>% group_by(playerID) %>% summarize(n=n())

#How many players from the top 10 home run hitters won at least one award in 2016?
awards_other <- awards %>% filter(!playerID %in% top$playerID) %>% group_by(playerID) %>% summarise(n = n())
dim(awards_other)


awards_total <- AwardsPlayers %>% filter(yearID == 2016) %>% group_by(playerID) %>% summarize(n = n())
dim(awards_total)

#Exam results using set operators
Awards_2016 <- AwardsPlayers %>% filter(yearID == 2016)
length(intersect(Awards_2016$playerID, top_names$playerID))

length(setdiff(Awards_2016$playerID, top_names$playerID))