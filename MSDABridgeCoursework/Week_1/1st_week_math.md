
2.12 School absences. Data collected at elementary schools in DeKalb County, GA suggest
    that each year roughly 25% of students miss exactly one day of school, 15% miss 2 days, and 28%
    miss 3 or more days due to sickness.

    Missed_0 = {.35}
    Missed_1 = {.25}
    Missed_2 = {.12}
    Missed_3or+ = {.28}

(a) What is the probability that a student chosen at random doesn’t miss any days of school due
to sickness this year?

    P(Missed_0) = P(.35/1) = .35 = 35% 

(b) What is the probability that a student chosen at random misses no more than one day?

    P(Missed_0) + P(Missed_1)
    P(.35/1) + P(.25/1) 
    = .6/1 
    = 60% 

(c) What is the probability that a student chosen at random misses at least one day?

    P(Missed_3or+) + P(Missed_2) + P(Missed_1) 
    P(.28/1) + P(.12/1) + P(.25/1) 
    = .65 / 1 
    = 65% 

(d) If a parent has two kids at a DeKalb County elementary school, what is the probability that
neither kid will miss any school? Note any assumption you must make to answer this question.

    P(Missed_0) * P(Missed_0) 
    P(.35/1) * P(.35/1) 
    = .1225 
    = 12.25% - assuming that the probability remains the same for each child

(e) If a parent has two kids at a DeKalb County elementary school, what is the probability that
that both kids will miss some school, i.e. at least one day? Note any assumption you make.

    P(Missed_1) + P(Missed_2) + P(Missed_3or+)  
    P(.25/1) + P(.12/1) + P(.28/1)  
    .65  
    .65 * . 65 
    .4225 
    42.25% - assuming that the probability remains the same for each child 

(f) If you made an assumption in part (d) or (e), do you think it was reasonable? If you didn’t
make any assumptions, double check your earlier answers.

    I feel that the assumptions are reasonable for the accuracy of this exercise. 
    Since these numbers are rough estimates and accurate numbers are not available, using probablility 
    determined with replacement is as accurate as reasonably possible. 

2.14 Weight and health coverage, Part I. The Behavioral Risk Factor Surveillance System
    BRFSS) is an annual telephone survey designed to identify risk factors in the adult population and
    report emerging health trends. The following table summarizes two variables for the respondents:
    weight status using body mass index (BMI) and health coverage, which describes whether each
    respondent had health insurance.

                                           Weight Status
                   | Neither overweight   | Overweight       |    Obese   |
                   | nor obese (BMI < 25) | (25 ≤ BMI < 30)  | (BMI ≥ 30) |  Total  | 
                   | -------------------- | ---------------- |------------| ------  | 
    | Health Yes   | 134,801              | 141,699          | 107,301    | 383,801 |
    | Coverage No  | 15,098               | 15,327           | 14,412     | 44,837  |
    | Total        | 149,899              | 157,026          | 121,713    | 428,638 |

(a) If we draw one individual at random, what is the probability that the respondent is overweight
and doesn’t have health coverage?

    P(Overweight | Coverage No)
    (15,327 / 428,638) 
    = .035
    =  3.5%

(b) If we draw one individual at random, what is the probability that the respondent is overweight
or doesn’t have health coverage?

    P(overweight) + P(Coverage No) - P(Overweight and Coverage No) 
    P(157,026) + P(44,837) - P(15,327) / 428,638 
    = .435 
    =  43.5% 

2.28 Socks in a drawer. In your sock drawer you have 4 blue, 5 gray, and 3 black socks. Half
     asleep one morning you grab 2 socks at random and put them on. Find the probability you end
     up wearing

    blue socks = {4}
    gray socks = {5} 
    black socks = {3} 

(a) 2 blue socks

    P(blue socks)
    4 / 12 = .33
    P(blue socks) 
    3 / 11 = .27 
    .33 * .27 = .09 
    = 9%
    
(b) no gray socks

    P(socks) - P(gray socks) 
    P(12-5/12)
    7 / 12 = 0.583
    P(socks) - P(gray socks)
    P(11-5/11)
    6 / 11 = 0.545
    = .583 * .545 = 0.317
    = 31.7%
    
(c) at least 1 black sock

    P(1 black sock) 
    3 / 12 = .25
    25%
    P(blue socks) + P(gray socks) + P(black socks) 
    p(4/11) + P(5/11) + P(2/11) 
    11 / 11 = 1 
    .25 * 1 = .25 
    = 25% 
    
(d) a green sock

    P(green sock)
    0 / 12 
    = 0
    = 0%

(e) matching socks

    P(Blue socks)  4/12 * 3/11 = .090
    P(Gray socks)  5/12 * 4/11 = .151
    P(Black socks) 3/12 * 2/11 = .045
    = .287 
    = 28.7%

2.30 Books on a bookshelf. The table below shows the distribution of books on a bookcase
     based on whether they are nonfiction or fiction and hardcover or paperback.

                            Format
                       Hardcover Paperback Total
    Type       Fiction   13          59       72
            Nonfiction   15          8        23
                 Total   28          67       95
        
(a) Find the probability of drawing a hardcover book first then a paperback fiction book second
when drawing without replacement.

        P(hardcover) 
        28 / 95 
        = 0.294
        = 29.4%
        
        P(paperback fiction) 
        59 / 94 
        = 0.627
        = 62.7%
       
        .294 * .627 
        = 0.184
        = 18.4%

(b) Determine the probability of drawing a fiction book first and then a hardcover book second,
when drawing without replacement.

        P(fiction) 
        72 / 95 
        = 0.757
        = 75.7%
        
        P(Hardcover) 
        27 / 94 
        = 0.287
        = 28.7%
        
        .757 * .287 = 0.217
        21.7%
        

(c) Calculate the probability of the scenario in part (b), except this time complete the calculations
under the scenario where the first book is placed back on the bookcase before randomly drawing
the second book.

        P(Fiction) 
        72 / 95 = 0.757
        
        P(Hardcover) 
        28 / 95 = 0.294
        
        .757 * .294 = 0.223
        22.3%

(d) The final answers to parts (b) and (c) are very similar. Explain why this is the case.

    The reason the answers are so close is due to the number of books involved.
    We are only selecting a small number of books (2) and the 
    hardcover books represent a smaller population overall. 
