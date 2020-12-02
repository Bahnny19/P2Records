library(ggplot2)
library(caret)

songs.df <- read.csv("C:/Users/Bahnny/Desktop/MSIS Docs/Data analytics 510/spotify dataset/data.csv")
genre.df <- read.csv("C:/Users/Bahnny/Desktop/MSIS Docs/Data analytics 510/spotify dataset/data_by_genres.csv")

#ARTIST dataset
#remove records with non-latin words in artists column
artists.df <- read.csv("C:/Users/Bahnny/Desktop/MSIS Docs/Data analytics 510/spotify dataset/data_w_genres.csv")
artists.df <- na.omit(artists.df)
View(artists.df)

artists.df <- artists.df[1:27261,]

#change duration column from ms to sec
artists.df$duration_ms <- artists.df$duration_ms/1000.0
colnames(artists.df)[which(names(artists.df) == "duration_ms")] <- "Avg song duration (sec)"

#viz
ggplot(data=artists.df)+ geom_point(aes(x=danceability, y=energy, color = loudness))
ggplot(data=artists.df)+ geom_point(aes(x=danceability, y=energy, color = tempo))
ggplot(data=artists.df)+ geom_point(aes(x=popularity, y=duration_ms, color = energy))
ggplot(data=artists.df)+ geom_point(aes(x=speechiness, y=instrumentalness))

#YEAR Dataset
year.df <- read.csv("C:/Users/Bahnny/Desktop/MSIS Docs/Data analytics 510/spotify dataset/data_by_year.csv")
year.df <- na.omit(year.df)

#change duration column from ms to sec
year.df$duration_ms <- year.df$duration_ms/1000.0
colnames(year.df)[which(names(year.df) == "duration_ms")] <- "Avg song duration (sec)"

View(year.df)

#viz
ggplot(data=year.df)+ geom_point(aes(x=year, y=popularity))
ggplot(data=year.df)+ geom_point(aes(x=year, y=energy))
ggplot(data=year.df)+ geom_point(aes(x=year, y=danceability, color = tempo))

#Write pre-processed files
write.csv(artists.df,"C:\\Users\\Bahnny\\Desktop\\MSIS Docs\\Data analytics 510\\P2Records\\artists.csv", row.names = FALSE)
write.csv(year.df,"C:\\Users\\Bahnny\\Desktop\\MSIS Docs\\Data analytics 510\\P2Records\\year.csv", row.names = FALSE)
