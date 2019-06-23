library("GA")
library("tidyverse")

obj <- function(x) {
  x1=x[1]
  x2=x[2]
  return (100*(x2-x1**2)**2+(1-x1)**2)
}

#part 1: One run GA in R with graph
ga_res = ga(type = "real-valued",
  fitness=function(x) -obj(x), 
  keepBest = TRUE,
  min = c(-5,-5), 
  max = c(5,5), 
  maxiter = 200,
  popSize = 150
)
summary(ga_res)
plot(ga_res)

GAsum<- data.frame("iter"=ga_res@iter,"x"=ga_res@solution, "minf(x)"=-ga_res@fitnessValue)
GAsum


#part 2: 10 run table
df <- data.frame(matrix(ncol = 5, nrow = 0))
x1 <- c("iter", "x1","x2","minf(x)","CPU(time)")
val<-list()
for (i in 1:10){
  start_time <- Sys.time()
  ga_res = ga(type = "real-valued",
              fitness=function(x) -obj(x), 
              keepBest = TRUE,
              popSize = 150,
              min = c(-5,-5), 
              max = c(5,5), 
              maxiter = 200 
              #run=100
              )
  end_time <- Sys.time()
  tdif <- end_time - start_time
  df=rbind(df,c(ga_res@iter,ga_res@solution[1],ga_res@solution[2],-ga_res@fitnessValue,tdif))
  vec<-vector()
  for (j in 1:200){
    vec[j]=obj(ga_res@bestSol[[j]])
  }
  val[[i]]=vec
}
colnames(df) <- x1
name=c(1:10)
valdf <- as.data.frame(val)
colnames(valdf)<-name

colors<-rainbow(20)
plot(valdf[,10],type = "o",col=colors[1],ylab='')
for(i in 1:9){
  lines(valdf[,i], type = "o", col =colors[2*i])
}

