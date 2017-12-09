library(knitr)
opts_chunk$set(cache = TRUE, message=FALSE, warning=FALSE)
library(AppliedPredictiveModeling)
library(Amelia)
library(doParallel)
library(missForest)
library(cwhmisc)
library(MASS)
library(forecast)
library(tidyverse)
library(pls)
library(caret)
library(data.table)
library(psych)
library(mlbench)
library(nnet)
library(earth)
library(kernlab)
library(Metrics)
library(party)
library(AppliedPredictiveModeling)
library(Amelia)
library(doParallel)
library(missForest)
library(cwhmisc)
library(MASS)
library(forecast)
library(tidyverse)
library(pls)
library(caret)
library(data.table)
library(psych)
library(mlbench)
library(nnet)
library(earth)
library(kernlab)
library(Metrics)
library(party)
library(AppliedPredictiveModeling)
data("ChemicalManufacturingProcess")
library(Amelia)
missmap(ChemicalManufacturingProcess)
library(doParallel)
library(missForest)

set.seed(1234)

registerDoParallel(cores=3)
chem.imput <- missForest(ChemicalManufacturingProcess, ntree = 100, parallelize = "forests")$ximp
data.set <- list(org.data.set = chem.imput)
library(psych)

multi.hist(data.set$org.data.set[1:8])

multi.hist(data.set$org.data.set[9:16])

multi.hist(data.set$org.data.set[17:24])

multi.hist(data.set$org.data.set[25:32])
variables.to.transform <- c("BiologicalMaterial04", "ManufacturingProcess01",
                            "ManufacturingProcess02","ManufacturingProcess03",
                            "ManufacturingProcess06", "ManufacturingProcess07",
                            "ManufacturingProcess08","ManufacturingProcess12",
                            "ManufacturingProcess16","ManufacturingProcess18") 

results <- NULL
for (i in 1:length(variables.to.transform)){
  results[[i]] <- list(variable = variables.to.transform[[i]],
                       lambda = BoxCox.lambda(data.set$org.data.set[,variables.to.transform[[i]]]))}
results
trans.data.set <- data.set$org.data.set %>% 
                    mutate(BiologicalMaterial04.boxcoxtrans = 
                             BoxCox(BiologicalMaterial04, -0.99992424816297),
                           ManufacturingProcess01.boxcoxtrans = 
                             BoxCox(ManufacturingProcess01, 1.99995900720725),
                           ManufacturingProcess02.boxcoxtrans = 
                             BoxCox(ManufacturingProcess02, 1.99995900720725),
                           ManufacturingProcess03.boxcoxtrans = 
                             BoxCox(ManufacturingProcess03, -0.99992424816297),
                           ManufacturingProcess06.boxcoxtrans = 
                             BoxCox(ManufacturingProcess06, -0.99992424816297),
                           ManufacturingProcess07.boxcoxtrans = 
                             BoxCox(ManufacturingProcess07,-0.99992424816297),
                           ManufacturingProcess08.boxcoxtrans = 
                             BoxCox(ManufacturingProcess08, 1.99992424816297),
                           ManufacturingProcess12.boxcoxtrans = 
                             BoxCox(ManufacturingProcess12, 0.0000410225926326142),
                           ManufacturingProcess16.boxcoxtrans = 
                             BoxCox(ManufacturingProcess16, 1.99995900720725),
                           ManufacturingProcess18.boxcoxtrans = 
                             BoxCox(ManufacturingProcess18, 1.99995900720725))
set.seed(123)
data.set <- c(data.set, list(trans.data.set = trans.data.set))  %>% 
            c(., list(train.test.split = floor(0.75 * nrow(chem.imput)))) %>% 
            c(., train.index = list(sample(seq_len(nrow(chem.imput)), size = .$train.test.split))) %>%
            c(., train = list(as.data.frame(trans.data.set[.$train.index,])), test = list(as.data.frame(trans.data.set[-.$train.index,])))
