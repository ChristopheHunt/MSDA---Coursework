##Question 1
##Write a loop that calculates 12-factorial.


 n <- 12 
 f <- 1 
 for (i in 1:n)
  { 
   f <- f * i 
  }
 print(f) 
 

##Question 2  
##Show how to create a numeric vector that contains the sequence from 20 to 50 by 5

  x <- c(seq(from = 20, to = 50, by = 5))
  x

##Question 3   
##Show how to take a trio of input numbers a, b, and c and implement the quadratic equation.

  a <- 1 
  b <- 4
  c <- 4
  D <- ((b^2)-(4*a*c))
  
  Quad <- function(x)
  {
     if (x >= 0) 
    {
    RT1 <- (-b + sqrt(b^2 - (4*a*c)))/(2*a)
    RT2 <- (-b - sqrt(b^2 - (4*a*c)))/(2*a)
    z <- list(RT1, RT2)
    print(z)
    
    } else
    {
      print("no real roots")
    }
  }
  
  Quad(D)
