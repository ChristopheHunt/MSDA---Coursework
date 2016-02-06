
Assignment:  Please complete exercises 2.34, 2.40, 2.42, and 2.46 in OpenIntro Statistics (pp. 114-117).

Challenge exercise:  Provide a solution using R for one or more of this week's assigned problems

##### 2.34 Card game. 
Consider the following card game with a well-shuﬄed deck of cards. If you draw a red card, you win nothing. If you get a spade, you win $5. For any club, you win $10 plus an extra $20 for the ace of clubs. 

(a) Create a probability model for the amount you win at this game. Also, ﬁnd the expected winnings for a single game and the standard deviation of the winnings. 

      
          Event | X | P(X) | X - P(X) | (X - E(X))<sup>2</sup> | (X - E(X))<sup>2</sup> - P(X) | 
          :---: | :-: | :---: | :----: | :----: | :--: |  
          red card | $0.00 | 26/52 = .5 | 0 | (0 - 4.15)<sup>2</sup> = 17.223 | 17.233 * .5 = 8.61125 | 
          spade | $5.00 | 13/52 = .25 | 1.23 | (5 - 4.15)<sup>2</sup> = 0.722 | .722 * .25 = 0.180625 | 
          club | $10.00 | 12/52 = .23 | 2.3 | (10 - 4.15)<sup>2</sup> = 34.223 | 34.223 * .23 = 7.871 | 
          club{ace} | $30.00 | 1/52 = .02| .6 | (30 - 4.15)<sup>2</sup> = 668.223 | 668.223 * .02 = 13.364 |
          ||| **E(X) - $4.15** | | **V(X) - 30.027** <br> **SD(X) = &radic;<span style="text-decoration: overline"> V(X) </span> = 5.479** | 
          
---
> **Expected winnings of a single game = E(X)  - $4.15** 

> **With a Standard deviation          = SD(X) -  5.479**
          
(b) What is the maximum amount you would be willing to pay to play this game? Explain.

> The maximum amount I would be willing to pay to play is $4.15. At this price the expected earnings would be $0.00 so on average it would be an even game but the time spent playing would be fun. Though, I am risk adverse so if the situation was real I might want to decrease my spending threshold to  less than $4.15 to ensure I have a greater chance of getting some return when I play. 
            
##### 2.40 Baggage fees.

An airline charges the following baggage fees: $25 for the ﬁrst bag and $35 for the second. Suppose 54% of passengers have no checked luggage, 34% have one piece of checked luggage and 12% have two pieces. We suppose a negligible portion of people check more than two bags.

(a) Build a probability model, compute the average revenue per passenger, and compute the corresponding standard deviation.

      Event | X | P(X) | X - P(X) | (X - E(X))<sup>2</sup> | (X - E(X))<sup>2</sup> * P(X) | 
      :---: | :-: | :---: | :----: | :----: | :--: | 
      No luggage | $0.00 | .54 | 0 | (0 - $15.10)<sup>2</sup> = 228.01 | 228.01 * .54 = 123.13
      One Bag | $25.00 | .34 | 8.50 | (25 - 15.10)<sup>2</sup> = 98.01 | 98.01 * .34 = 33.32
      Two Bags | $55.00 | .12 | 6.60 | (50 - 15.10)<sup>2</sup> = 1592.01 | 1592.01 * .12 = 191.04 
      ||| **E(X) - $15.10** | | **V(X) - 347.49** <br> **SD(X) = &radic;<span style="text-decoration: overline"> V(X) </span> = 18.64** | 
       
---       

> **Average Revenue Per Passenger = $15.10**

> **With a Standard Deviation = 18.64** 
                       
(b) About how much revenue should the airline expect for a ﬂight of 120 passengers? With what standard deviation? Note any assumptions you make and if you think they are justiﬁed

      Event | X | P(X) = Count of Passengers | X - P(X) = Expected Revenue | (X - E(X))<sup>2</sup> | (X - E(X))<sup>2</sup> * P(X) | 
      :---: | :--: | :-----------------: | :-----------: | :--: | :--: | 
      No Luggage | $0.00 | (120 * .54) = 65 | 65 * 0 = 0 | (0 - 1812)<sup>2</sup> = 3283344 | (3283344 * .54) = 1773005.76 | 
      One Bag | $25.00 | (120 * .34) = 41 | 41 * $25.00 = 1020 | (1020 - 1812)<sup>2</sup> = 627264 | (627264 * .34) = 213269.76 |
      Two Bags | $55.00| (120 * .12) = 14 | 14 * $55.00 = 792 | (792 - 1812)<sup>2</sup> = 1040400 | (1040400 * .12) = 124848  |
      ||| **Total Expected Revenue = $1,812.00** || **V(X) - 2111123.52** <br> **SD(X) = &radic;<span style="text-decoration: overline"> V(X) </span> = 1452.97** | 
   
