#modelling
artists.df <- read.csv("C:/Users/Bahnny/Desktop/MSIS Docs/Data analytics 510/P2Records/artists.csv")
library(ggplot2)
ggplot(data=artists.df)+ geom_point(aes(x=acousticness, y=popularity, color = energy))


data  = artists.df[, c(2,3,4,6,7,8,9,10,11,12,13,14,15)]

data$popularity <- normalize(data$popularity)
data$popularity <- ifelse(data$popularity > 0.5, 1, 0)
data$popularity = factor(data$popularity)
data$key = factor(data$key)
data$mode = factor(data$mode)

normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}



set.seed(11)
train.index <- sample(1:nrow(data), nrow(data)*0.6)
train.df <- data[train.index, ]
valid.df <- data[-train.index, ]

#glm
logit.reg <- glm(popularity ~ ., data = data, family = "binomial")
summary(logit.reg)

logit.reg.pred <- predict(logit.reg, valid.df,  type = "response")
logit.reg.pred

pred <- ifelse(logit.reg.pred > 0.30, 1, 0)
pred

library(caret)
confusionMatrix(factor(pred), factor(valid.df$popularity), positive = "1")

library(pROC)
r <- roc(valid.df$popularity, logit.reg.pred)
plot.roc(r)
coords(r, x = "best", transpose = FALSE)
coords(r, x = c(0.1, 0.2, 0.5, 0.75),  transpose = FALSE)


#predict rules for a hit artist --------------------------------------
library(rpart)
library(rpart.plot)

set.seed(11)
train.index <- sample(1:nrow(data), nrow(data)*0.1)
train.df <- data[train.index, ]
valid.df <- data[-train.index, ]

default.ct <- rpart(popularity ~ . , data = train.df, method = "class")
prp(default.ct)

default.ct.point.pred <- predict(default.ct, valid.df, type = "class")
library(caret)

confusionMatrix(default.ct.point.pred, factor(valid.df$popularity))