library(pls)
chem.plsFit <- plsr(Yield ~ ., data =  data.set$train, validation = "CV")
validationplot(chem.plsFit, val.type="RMSEP")
pls.RMSEP <- RMSEP(chem.plsFit, estimate="CV") 
plot(pls.RMSEP, main="RMSEP PLS Solubility", xlab="components")
min_comp <- which.min(pls.RMSEP$val)
points(min_comp, min(pls.RMSEP$val), pch=1, col="red", cex=1.5)
chem.plsPredict.train <-  predict(chem.plsFit, data = data.set$train, ncomp = min_comp)
pls.eval <- data.frame(obs = data.set$train[,1], pred = chem.plsPredict.train[,1,1])
defaultSummary(pls.eval)
chem.plsPredict <- predict(chem.plsFit, data = data.set$test, ncomp = min_comp)
pls.eval <- data.frame(obs = data.set$test[,1], pred = chem.plsPredict[,1,1])
defaultSummary(pls.eval)
library(data.table)
dt <- setDT(varImp(chem.plsFit), keep.rownames = TRUE)[]
options(scipen=99)
dt[order(-Overall)]
data.set$org.data.set %>% dplyr::select(Yield, ManufacturingProcess40) %>% cor() %>% .[2]
data.set$org.data.set %>% dplyr::select(Yield, BiologicalMaterial12) %>% cor() %>% .[2]
set.seed(1234)
trainingData <- mlbench.friedman1(200, sd = 1)
trainingData$x <- data.frame(trainingData$x)
#featurePlot(trainingData$x, trainingData$y)
testData <- mlbench.friedman1(5000, sd = 1)
testData$x <- data.frame(testData$x)
nnetFit <- nnet(testData$x, testData$y,
                size = 5,
                decay = .01,
                maxit = 500,
                MaxNWts = 5 * (ncol(testData$x) + 1) + 5 + 1)

results <- predict(nnetFit, trainingData$x) %>% cbind(.,trainingData$y) %>% as.data.frame()
colnames(results) <- c("predicted", "actual")
rmse(results$actual, results$predicted)
marsFit <- earth(testData$x, testData$y)
results <- predict(marsFit, trainingData$x) %>% cbind(.,trainingData$y) %>% as.data.frame()
colnames(results) <- c("predicted", "actual")
rmse(results$actual, results$predicted)
## #At one point I got the error optimismBoot not found, installing caret from github resolved the issue.
## knnTune <- train(testData$x, testData$y,
##                 method = "knn",
##                 preProc = c("center", "scale"),
##                 trace = FALSE)
## results <- predict(knnTune, trainingData$x) %>% cbind(.,trainingData$y) %>% as.data.frame()
## colnames(results) <- c("predicted", "actual")
## rmse(results$actual, results$predicted)
varImp(marsFit)
library(AppliedPredictiveModeling)
data("ChemicalManufacturingProcess")
library(missForest)

set.seed(1234)

registerDoParallel(cores=3)
chem.imput <- missForest(ChemicalManufacturingProcess, ntree = 100)$ximp
data.set <- list(org.data.set = chem.imput)
trans.data.set <- data.set$org.data.set %>% 
                    mutate(BiologicalMaterial04.boxcoxtrans = 
                             BoxCox(BiologicalMaterial04, -0.99992424816297),
                           ManufacturingProcess01.boxcoxtrans = 
                             BoxCox(ManufacturingProcess01, 1.99995900720725),
                           ManufacturingProcess02.boxcoxtrans = 
                             BoxCox(ManufacturingProcess02, 1.99995900720725),
                           ManufacturingProcess03.boxcoxtrans = 
                             BoxCox(ManufacturingProcess03, -0.99992424816297),
                           ManufacturingProcess06.boxcoxtrans = 
                             BoxCox(ManufacturingProcess06, -0.99992424816297),
                           ManufacturingProcess07.boxcoxtrans = 
                             BoxCox(ManufacturingProcess07,-0.99992424816297),
                           ManufacturingProcess08.boxcoxtrans = 
                             BoxCox(ManufacturingProcess08, 1.99992424816297),
                           ManufacturingProcess12.boxcoxtrans = 
                             BoxCox(ManufacturingProcess12, 0.0000410225926326142),
                           ManufacturingProcess16.boxcoxtrans = 
                             BoxCox(ManufacturingProcess16, 1.99995900720725),
                           ManufacturingProcess18.boxcoxtrans = 
                             BoxCox(ManufacturingProcess18, 1.99995900720725))
data.set <- c(data.set, list(trans.data.set = trans.data.set))  %>% 
            c(., list(train.test.split = floor(0.75 * nrow(chem.imput)))) %>% 
            c(., train.index = list(sample(seq_len(nrow(chem.imput)), size = .$train.test.split))) %>%
            c(., train = list(as.data.frame(trans.data.set[.$train.index,])), test = list(as.data.frame(trans.data.set[-.$train.index,])))
nnetFit <- nnet(data.set$train %>% dplyr::select(-Yield), data.set$train$Yield,
                size = 5,
                decay = .01,
                maxit = 500,
                trace = FALSE)

