import inspect
#1. Object in Python: high dynamicity convenience
class Point2D:
    x=float()
    y=float()
    #->float default constructor is 0.0
#2. Initial constructor: cannot overload __init__
    def __init__(self,x=None, y=None):
        if(x!=None):
            self.x=x
        if(y!=None):
            self.y=y


a=Point2D()
a.x=5
a.y=5.6
#even we use default float, they still stay as integer: so we need to specify when we call it
print(a) ##->print object instance address
print(a.x)

##->we see that now attribute x has been added to a
print(dir(a))

##-> we can also check it with inspection: with more detail
print(inspect.getmembers(a))

#3. class attribute vs. instance attribute
## -> if the instance attribute name collides with class attribute name, the instance attribute takes over 
test=Point2D(x=30)
print(test.__dict__)

## Let's create a method to check whether the attribut is class or instance level
def instlookup(inst,name):
    if name in inst.__dict__:
        result = "instance attribute"
    elif name in inst.__class__.__dict__:
        result = "class attribute"
    else:
        result = "not found in the attribute"
    return result

print(instlookup(test,'x'))
print(instlookup(test,'y'))
## -> y is class attribute, x is instance attribute



#list method
a=1
b=2
c=3
d= Point2D(x=2,y=4)
#print(hex(id(a)))
#print(hex(id(b)))
#print(hex(id(c)))
#cleaner way to print address
mylist=[a,b,c,d]
for currentValue in mylist:
    print(hex(id(currentValue)))
#a=50 is different memory location then a=1
a=50
print(hex(id(a)))
#when a change back to 1 the memory location is the same, Python is storing the value
#the location is not immediately release
a=1
print(hex(id(a)))
print(mylist)

obj1, obj2, *_=mylist
obj1=30

mylist[0]=500
mylist.append('a')
mylist.remove(b)


list3=[1,2,3]+[4,5]
if(7 not in list3):                               
    print("7 not in list 3")

list4=list3[0:3]  # include first element exclude last [1,2,3]
list5=list3[1:-2] #[2,3]

#list can be sorted
list3.reverse()
list3.sort()

listNumAndTex=["hello",50,20,"Guys"]
#listNumAndTex.sort() 
#"<" not support, so we also need to define this overload for different datatype if we need to do this

list3=[1,2,3]+[4,5]
def apply_to_list(aList, lmd):
    return[lmd(x)for x in aList]
list3Times3=list3*3 #[12345 12345 12345]
list3Times3a=apply_to_list(list3, lambda x: x*3) #[3,6,9,12,15]
list3Times3b=apply_to_list(list3, lambda x: int(x/3))


#dictionary:
#can be multitype
my_dict={'a':1,'b':2,'c':3}
for currentkey in my_dict:
    print(currentkey)
print(len(my_dict))
my_dict[1]=50  #add 50 with the key 1
#even the key doesn't need to be consistance
my_dict['a']=50


#generator
mygenerator=iter(my_dict)
listcoversion=list(mygenerator) #here it give me a list of the keys in the dictionary

#generator
def square(n=10):
    print("generating squares of number form 1 to {0}".format(n))
    for i in range(1,n+1):
        yield i**2
        #yeild provides an generator

gen=square(n=5)
#this does not trigger the execution of the square
#the function will be execited only when the generator is iterated over
print(gen)
for x in gen:
    print(x)


print('hi')