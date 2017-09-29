Hw 4 Presentation -        4.3 College credits
========================================================
author: Christophe Hunt
date: 10/07/2015


4.3 College credits
========================================================

A college counselor is interested in estimating how many credits a student typically enrolls in each semester. The counselor decides to randomly sample 100 students by using the registrar's database of students. The histogram below shows the distribution of the number of credits taken by these students. Sample statistics for this distribution are also provided.

![4.3jpeg](https://raw.githubusercontent.com/ChristopheHunt/IS606_Fall_2015/master/Week_4/presentation_graph.JPG)

4.3 College credits (a) 
========================================================

(a) What is the point estimate for the average number of credits taken per semester by students at this college? What about the median?

* average number of credits taken per semester by students = 13.65   

* median number of credits taken per semester by students = 14 

4.3 College credits (b) 
========================================================

(b) What is the point estimate for the standard deviation of the number of credits taken per semester by students at this college? What about the IQR?

* Standard Deviation is 1.91

* The IQR is (Q3 - Q1) or (15 - 13) = 2

4.3 College credits (c )
========================================================

(c ) Is a load of 16 credits unusually high for this college? What about 18 credits? Explain your reasoning.

*  In order to evaluate we will take the scores and determine how many standard deviations from the mean the value is, anything 2 or more standard deviations from the mean would be unusually high for this college.


```r
test_z_score <- function(x) 
            if (abs(x) > 2) { 
            return("this score is unusual for this distribution")
            } else {
            return("this score is not unusual for this distribution")
            }
```

4.3 College credits (c ) continued
========================================================

(c ) Is a load of 16 credits unusually high for this college? What about 18 credits? Explain your reasoning.


```r
x_16 <- 16
x_18 <- 18

mean <- 13.65 

sd <- 1.91

z_score_16 <- (x_16 - mean)/sd

z_score_18 <- (x_18 - mean)/sd
```

4.3 College credits (c ) continued
========================================================

(c ) Is a load of 16 credits unusually high for this college? What about 18 credits? Explain your reasoning.


```r
paste("The Z score for an observation of", x_16, "is", round(z_score_16,2), "and", test_z_score(z_score_16))
```

[1] "The Z score for an observation of 16 is 1.23 and this score is not unusual for this distribution"

```r
paste("The Z score for an observation of", x_18, "is", round(z_score_18,2), "and", test_z_score(z_score_18))
```

[1] "The Z score for an observation of 18 is 2.28 and this score is unusual for this distribution"

4.3 College credits (d )
========================================================

(d) The college counselor takes another random sample of 100 students and this time finds a sample mean of 14.02 units. Should she be surprised that this sample statistic is slightly different than the one from the original sample? Explain your reasoning.

* She should not be suprised at all. She should be more suprised if the sample was exactly the same. This is because she is taking a sample which is a subset and only an approximate representation of the population as a whole so it will vary from one sample to another. 

4.3 College credits (e )
========================================================

(e) The sample means given above are point estimates for the mean number of credits taken by all students at that college. What measures do we use to quantify the variability of this estimate (Hint: recall that $$SD_\bar{x} = \frac {\sigma}{\sqrt{n}}$$ )? Compute this quantity using the data from the original sample.

* We use the standard error or SE which is the standard deviation divided by the square root of the number of observations  

$$\frac {\sigma}{\sqrt{n}} = \frac {1.91}{\sqrt{100}} = 0.191 $$

