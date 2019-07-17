from math import *

#1. QuadraticSolver
def QuadraticSolver(a,b,c):
    delta=b*b-4*a*c
    if(delta==0):
        result=-b/(2*a)
    elif (delta<0):
        result=float('nan')
    else:
        result=[(-b-sqrt(delta))/2*a,(-b+sqrt(delta))/2*a]
    return result


a = float(input("type the value of a: "))
b = float(input("type the value of b: "))
c = float(input("type the value of c: "))
s=quadraticsolver(a,b,c)
print(s)

#2. Factorial: interactive vs recursive

def factorial_inter(i):
    result=1
    for i in range(i,1,-1):
        result=result*i
    return result

def Factorial_Recursive(n):
    if(n== 0 | n == 1):
        return 1
    else:
        return n * Factorial_Recursive(n-1)

i=int(input("type the value of i: "))
s1=factorial_inter(i)
s2=Factorial_Recursive(i)

print("interactive factorial is: "+str(s1))
print("recursive factorial is: "+str(s2))    

print('hi')