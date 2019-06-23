library("GA")
library("tidyverse")
vignette("GA")


obj <- function(x) {
  x1=x[1]
  x2=x[2]
  x3=x[3]
  x4=x[4]
  x5=x[5]
  x6=x[6]
  x7=x[7]
  a=(0.7858*3.3333)*x1*(x2**2)*(x3**2)
  b=(0.7854*14.9334)*x1*(x2**2)*x3
  c=(0.7854*43.0934)*x1*(x2**2)
  d=1.508*(x1*(x6**2)+x1*(x7**2))
  e=7.4777*(x6**3+x7**3)
  f=0.7854*((x4*(x6**2))+(x5*(x7**2)))
  return (a+b-c-d+e+f)
}
# x=c(3.5,0.7,17,7.3,7.715333,3.350252,5.286669)
# x[7]
# obj(x)

c1<-function(x){
  (27/(x[1]*(x[2]**2)*x[3]))-1
}
c2<-function(x){
  (397.5/(x[1]*(x[2]**2)*(x[3]**2)))-1
}
c3<-function(x){
  ((1.93*x[4]**3)/(x[2]*x[3]*(x[6]**4)))-1
}
c4<-function(x){
  ((1.93*x[5]**3)/(x[2]*x[3]*(x[7]**4)))-1
}
c5<-function(x){
  (745**2)*(x[4]**2)/((x[2]**2)*(x[3]**2))-(110**2)*(x[6]**6)+16.9*(10**6)
}
c6<-function(x){
  (745**2)*(x[5]**2)/((x[2]**2)*(x[3]**2))-(85**2)*(x[7]**6)+157.5*(10**6)
}
c7<-function(x){
  (x[2]*x[3])-40
}
c8<-function(x){
  5*x[2]-x[1]
}
c9<-function(x){
  x[1]-12*x[2]
}
c10<-function(x){
  1.5*x[6]-x[4]+1.9
}
c11<-function(x){
  1.1*x[7]-x[5]+1.9
}


#penalised fitness function, <=0
fitness<-function(x)
{
  f<- -obj(x)
  #pen <- sqrt(.Machine$double.xmax)
  #pen<-0.00001
  pen<-50000
  cons1=max(c1(x),0)*pen
  cons2=max(c2(x),0)*pen
  cons3=max(c3(x),0)*pen
  cons4=max(c4(x),0)*pen
  cons5=max(c5(x),0)*pen
  cons6=max(c6(x),0)*pen
  cons7=max(c7(x),0)*pen
  cons8=max(c8(x),0)*pen
  cons9=max(c9(x),0)*pen
  cons10=max(c10(x),0)*pen
  cons11=max(c11(x),0)*pen
  f-cons1-cons2-cons3-cons4-cons5-cons6-cons7-cons8-cons9-cons10-cons11
}




#part 1: One run GA in R with graph
ga_res1 <- de(type = "real-valued", fitness = fitness, 
              lower = c(2.6, 0.7, 17, 7.3, 7.3, 2.9, 5.0), 
              upper = c(3.6, 0.8, 28, 8.3, 8.3, 3.9, 5.5),
              elitism = 2,keepBest=TRUE)

summary(ga_res1)
plot(ga_res1)

GAsum<- data.frame("iter"=ga_res1@iter,"x"=ga_res1@solution, "minf(x)"=-ga_res1@fitnessValue)
GAsum


#part 2: 10 run table
df <- data.frame(matrix(ncol = 5, nrow = 0))
x1 <- c("iter", "x1","x2","x3","x4","x5","x6","x7","minf(x)","CPU(time)")
val=list()
for (i in 1:10){
  start_time <- Sys.time()
  ga_res <- de(type = "real-valued", fitness = fitness, 
                lower = c(2.6, 0.7, 17, 7.3, 7.3, 2.9, 5.0), 
                upper = c(3.6, 0.8, 28, 8.3, 8.3, 3.9, 5.5),
                elitism = 2,keepBest=TRUE)
  end_time <- Sys.time()
  tdif <- end_time - start_time
  df=rbind(df,c(ga_res@iter,ga_res@solution,-ga_res@fitnessValue,tdif))
  vec<-vector()
  for (j in 1:100){
    vec[j]=obj(ga_res@bestSol[[j]])
  }
  val[[i]]=vec
}
colnames(df) <- x1
name=c(1:10)
valdf <- as.data.frame(val)
colnames(valdf)<-name

colors<-rainbow(20)
plot(valdf[,1],type = "o",col=colors[1],ylab='')
for(i in 1:9){
  lines(valdf[,i], type = "o", col =colors[2*i])
}