---        
> **Total Expected Revenue = $1,812.00** 
      
> **With a Standard Deviation = $1,452.97**

---
> We are assuming that this is an appropriate probability to use for this flight. The flight could be going to a vacation destination in which case we might have more  two bag passengers that expected because the population characteristics  has variability unaccounted for in our model. 
              
##### 2.42 Selling on Ebay.

Marcie has been tracking the following two items on Ebay: 
• A textbook that sells for an average of $110 with a standard deviation of $4. 
• Mario Kart for the Nintendo Wii, which sells for an average of $38 with a standard deviation of $5.

(a) Marcie wants to sell the video game and buy the textbook. How much net money (proﬁts losses) would she expect to make or spend? Also compute the standard deviation of how much she would make or spend. 

      NET 
      Video Game = VG = $38 , Texbook = T = $110 
      + VG, - T 
      + 38 - 110 = -$72.00 
      NET = -$72.00
      
      Standard Deviation 
      V(VG + T) = 1VG * 5^2 + 1T * 4^2 = 41
      Variance = $41
      Standard Deviation = sqrt($41) 
      Standard Deviation = $6.40
      
```{r}
      #R code to solve problem
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
      
      [1] -72
        
      Standard_Deviation <- function(count_of_value1,value1,count_of_value2,value2){
        #calculation of standard deviation 
        v <- (count_of_value1*(value1^2)) + (count_of_value2*(value2^2))
        sd <- sqrt(v)
        print(sd)
      }
      
      Standard_Deviation(1,VG_SD,1,T_SD)
      
      [1] 6.403124
      
```


(b) Lucy is selling the textbook on Ebay for a friend, and her friend is giving her a 10% commission (Lucy keeps 10% of the revenue). How much money should she expect to make? With what standard deviation?

> She could expect to sell the textbook at a standard price $110, less the 10% commission.  So she could expect a sale price of $110.00 - (110 *.1) = $99.00. The standard deviation remains the same at $4. Even though we have changed the mean by reducing it be a new 10% commission, the variablity in prices would remain the same. 
  
#####2.46 Income and gender. 
The relative frequency table below displays the distribution of annual total personal income (in 2009 inﬂation-adjusted dollars) for a representative sample of 96,420,486 Americans. These data come from the American Community Survey for 2005-2009. This sample is comprised of 59% males and 41% females.

      Income | Total  |
      :----: | :----: |
      $1 to $9,999 or loss | 2.2% |
      $10,000 to $14,999 | 4.7% |
      $15,000 to $24,999 | 15.8% |
      $25,000 to $34,999 | 18.3%  | 
      $35,000 to $49,999 | 21.2% | 
      $50,000 to $64,999 | 13.9% | 
      $65,000 to $74,999 | 5.8%  |
      $75,000 to $99,999 | 8.4% |
      $100,000 or more | 9.7% |


(a) Describe the distribution of total personal income. 

> The distribution appears to be normally distributed (which is unusual since income is never normally distributed), with a min at $1 and a max of $100,000 or more. The largest population is located at the center bin of $35,000 to $49,999 income. The increase on the right side may be due to the inclusion of outliers beyond $100,000 and the addition of more bins might be able to provide a smoother and better distributed curve.    

(b) What is the probability that a randomly chosen US resident makes less than $50,000 per year? 

            Income | Total  |
            :----: | :----: |
            $1 to $9,999 or loss | 2.2% |
            $10,000 to $14,999 | 4.7% |
            $15,000 to $24,999 | 15.8% |
            $25,000 to $34,999 | 18.3%  | 
            $35,000 to $49,999 | 21.2% | 
            | **Sum = 0.622** | 
            
      P(x) = 62%

(c) What is the probability that a randomly chosen US resident makes less than $50,000 per year and is female? Note any assumptions you make. 

       Income | Total  |
            :----: | :----: |
            $1 to $9,999 or loss | 2.2% |
            $10,000 to $14,999 | 4.7% |
            $15,000 to $24,999 | 15.8% |
            $25,000 to $34,999 | 18.3%  | 
            $35,000 to $49,999 | 21.2% | 
            | **Sum = 0.622** |      
            
     P(x) = 62%
     Males = 59% = .62 * .59 = 0.36698 = 37%
     Females = 41% = .62 * .41 = 0.25502 = 25% 
     
     Making less than 50k & female = 25% 
     
     Assuming that this information is normally distributed for females and males. 

(d) The same data source indicates that 71.8% of females make less than $50,000 per year. Use this value to determine whether or not the assumption you made in part (c) is valid.

> My assumption is not valid, if we looked at the distribution for females only, the curve would have a right skew and we could not draw the same conclusion that I did in the previous answer. While person income is normally distributed amoung US residents for this question, it is not normally distributed by sex. Also, there may be a sampling bias and there could be the possiblity that more poor females were surveyed than one would expect in the actual population. 
      
