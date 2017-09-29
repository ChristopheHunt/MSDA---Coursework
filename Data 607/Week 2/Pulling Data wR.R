library(tm)

f.data <- file("http://archive.ics.uci.edu/ml/machine-learning-databases/flags/flag.data",
               open="r" )

data <- read.table(f.data, 
                   sep=",", 
                   header=FALSE, 
                   stringsAsFactors = FALSE)

newdata <- data[, c( 1,2,3,6,7)]

f.data.dictionary <- file("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.names", 
                          open="r" )

test <- readLines("http://archive.ics.uci.edu/ml/machine-learning-databases/flags/flag.names")
docs <- Corpus(VectorSource(test))

data.dictionary <- read.table(f.data.dictionary, 
                              sep="", 
                              header=FALSE, 
                              stringsAsFactors = FALSE)

dataframe <- data.frame(text=unlist(sapply(docs, `[`, "content")), stringsAsFactors=F)
