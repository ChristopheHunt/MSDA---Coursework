__author__ = 'Christophe'

#1. fill in this function
#   it takes a list for input and return a sorted version
#   do this with a loop, don't use the built in list functions
def sortwithloops(input):
    L = input[:]
    ordered = False
    while not ordered:
        ordered = True
        for i in range(len(L)-1):
                if L[i] > L[i + 1]:
                   L[i] , L[i + 1] = L[i + 1] , L[i]
                   ordered = False
    return L #return a value
#2. fill in this function
#   it takes a list for input and return a sorted version
#   do this with the built in list functions, don't us a loop
def sortwithoutloops(input):
    input.sort()
    return input #return a value

#3. fill in this function
#   it takes a list for input and a value to search for
#	it returns true if the value is in the list, otherwise false
#   do this with a loop, don't use the built in list functions
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

#4. fill in this function
#   it takes a list for input and a value to search for
#	it returns true if the value is in the list, otherwise false
#   do this with the built in list functions, don't use a loop
def searchwithoutloops(input, value):
    L = input[:]
    if value in L:
        in_list = True
    else:
        in_list = False
    return in_list #return a value

if __name__ == "__main__":
    L = [5,3,6,3,13,5,6]

    print sortwithloops(L) # [3, 3, 5, 5, 6, 6, 13]
    print sortwithoutloops(L) # [3, 3, 5, 5, 6, 6, 13]
    print searchwithloops(L, 5) #true
    print searchwithloops(L, 11) #false
    print searchwithoutloops(L, 5) #true
    print searchwithoutloops(L, 11) #false