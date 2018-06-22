#2018-06-21 


oddcount <- function(x) {
  k <- 0
  for (n in x) {
    if (n %% 2 ==1) k <- k+1
  }
  return(k)
}


set.seed(10)
x = sample(1:200, 20)
x
x[x%%2==0]
x%%2==0
x2 = sample(1:200, 30)
x2


#또 다른 추출 방법
subset(x, x>5)

#행렬 원소 추출
y = matrix(13:18, nr=2)
y
y[3]



#연습문제
#자연수로 이루어진 임의의 행렬에서 7의 배수의 갯수를 구하는 함수를 구현해라
#답
set.seed(2)
a=matrix(sample(1:100,20), nr=5)
seven = function(y){
  q=y%%7
  return(sum(q==0))              #sum(논리값)은 T=0, F=0으로 계산
}
seven(a)
a


#F(female), M(male), I(infant)로 구분된 데이터가 있을 때,
#M->1, F->2, I->3으로 각각 변환하는 코드 작성
change <- function(x){
  ifelse(x=='M', 1,
         ifelse(x=='F',2,3))    #벡터계산은 if보다 ifelse가 더 유용
}                               #if는 for문을 사용해야 함 

change(c("M",'F','F','I','M'))




#F와 M을 바꾸기
g = c('M','F','F','I','M','M','F')
#답
f.index=(g=='F')
m.index=(g=='M') #먼저 인덱스 자리를 기억해둬야 함. g가 계속 바뀌기 때문
g[f.index]='M'
g[m.index]='F'
g




#그림그리기
?iris
data(iris) #environment에 data 불러오기
str(iris)

plot(iris$Sepal.Length)
plot(x=iris$Sepal.Length, y=iris$Petal.Length,
     xlab='Sepal Length', ylab='Petal Length')

plot(iris$Sepal.Length, cex=0.5) #점크기 cex이고 default=1
plot(iris$Sepal.Length, cex=2)
plot(iris$Petal.Length, pch=18) #점모양
plot(iris$Sepal.Length, pch=19, col=8)
plot(iris$Sepal.Length, type='line')
par(mfrow=c(2,2)) #한 창에 여러개의 그래프 그리기
plot(iris$Sepal.Length, col=2, type='l', lty=2) #lty=line type
plot(iris$Sepal.Length, col=3, type='l', lwd=3) #line 굵기 

par(mfrow=c(1,1))
plot(x=iris$Sepal.Length, y=iris$Sepal.Width,
     xlab='Length', ylab='Width')
points(iris$Petal.Length,iris$Petal.Width, col=2, pch = 16, cex=1.5)
legend('bottomright', 
      legend=c('Sepal','Petal'), pch=c(1,16), col=1:2) #범례 


hist(iris$Sepal.Length, breaks=20, 
     freq=F) #freq=F로 하면 확률이 나옴



