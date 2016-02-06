
#####1. Using matrix operations, describe the solutions for the following family of equations:

      x + 2y - 3z = 5
      2x + y - 3z = 13
      -x + y = -8

   
#####2. Provide a solution for #1, using R functions of your choice.

```{r}

A_data <- c(1,2,-1,2,1,1,-3,-3, 0)
A <- matrix(A_data, nrow = 3, ncol = 3)
A

b_data <- c(5,13,-8)
b <- matrix(b_data, nrow = 3, ncol = 1)
b

```

#####3. Solve for AB by hand:


![] (https://github.com/ChristopheHunt/MSDABridgeCoursework/blob/master/Week_4/Images/MatrixMultiplication.jpg )

#####4. Solve AB from #3 using R functions of your choice.

```{r}

A_data <- c(4,-3,0,-3,5,1)
A <- matrix(A_data, nrow = 3, ncol = 2)
A

B_data <- c(1,3,4,-2)
B <- matrix(B_data, nrow = 2, ncol = 2)
B

A %*% B

> A %*% B

     [,1] [,2]
[1,]   -5   22
[2,]   12  -22
[3,]    3   -2

```