results <- predict(nnetFit,data.set$test %>% dplyr::select(-Yield)) %>% cbind(.,data.set$test$Yield) %>% as.data.frame()
colnames(results) <- c("predicted", "actual")
rmse(results$actual, results$predicted)
marsFit <- earth(data.set$train %>% dplyr::select(-Yield), data.set$train$Yield)
results <- predict(marsFit, data.set$test %>% dplyr::select(-Yield)) %>% cbind(.,data.set$test$Yield) %>% as.data.frame()
colnames(results) <- c("predicted", "actual")
rmse(results$actual, results$predicted)
library(data.table)
dt <- setDT(varImp(marsFit), keep.rownames = TRUE)[]
options(scipen=99)
dt[order(-Overall)]
subset.data.set <- data.set$trans.data.set %>% 
                      dplyr::select(ManufacturingProcess32, ManufacturingProcess09, 	
                             ManufacturingProcess13,	ManufacturingProcess33,  
                             BiologicalMaterial02,	BiologicalMaterial03, 
                             ManufacturingProcess28, ManufacturingProcess43, 
                             ManufacturingProcess04, BiologicalMaterial05, Yield)
library(corrplot)
correlations <- cor(subset.data.set)
corrplot(correlations, order = "FPC", diag = TRUE)
library(tidyverse)
library(mlbench)
set.seed(200)
simulated <- mlbench.friedman1(200, sd = 1)
simulated <- cbind(simulated$x, simulated$y)
simulated <- as.data.frame(simulated)
colnames(simulated)[ncol(simulated)] <- "y"
library(randomForest)
library(caret)
model1 <- randomForest(y ~., data = simulated, importance = TRUE,
                       ntree = 1000)
rfImp <- varImp(model1, scale = FALSE)
rfImp
simulated$duplicate1 <- simulated$V1 + rnorm(200) * .1
cor(simulated$duplicate1, simulated$V1)
model1 <- randomForest(y ~., data = simulated, importance = TRUE,
                       ntree = 1000)
rfImp <- varImp(model1, scale = FALSE)
library(data.table)
dt <- setDT(varImp(model1, scale = FALSE), keep.rownames = TRUE)[]
options(scipen=99)
dt[order(-Overall)]
simulated$duplicate2 <- simulated$V1 + rnorm(200) * .15
cor(simulated$duplicate2, simulated$V1)
model2 <- randomForest(y ~., data = simulated, importance = TRUE,
                       ntree = 1000)
rfImp <- varImp(model2, scale = FALSE)
library(data.table)
dt <- setDT(varImp(model2, scale = FALSE), keep.rownames = TRUE)[]
options(scipen=99)
dt[order(-Overall)]
library(party)
fit.cforest <- cforest(y ~., data = simulated)
library(data.table)
dt <- setDT(party::varimp(fit.cforest, conditional = TRUE) %>% data.frame(), keep.rownames = TRUE)[]
options(scipen=99)
dt[order(-.)]
dt <- setDT(party::varimp(fit.cforest, conditional = FALSE) %>% data.frame(), keep.rownames = TRUE)[]
options(scipen=99)
dt[order(-.)]
library(Cubist)
fit.cubist <- cubist(simulated %>% select(-y), simulated$y, committees = 4)
fit.cubist
dt <- setDT(varImp(fit.cubist) %>% data.frame(), keep.rownames = TRUE)[]
options(scipen=99)
dt[order(-Overall)]
library(mlbench)
library(tidyverse)
library(rpart)
library(rpart.plot)
library(caret)

data.set <- twoClassSim(300, noiseVars = 8, corrVar = 6, corrValue = 0.8) %>%
            mutate(TwoFactor1 = as.factor(round(TwoFactor1, 0)),
                   TwoFactor2 = as.factor(round(TwoFactor2, 0)))
r.fit <- rpart(Linear01 ~ ., data=data.set)
rpart.plot(r.fit)
library(data.table)
dt <- setDT(varImp(r.fit), keep.rownames = TRUE)[]
options(scipen=99)
dt[order(-Overall)]
library(missForest)
library(AppliedPredictiveModeling)
library(doParallel)
data("ChemicalManufacturingProcess")

set.seed(1234)

registerDoParallel(cores=3)
chem.imput <- missForest(ChemicalManufacturingProcess, ntree = 100)$ximp
data.set <- list(org.data.set = chem.imput)
library(tidyverse)
library(caret)
library(forecast)
library(MASS)

