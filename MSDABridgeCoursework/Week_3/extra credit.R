m <- matrix('', 0, 4, dimnames=list(NULL, LETTERS[1:4]))

prob_newline <- function(dataframe_to_add,event, outcome, probability_of_outcome){
  
  e <- as.character(event)
  o <- as.numeric(outcome)
  po <- as.numeric(probability_of_outcome)
  expected <- o*po
  newrow <- list(e,o,po,expected)
  newrow
  df <- rbind(dataframe_to_add,newrow)
  print(df)
  return(df)
 }

m <- prob_newline(m,"red card", 0,.5)
m <- prob_newline(m,"spade", 5,.25)
m <- prob_newline(m,"club",10,.23)
m <- prob_newline(m,"club{ace}", 30, .02)

expected_value <- .colSums(m, 3, 0, na.rm = FALSE)
expected_value


j <- c("event","outcome","prob_of_outcome","expected value")

df <- data.frame(colnames(j))

redcard <- c("red card", 0, (26/52))
spade <- c("spade", 5,(13/52))
club <- c("club{no ace}", 10,(12/52))
club_ace <- c("club{ace}", 30, (1/52))
df <- rbind(redcard,spade,club,club_ace)
df <- data.frame(df)
df$X3 <- as.numeric(df$X3)

  
expected_value

Event | X | P(X) | X - P(X) | (X - E(X))<sup>2</sup> | (X - E(X))<sup>2</sup> - P(X) | 
  :---: | :-: | :---: | :----: | :----: | :--: |  
  red card | $0.00 | 26/52 = .5 | 0 | (0 - 4.15)<sup>2</sup> = 17.223 | 17.233 * .5 = 8.61125 | 
    spade | $5.00 | 13/52 = .25 | 1.23 | (5 - 4.15)<sup>2</sup> = 0.722 | .722 * .25 = 0.180625 | 
      club | $10.00 | 12/52 = .23 | 2.3 | (10 - 4.15)<sup>2</sup> = 34.223 | 34.223 * .23 = 7.871 | 
        club{ace} | $30.00 | 1/52 = .02| .6 | (30 - 4.15)<sup>2</sup> = 668.223 | 668.223 * .02 = 13.364 |
          ||| **E(X) - $4.15** | | **V(X) - 30.027** <br> **SD(X) = &radic;<span style="text-decoration: overline"> V(X) </span> = 5.479** | 
            
  

  
  
VG <- 38
VG_SD <- 5
T <- 110
T_SD <- 4

Net_Value <- function(value1,value2){
  #calculation of net value
  net_value <- value1 + value2
  print(net_value)
  }

Net_Value(VG,-T)
  
Standard_Deviation <- function(count_of_value1,value1,count_of_value2,value2){
  #calculation of standard deviation 
  v <- (count_of_value1*(value1^2)) + (count_of_value2*(value2^2))
  sd <- sqrt(v)
  print(sd)
}

Standard_Deviation(1,VG_SD,1,T_SD)




y <- as.factor(c("$1 to $9,999 or loss", "$10,000 to $14,999", "$15,000 to $24,999",  
                 "$25,000 to $34,999", "$35,000 to $49,999", "$50,000 to $64,999",  
                 "$65,000 to $74,999", "$75,000 to $99,999", " $100,000 or more"))
x <- as.numeric(c(.022, .047, .158, .183, .212, .139, .058, .084 , .097))
z <- data.frame(y,x)
z
barplot(z$x, names.arg = z$y, col = "blue", xlab = "Income Levels", main = "Histogram")
plot(z$x, type = "l")

str(z)
hist(z$x,col = "blue", xlab = "Income Levels", main = "Histogram with Normal Curve")
plot(z$x, type = "l")
  
  
  