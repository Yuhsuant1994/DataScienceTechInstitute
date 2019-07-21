import inspect
from math import *
class Point2D:
    # __init__
    ## 1. create item with x or y or non defined
    ## 2. copy constructor
    def __init__(self,x=0.0, y=0.0,name=None, anotherPoint=None):
        #anotherPoint: copy constructor
        if(anotherPoint!=None):
            if(isinstance(anotherPoint,Point2D)):
                self.x=anotherPoint.x
                self.y=anotherPoint.y
                self.name=anotherPoint.name
            else:
                raise Exception("the object is not Point2D object")
            return
        if(x!=None):
            try:
                self.x=float(x)
            except:
                raise Exception("incorrect value for x")
        if(y!=None):
            try:
                self.y=float(y)
            except:
                raise Exception("incorrect value for y")
        if(name!=None):
            self.name=str(name)
        else:
            self.name="unnamed"

    #__str__: for print (toString method)
    def __str__(self):
        return(self.name+"("+str(self.x)+";"+str(self.y)+")")
    
    #change to pass by reference
    #def __new__(cls, x = None, y = None, name = None, anotherPoint = None):
    #    if (isinstance(anotherPoint, Point2D)):
    #        return anotherPoint

    def __eq__(self, anotherPoint):
        if(anotherPoint==None):
            return False
        result = False
        if( self.x == anotherPoint.x and self.y == anotherPoint.y ):
            result = True
        return result

p1=Point2D()
p2=Point2D(x=10,name="p2")
p3=Point2D(y=20,name="p3")
p4=Point2D(x=30,y=40,name="p4")
p5=Point2D(anotherPoint=p4)

print(p5)
print("p4 address: "+str(hex(id(p4))))
#print(inspect.getmembers(p4))
print("p5 address: "+str(hex(id(p5))))
#here we copy by value (different memory location) 
#by overloading __new__: we can copy by reference

print(p4==p5)
#2 ways to return true
##1. uncomment __new__ overload: which is basically the same object at the same memory location so equal is true
##2. comment p5 and overload __eq__: define once the value of x and y are the same it's equal
##   we can try as below
p5.name="p5"
print(p4==p5)


class StraightLine:
    def __init__(self, PointA = None, PointB = None, anotherStraightLine = None):
        if(anotherStraightLine != None):
            self.PointA = anotherStraightLine.PointA
            self.PointB = anotherStraightLine.PointB
            self.__computeGradientAndIntercept()
            return
        if(PointA != None and PointB != None):
            self.PointA = PointA
            self.PointB = PointB
            self.__computeGradientAndIntercept()
        elif(PointA != None):
            self.PointA = PointA
            self.PointB = Point2D(0,0)
            self.__computeGradientAndIntercept()
        elif(PointB != None):
            self.PointA = Point2D(0,0)
            self.PointB = PointB
            self.__computeGradientAndIntercept()
    

    def __str__(self):
        result = ""
        if(self.PointA is not None and self.PointB is not None):
            result = result + "StraightLine object: \n"
            result = result + "PointA: " + self.PointA.__str__() +"\n"
            result = result + "PointB: " + self.PointB.__str__() + "\n"
            result = result + "Line equation: " + str(self.Gradient) + "x " 
            if(self.Intercept >= 0):
                result = result + "+ "
            result = result + str(self.Intercept)
        else:
            result = "PointA or PointB (or both) are null"
        return result

    def __eq__(self, anotherStraightLine):
        if(anotherStraightLine is None):
            return False
        result = False
        if(self.Gradient == anotherStraightLine.Gradient and self.Intercept == anotherStraightLine.Intercept):
            result = True
        return result

    def __computeGradientAndIntercept(self):
        if(self.PointA is not None and self.PointB is not None):
            x1 = self.PointA.x
            x2 = self.PointB.x
            y1 = self.PointA.y
            y2 = self.PointB.y
            if(x2 - x1 != 0):
                self.Gradient = (y2 - y1) / (x2 - x1)
                self.Intercept = y1 - self.Gradient * x1
            else:
                self.Gradient = float("nan")
                self.Intercept = float("nan")
print("\n Straight Line:")
#try default constructor and print
Line43=StraightLine(PointA=p4,PointB=p3)
Line34=StraightLine(PointB=p4,PointA=p3)
print(Line34)
#try __eq__constructor
print(Line43==Line34)

class LineSegment(StraightLine):
    def __init__(self, PointA = None, PointB = None, anotherLineSegment = None):
        if (anotherLineSegment!=None):
            if isinstance(anotherLineSegment,LineSegment):
                self.PointA=anotherLineSegment.PointA
                self.PointB=anotherLineSegment.PointB
                self._StraightLine__computeGradientAndIntercept()
                return
        else:
            super().__init__(PointA=PointA, PointB=PointB)
        self.norm=sqrt(pow(self.PointA.x - self.PointB.x, 2) + pow(self.PointA.y - self.PointB.y, 2))

    def __str__(self):
        result=super().__str__()
        result=result+"\nLineSegment object, specialisation:\n"
        result=result+"Norm: "+str(self.norm)
        return result
    def __eq__(self, anotherLineSegment):
        return(super().__eq__(anotherLineSegment)and self.norm==anotherLineSegment.norm)

print("LineSegment:")
LineSegment43=LineSegment(PointA=p4,PointB=p3)
LineSegment34=LineSegment(PointA=p3,PointB=p4)
LineSegmentNew=LineSegment(anotherLineSegment=LineSegment34)
print(LineSegment34)
print(LineSegment34==LineSegment43)

print("hi")