trans.data.set <- data.set$org.data.set %>% 
                    mutate(BiologicalMaterial04.boxcoxtrans = 
                             BoxCox(BiologicalMaterial04, -0.99992424816297),
                           ManufacturingProcess01.boxcoxtrans = 
                             BoxCox(ManufacturingProcess01, 1.99995900720725),
                           ManufacturingProcess02.boxcoxtrans = 
                             BoxCox(ManufacturingProcess02, 1.99995900720725),
                           ManufacturingProcess03.boxcoxtrans = 
                             BoxCox(ManufacturingProcess03, -0.99992424816297),
                           ManufacturingProcess06.boxcoxtrans = 
                             BoxCox(ManufacturingProcess06, -0.99992424816297),
                           ManufacturingProcess07.boxcoxtrans = 
                             BoxCox(ManufacturingProcess07,-0.99992424816297),
                           ManufacturingProcess08.boxcoxtrans = 
                             BoxCox(ManufacturingProcess08, 1.99992424816297),
                           ManufacturingProcess12.boxcoxtrans = 
                             BoxCox(ManufacturingProcess12, 0.0000410225926326142),
                           ManufacturingProcess16.boxcoxtrans = 
                             BoxCox(ManufacturingProcess16, 1.99995900720725),
                           ManufacturingProcess18.boxcoxtrans = 
                             BoxCox(ManufacturingProcess18, 1.99995900720725))
data.set <- c(data.set, list(trans.data.set = trans.data.set))  %>% 
            c(., list(train.test.split = floor(0.75 * nrow(chem.imput)))) %>% 
            c(., train.index = list(sample(seq_len(nrow(chem.imput)), size = .$train.test.split))) %>%
            c(., train = list(as.data.frame(trans.data.set[.$train.index,])), test = list(as.data.frame(trans.data.set[-.$train.index,])))
ctrl <- trainControl(method = "boot", number = 15)

rpart.fit  <- train(data.set$train %>% dplyr::select(-Yield), data.set$train$Yield,
                    method = "rpart",
                    metric = "Rsquared",
                    trControl = ctrl)
plot(rpart.fit)
rf.fit   <- train(data.set$train %>% dplyr::select(-Yield), data.set$train$Yield,
                  method = "rf",
                  metric = "Rsquared",
                  trControl = ctrl,
                  importance = TRUE)
plot(rf.fit)
gbm.fit   <- train(data.set$train %>% 
                     dplyr::select(-Yield), data.set$train$Yield,
                  method = "gbm",
                  metric = "Rsquared",
                  trControl = ctrl)

plot(gbm.fit)
rf.fit$finalModel
varImp(rf.fit, scale = FALSE)
#https://shiring.github.io/machine_learning/2017/03/16/rf_plot_ggraph

library(dplyr)
library(ggraph)
library(igraph)

tree_func <- function(final_model, 
                      tree_num) {
  
  # get tree by index
  tree <- randomForest::getTree(final_model, 
                                k = tree_num, 
                                labelVar = TRUE) %>%
    tibble::rownames_to_column() %>%
    # make leaf split points to NA, so the 0s won't get plotted
    mutate(`split point` = ifelse(is.na(prediction), `split point`, NA))
  
  # prepare data frame for graph
  graph_frame <- data.frame(from = rep(tree$rowname, 2),
                            to = c(tree$`left daughter`, tree$`right daughter`))
  
  # convert to graph and delete the last node that we don't want to plot
  graph <- graph_from_data_frame(graph_frame) %>%
    delete_vertices("0")
  
  # set node labels
  V(graph)$node_label <- gsub("_", " ", as.character(tree$`split var`))
  V(graph)$leaf_label <- as.character(round(tree$prediction,2))
  V(graph)$split <- as.character(round(tree$`split point`, digits = 2))
  
  # plot
  plot <- ggraph(graph, 'dendrogram') + 
    theme_bw() +
    geom_edge_link() +
    geom_node_point() +
    geom_node_text(aes(label = node_label), na.rm = TRUE, repel = TRUE) +
    geom_node_label(aes(label = split), vjust = 2.5, na.rm = TRUE, fill = "white") +
    geom_node_label(aes(label = leaf_label, fill = leaf_label), na.rm = TRUE, 
					repel = TRUE, colour = "white", fontface = "bold", show.legend = FALSE) +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          panel.background = element_blank(),
          plot.background = element_rect(fill = "white"),
          panel.border = element_blank(),
          axis.line = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          plot.title = element_text(size = 18))
  
  print(plot)
}

tree_num <- max(which(rf.fit$finalModel$forest$ndbigtree == min(rf.fit$finalModel$forest$ndbigtree)))
tree_func(final_model = rf.fit$finalModel, tree_num = tree_num)
library(arules)
df <- read.transactions("https://raw.githubusercontent.com/ChristopheHunt/MSDA---Coursework/master/Data%20624/Homework%2011/GroceryDataSet.csv", sep = ",", format = c("basket"))
inspect(df[1:5])
summary(df)
itemFrequencyPlot(df, topN = 10)
rules <- apriori(df, parameter = list(support = 0.01016777, confidence = 0.5))
inspect(sort(rules, by = "lift")[1:10])
## NA
