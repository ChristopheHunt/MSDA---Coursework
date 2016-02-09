#1. fill in this class
#   it will need to provide for what happens below in the
#	main, so you will at least need a constructor that takes the values as (Brand, Price, Safety Rating),
# 	a function called showEvaluation, and an attribute carCount
class CarEvaluation(object):
    'A simple class that represents a car evaluation'
    carCount = 0
    def __init__ (self,brand,price,safety_rating):
       self.brand = brand
       self.price = price
       self.sr = safety_rating
       CarEvaluation.carCount += 1 
     
    def showEvaluation(self):
        print "The %s has a %s price and it's safety is rated a %s." %(self.brand,self.price,self.sr)
         
    def __repr__(self):
        return '{}'.format(self.brand)

    def pricesort(self):
            if self.price == "Low":
                return 1
            elif self.price == "Med":
                return 2
            elif self.price == "High":
                return 3
        #all your logic here

#2. fill in this function
#   it takes a list of CarEvaluation objects for input and either "asc" or "des"
#   if it gets "asc" return a list of car names order by ascending price
# 	otherwise by descending price
def sortbyprice(input, value): #you fill in the rest
    if value == "asc":
        sort_objects = sorted(input, key = CarEvaluation.pricesort)
    elif value == "des":
        sort_objects = sorted(input, key = CarEvaluation.pricesort, reverse = True)
    return sort_objects #return a value 

#3. fill in this function
#   it takes a list for input of CarEvaluation objects and a value to search for
#	it returns true if the value is in the safety  attribute of an entry on the list,
#   otherwise false
def searchforsafety(input, value):
    in_list = [CarEvaluation.sr for CarEvaluation in input]#you fill in the rest
    return value in in_list  #return a value

# This is the main of the program.  Expected outputs are in comments after the function calls.
if __name__ == "__main__":	
   eval1 = CarEvaluation("Ford", "High", 2)
   eval2 = CarEvaluation("GMC", "Med", 4)
   eval3 = CarEvaluation("Toyota", "Low", 3)

   print "Car Count = %d" % CarEvaluation.carCount #Car Count = 3  

   eval1.showEvaluation() #The Ford has a High price and it's safety is rated a 2
   eval2.showEvaluation() #The GMC has a Med price and it's safety is rated a 4
   eval3.showEvaluation() #The Toyota has a Low price and it's safety is rated a 3
   
   L = [eval1, eval2, eval3]

   print sortbyprice(L, "asc"); #[Toyota, GMC, Ford]
   print sortbyprice(L, "des"); #[Ford, GMC, Toyota]
   print searchforsafety(L, 2); #true
   print searchforsafety(L, 1); #false