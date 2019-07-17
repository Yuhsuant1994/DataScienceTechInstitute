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



print('hi')
