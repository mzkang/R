#2018-06-28

##G-Graphics tool: part1
# <Plotting points>


str(mtcars)
unique(mtcars$cyl)
mtcars$cyl = factor(mtcars$cyl)
str(mtcars)


names(mtcars)
mpg
mtcars$mpg
attach(mtcars) # $를 붙이지 않고 variable만으로도 데이터를 불러올 수 있음 
mpg       # 그러나 변수 이름이 중복될 수 있으므로 사용하지 않을 것을 권함
detach(mtcars)
mpg




## plot : df에서 작업
plot(mpg ~ disp, mtcars)
a = 'mpg ~ disp'
plot(a, mtcars)
a_f = as.formula(a)
class(a)
class(a_f)
plot(a_f, mtcars, col = 'red')
?plot


plot(hp ~ disp, mtcars)
summary(lm(hp ~ disp, mtcars)) ###회귀분석 설명###



## rnorm, main, xlab, ylab
set.seed(1)
x=rnorm(100)
y = 2 + 2*x + rnorm(100)
plot(x,y, main = 'plot (x-y)')



## type
x=seq(-2,2, length=10)
y=x^2
plot(x,y, type='p') # point
plot(x,y, type='n') # nothing
plot(x,y, type='l') # line
plot(x,y, type='b') # point, line
plot(x,y, type='s') # step



## lty : line type / pch : point 종류
plot(x,y, type='b', lty=3) 
plot(x,y, type='b', lty=4)

plot(x,y, type='b', pch=19)
plot(x,y, type='b', pch=2)

plot(x= 1:25, y=rep(0,25), pch=1:25) #pch 1~25번 
plot(x= 1:30, y=rep(0,30), pch=1:10) #pch는 반복



## col : 색
colors()[1:100]    # color 종류


 
## drawing multiple plots : 산점도 여러개 그리기
plot(~mpg+disp+drat, mtcars,
     main = 'Simple Scatterplot Matrix')








# <Add lines and points>
# 만들어진 그림에 덧칠하기

## abline
x = rnorm(100)
y = 1+2*x + rnorm(100)
plot(x,y,pch=20, main ='scatter plot')

abline(a=1, b=2, col='red')
abline(v = 1, col = 'blue')
abline(h = 1, col = 'green')



## points
plot(x=1, y=1, type= 'n', 
     xlim = c(0,10), ylim = c(0,5),
     xlab = 'time', ylab = '# of visiting') #도화지
x = 0:10
set.seed(1)
y = rpois(length(x), lambda = 1) #포아송 분포로 랜덤 숫자 뽑기
points(x,y, col='blue', type='s')
points(x,y, col='red', type='l')
points(x,y, pch=1:11)

## lines
plot(0,0, type = 'n', xlim=c(-2,2), ylim=c(-2,2))
x = c(-2,1,0,1,0)
y = c(0,-1,2,-2,1)
lines(x,y)   #순서대로 연결. lines 쓰기 전엔 정렬이 필요!

 #선을 끊어내고 싶으면 NA 사용
plot(0,0, type = 'n', xlim=c(-2,2), ylim=c(-2,2))
x = c(-2, 1, NA, 1, 0)
y = c(0, -1, NA, -2, 1)
lines(x,y)



##
plot(0,0,type='n', xlim=c(1,5), ylim = c(0,2))
x = seq(1,5, by=1)
abline(v = x, lty = 1:length(x))







## legend : 범례 만들기
z= sort(rnorm(100))
z # sort로 정렬됨
y1 = 2 + x + rnorm(100)
plot(z, y1, col = 'blue', pch = 3)
points(z, y1/2, col = 'red', pch = 19)
legend('bottomright', c('A-group', 'B-group'), 
       col = c('blue','red'), pch = c(3, 19), cex = 1)






# <Graphic parameter:par()>
## par : parameter 조정
par(mfrow = c(2,2), bg = 'gray50', col = 'white',
    col.main = 'lightgreen', col.axis = 'yellow',
    col.lab = 'lightblue')  # 해석할 줄 알기 



# <k-nearest neighborhood>
## regression
set.seed(1)
x <- sort(rnorm(100))
y<- 3+x^2 + rnorm(100)
par()
plot(x,y,pch=20)
fit <- lm(y~x)
str(fit)
coef <- fit$coefficients
coef[2]
abline(a = coef[1], b = coef[2],
       col='red') #적합하지 않음. model-bias가 큼

## KNN 이용해서 model-bias 줄이기
install.packages('FNN')
library(FNN)
x
a <- knnx.index(x, 0, k=10) # x값 중 0에 가까운 10개의 위치 추출
a
x[47]
x[46]
idx = a[1,] # vector
points(x[idx], y[idx], pch = 19, col = 'red')
abline(v=0, lty = 3, col = 'red2')
mean(y[idx]) # x=0에서 y의 추정치
abline(h=mean(y[idx]), lty = 3, col = 'red2')
