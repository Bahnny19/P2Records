music.df <- read.csv("data.csv")
dim(music.df) #170653 rows
summary(music.df)

#viz
small.index <- sample(1:nrow(music), nrow(music)*0.1)
sample_music <- music[small.index, ]
ggplot(data=sample_music)+ geom_point(aes(x=valence, y=popularity))
ggplot(data=sample_music)+ geom_point(aes(x=year, y=popularity))
ggplot(data=sample_music)+ geom_point(aes(x=acousticness, y=popularity))
ggplot(data=sample_music)+ geom_point(aes(x=danceability, y=popularity))
ggplot(data=sample_music)+ geom_point(aes(x=energy, y=popularity))
ggplot(data=sample_music)+ geom_point(aes(x=loudness, y=popularity))

#removing nulls
music.df[is.na(music.df)] <- 0
music.df <- music.df[!(music.df$name==""), ]

#filtering out rows with incomplete date
temp.df <- grep("^[0-9]*?-[0-9]*?-[0-9]*?", music.df$release_date, value=TRUE, ignore.case=T, perl=T) #extracting all complete
date_index <- which(music.df$release_date %in% temp.df) #finding indexed of the dates extracted in the last line
processed.df <- music.df[date_index, ] #filtering the dataset using the indexes obtained
dim(processed.df) #118188 rows

#Extracting month from release_date and adding the column as release_month
library(lubridate)
month <- month(as.POSIXlt(processed.df$release_date, format="%Y-%m-%d"))
processed.df$release_month <- month

#removing special characters values from song names
library(stringr)
processed.df$name <- gsub("[^[:alpha:]]","", processed.df$name)
#contains(processed.df$name, "Î")
#filter(processed.df, !grepl("Î", processed.df$name))


#combining different terms in song name
processed.df$name <- str_replace_all(processed.df$name, " ", "")

#Removing special characters from artists
processed.df$artists <- gsub("\\[|\\]", "", processed.df$artists)
processed.df$artists <- gsub("\\'|\\'", "", processed.df$artists)
processed.df$artists <- gsub("[^[:alnum:]\\,]","", processed.df$artists)

#Removing id as it does not have any analytical value
processed.df <- subset(processed.df, select = -c(id))

#Final check fore writing to file
View(processed.df)

write.csv(processed.df,"C:\\Users\\nmala\\P2Records\\Datasets\\processed_music.csv", row.names = FALSE)

