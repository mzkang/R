#1.matrix 만들기 
m <- rep(0,10)
n <- rep(0:1,5)
length(rep(c(m,n),10))
matrix(rep(c(m,n),5),10,10)


x <- rep(0, 1000)
y <- rep(0:1, 500)
a <- matrix(rep(c(x,y),500),1000)




#2.벡터를 넣으면 누적합을 계산하는 함수 my_csum
my_csum <- function(v){
  u = rep(0, length(v))
  for (i in 1:length(v)){
    u[i] = sum(v[1:i])
  }
  return(u)
}
my_csum(1:5)





#3. 큰수의 법칙
?rnorm
?runif

random <- runif(1000, 0 ,1)
x <- 1:1000
y <- my_csum(random[x])/x
plot(y~x, type='l', xlab = '1:1000', ylim = c(0.4,0.7))
?plot



