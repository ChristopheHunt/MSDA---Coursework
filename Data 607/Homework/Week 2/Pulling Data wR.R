f.data <- file("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data",
               open="r" )

data <- read.table(f.data, 
                   sep="", 
                   header=FALSE, 
                   stringsAsFactors = FALSE)

newdata <- data[1:6]

f.data.dictionary <- file("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.names", 
                          open="r" )

data.dictionary <- read.table(f.data.dictionary, 
                              sep="", 
                              header=FALSE, 
                              stringsAsFactors = FALSE)