import numpy as np
import timeit 


def sortwithloops(input):
    L = input[:]
    ordered = False 
    while not ordered: 
        ordered = True
        for i in range(len(L)-1):
                if L[i] > L[i + 1]:
                   L[i] , L[i + 1] = L[i + 1] , L[i]
                   ordered = False
    return L 

def sortwithoutloops(input):
    return sorted(input)

def sortwithoutloops_numpysort(input):
    return np.sort(input)
  
def searchwithloops(input, value):
    L = input[:]
    x = value
    for i in L:
         if i == x: 
            in_list = True 
            break
         else: 
            in_list = False
    return in_list #return a value

def searchwithoutloops(input, value):
    L = input[:]
    if value in L:
        return True
    else: 
        return False


def searchwithnumpy(input, value):
    x = np.where(np.asarray(input) == value)[0]
    if (x.size):
        return True
    else: 
        return False
   
 
if __name__ == "__main__":	
    L = [5,3,6,3,13,5,6]	
    
    import timeit
    
    number = 100000
    setup = ("from __main__ import L, sortwithloops, sortwithoutloops," +
            "sortwithoutloops_numpysort, searchwithloops, searchwithoutloops, searchwithnumpy")
     
    sortwithloops_time = timeit.timeit("sortwithloops(L)", setup=setup, number = number)
    sortwithoutloops_time = timeit.timeit("sortwithoutloops(L)", setup=setup, number = number)
    numpysort_time = timeit.timeit("sortwithoutloops_numpysort(L)", setup=setup, number = number)
    searchwith_loops_five = timeit.timeit("searchwithloops(L, 5)", setup=setup, number = number)
    searchwith_loops_eleven = timeit.timeit("searchwithloops(L, 11)", setup=setup, number = number)
    searchwithout_loop_five = timeit.timeit("searchwithoutloops(L, 5)", setup=setup, number = number)
    searchwithout_loop_eleven = timeit.timeit("searchwithoutloops(L, 11)", setup=setup, number = number)
    numpy_search_five = timeit.timeit("searchwithnumpy(L, 5)", setup=setup, number = number)
    numpy_search_eleven = timeit.timeit("searchwithnumpy(L, 11)", setup=setup, number = number)


print("Sort using iteration:  %s loops = %s seconds" % (number, sortwithloops_time))
print("Sort using built in python: %s loops = %s seconds" % (number, sortwithoutloops_time))
print("Sort using numpy: %s loops = %s seconds" % (number, numpysort_time))
print("Search with interation with value present: %s loops = %s seconds" % (number, searchwith_loops_five))
print("Search with interation with value not present: %s loops = %s seconds" % (number, searchwith_loops_eleven))     
print("Search using built in python with value present: %s loops = %s seconds" % (number, searchwithout_loop_five))           
print("Search using built in python with value not present: %s loops = %s seconds" % (number, searchwithout_loop_eleven )) 
print("Search using numpy with value present: %s loops = %s seconds" % (number, numpy_search_five))          
print("Search using numpy with value not present: %s loops = %s seconds" % (number, numpy_search_eleven))             

