library(rvest)
url <- ("https://en.wikipedia.org/wiki/Gun_violence_in_the_United_States_by_state")
h <- read_html(url)
class(h)
h

tab <- h %>% html_nodes("table")
tab <- tab[[2]]
View(tab)
tab <- tab %>% html_table
tab
class(tab)

tab <- tab %>% setNames(c("state", "population", "total", "murders", 
                          "gun murders", "gun_ownership", "total_rate",
                          "murder_rate", "gun_murder_rate"))


#Load the following web page, which contains information about Major League Baseball payrolls, into R: 
#https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm External link

library(rvest)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)

#We learned that tables in html are associated with the table node.  Use the html_nodes() 
#function and the table node type to extract the first table. Store it in an object nodes:
nodes <- h %>% html_nodes("table")
nodes
length(nodes)
#The html_nodes() function returns a list of objects of class xml_node. We can see the content 
#of each one using, for example, the html_text() function. You can see the content for an arbitrarily 
#picked component like this:

html_text(nodes[[8]])

#If the content of this object is an html table, we can use the html_table() function 
#to convert it to a data frame:
html_table(nodes[[8]])

class(nodes)

nodes2<- html_table(nodes[[2]])
nodes3<- html_table(nodes[[3]])
nodes4<- html_table(nodes[[4]])

nodes19 <-  html_table(nodes[[19]])
nodes20 <-  html_table(nodes[[20]])
nodes21 <- html_table(nodes[[21]])

class(nodes19)
class(nodes20)
  class(nodes21)
  

tab1 <- html_table(nodes[[10]])   
tab2 <- html_table(nodes[[19]])    

tab1 <- tab1[-1,-1]
colnames(tab1) <- c("Team", "Payroll", "Average")
rownames(tab1) <- 1:length(tab1$Team)
tab1

colnames(tab2) <- tab2[1,]
tab2 <- tab2[-1,]
tab2
rownames(tab2) <- 1:length(tab2$Team)
tab2
full_join(tab1, tab2, by = "Team")



url2 <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
h <- read_html(url2)
tab2<- h %>% html_nodes("table") 
length(tab2)
html_table(tab2[[2]])
html_table(tab2[[3]])
table4 <- html_table(tab2[[4]])

table5 <- html_table(tab2[[5]], fill = TRUE)
fix(table5)
dim(table5)
