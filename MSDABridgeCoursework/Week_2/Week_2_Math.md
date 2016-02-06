#### 2.16 PB & J.
﻿Suppose 80% of people like peanut butter, 89% like jelly, and 78% like both. Given that a randomly sampled   person likes peanut butter, what’s the probability that he also likes jelly

      
       P( PB = like | Jelly = like  ) =      P(PB & J = like)
                                          --------------------
                                                 P(PB)
                                              
                                              
                                                  P(.78)
                                          --------------------   = .90
                                                  P(.80)
                                           
      P( PB = like  | Jelly = like )  =      .90    =      90%
     
    
#### 2.18 Weight and health coverage, Part II. 
Exercise 2.14 introduced a contingency table summarizing the relationship between weight status, which is determined based on body mass index (BMI), and health coverage for a sample of 428,638 Americans. In the table below, the counts have been replaced by relative frequencies (probability estimates).

###### Weight Status 

      Health Coverage | Neither overweight nor obese (BMI < 25) | Overweight (25 ≤ BMI < 30) | Obese (BMI ≥ 30) | Total 
      :-------------: | :-------------------------------------: | :-----------------------:  | :--------------: | :---:
      Yes |  0.3145 | 0.3306  | 0.2503  | 0.8954
      No | 0.0352  |  0.0358  | 0.0336  | 0.1046 
      Total | 0.3497 |  0.3664  |  0.2839  |  1.0000
      
       
(a) What is the probability that a randomly chosen individual is obese? 

       P(Obese) = 0.2839 
       28.39%
 
(b) What is the probability that a randomly chosen individual is obese given that he has health coverage? 

                                                      P(Obese & Health Coverage = yes)
       P(Obese  | Health Coverage = yes )  =         --------------------------------
                                                         P(Health Coverage = yes)
                                           
                                           =          P(.3306)
                                                      --------  =  .3692
                                                      P(.8954) 
                                                      
                                          =           36.92%
                                          
(c) What is the probability that a randomly chosen individual is obese given that he doesn’t have health coverage? 

                                                      P(Obese & Health Coverage = no)
       P(Obese  | Health Coverage = no )  =         --------------------------------
                                                         P(Health Coverage = no)
                                           
                                           =          P(.0336)
                                                      --------  =  .3212
                                                      P(.1046) 
                                                      
                                          =           32.12%

(d) Do being overweight and having health coverage appear to be independent?

       We can test using the multiplication rule for independent processes. 
       If the variables were independent then the P(overweight | health coverage = yes) would need to 
       equal the propability of being overweight or P(overweight). 
       However,  P(overweight | health coverage = yes) = 90.22% whereas P(overweight) = 36.64%. 
       The probabilities are not equal and therefore they are not independent.  

#### 2.20 Assortative mating. 
Assortative mating is a nonrandom mating pattern where individuals with similar genotypes and/or phenotypes mate with one another more frequently than what would be expected under a random mating pattern. Researchers studying this topic collected data on eye colors of 204 Scandinavian men and their female partners. The table below summarizes the results. For simplicity, we only include heterosexual relationships in this exercise.

###### Partner (female) 

        Self |  Color | Blue | Brown | Green | Total  
        :--: | :----: | :--: | :---: | :---: | :---: 
        male | Blue | 78 | 23 | 13 |  114 
        male | Brown | 19 | 23 | 12 | 54 
        male | Green | 11 | 9 | 16 |  36  
        male | Total |  108 | 55 | 41 | 204 
       
 
(a) What is the probability that a randomly chosen male respondent or his partner has blue eyes? 

          P(male & blue eyes = yes)       = 114/204
                                          =  .5588
                                          = 55.88%
                                          
          P(female & blue eyes = yes)     = 108/204
                                          = .5294
                                          = 52.94%
      

(b) What is the probability that a randomly chosen male respondent with blue eyes has a partner with blue eyes

                                                               P(male & blue eyes = yes | female & blue eyes = yes)  = 78/204
      P(male & blue eyes = yes | female & blue eyes = yes) =      ----------------------------------------------------------
                                                                        P(male & blue eyes = yes) = 114/204
                                                                        
                                                                           0.3823
                                                                      ---------------
                                                                           0.5588
                                                                           
                                                                =          0.6841
                                                                  
                                                                =          68.41%

(c) What is the probability that a randomly chosen male respondent with brown eyes has a partner with blue eyes? What about the probability of a randomly chosen male respondent with green eyes having a partner with blue eyes? 

                                                               P(male & brown eyes = yes | female & blue eyes = yes) = 19/204
     P(male & brown eyes = yes | female & blue eyes = yes) =      -------------------------------------------------------
                                                                   P(male & brown eyes = yes) = 54/204
                                                                        
                                                                           0.0931
                                                                        ---------------
                                                                           0.2647
                                                                           
                                                                =          0.3517
                                                                  
                                                                =          35.17%
                                                                
                                                               P(male & green eyes = yes | female & blue eyes = yes) = 11/204
     P(male & green eyes = yes | female & blue eyes = yes) =      -----------------------------------------------------
                                                                        P(male & green eyes = yes) = 36/204
                                                                        
                                                                           0.0539
                                                                        ---------------
                                                                           0.1764
                                                                           
                                                                =          0.3055
                                                                  
                                                                =          30.55%

(d) Does it appear that the eye colors of male respondents and their partners are independent? Explain your reasoning.

       We can test using the multiplication rule for independent processes. 
       If the variables were independent then the P(male & green eyes = yes | female & blue eyes = yes)  
       would need to equal the propability of being male with green eyes or P(male & green eyes = yes). 
       However, P(male & green eyes = yes | female & blue eyes = yes) = 30.55%
       whereas P(male & green eyes = yes) = 17.64%.
       The probabilities are not equal and therefore they are not independent. 
       
       Furthermore, in the text of the question "Assortative mating is a nonrandom mating pattern where 
       individuals with similar genotypes and/or phenotypes mate with one another more frequently 
       than what would be expected under a random mating pattern." details that those with 
       similare genotypes mate with each other more frequently than one would expect to 
       occur randomly. 

#### 2.26 Twins. 

About 30% of human twins are identical, and the rest are fraternal. Identical twins are necessarily the same sex – half are males and the other half are females. One-quarter of fraternal twins are both male, one-quarter both female, and one-half are mixes: one male, one female. You have just become a parent of twins and are told they are both girls. Given this information, what is the probability that they are identical?

               			         males         = .5 --   .3 *.5  = .15
              identical = .3 <
                                 females        = .5 --   .3*.5   = .15
     twins <
                                 males 	        = .25 --  .7*.25  = .175
               faternal = .7 < - male & female  = .5  --  .7*.5  = .35
                                 females        = .25 --  .7*.25  = .175
---

                         P(identical | females = yes)   = P(identical & females = yes)
                                      				          --------------------------
         				                                      P(females = yes)
         				     
         				                                           .15
         				                                       -----------
         				                                        .15 + .175
         				      
         				                                           .15
         				                                         --------   = 0.4615
         				                                           .325
         				       
         				                                         = 46.15%
	

Optional Challenge exercise:  Provide a solution using R for one or more of this week's assigned problems.
