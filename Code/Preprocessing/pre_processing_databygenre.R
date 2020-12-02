music_genre <- read.csv("data_by_genres.csv")

#removing nulls
music_genre[is.na(music_genre)] <- 0

#combining different terms in a genere
library(stringr)
music_genre$genres <- str_replace_all(music_genre$genres, " ", "_")


#converting duration_ms to seconds and renaming to Avg song duration (sec)
music_genre$"Avg song duration (sec)" <- music_genre$duration_ms/1000
music_genre <- subset(music_genre, select = -c(duration_ms))


#final check
View(music_genre)

#writing dataset to a file
write.csv(music_genre,"C:\\Users\\nmala\\P2Records\\Datasets\\processed_data_by_genres.csv", row.names = FALSE)
