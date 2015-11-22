## Practical Machine Learning
## Classification Project

library(caret)
library(ggplot2)

## parallelize
library(doParallel)
numCores = detectCores() - 1 ## save one core for other stuff
registerDoParallel(makeCluster(numCores))

rawdata = read.csv("pml/pml-training.csv", header = TRUE)
predData = read.csv("pml/pml-testing.csv", header = TRUE)


## partition the raw data into training and test sets
inTrain = createDataPartition(y = rawdata$classe,
                              p = 0.7,
                              list = FALSE)
training = rawdata[inTrain,]
testing = rawdata[-inTrain,]

cartFit = train(training[,8:159], training[,160], method="knn")



## test with iris
data(iris)
TrainData <- iris[,1:4]
TrainClasses <- iris[,5]

knnFit1 <- train(TrainData, TrainClasses,
                 method = "knn",
                 preProcess = c("center", "scale"),
                 tuneLength = 10,
                 trControl = trainControl(method = "cv"))

