#----------------
# 통계적 모형
#----------------
exp(2)
exp(3.1)
exp(sqrt(2))
exp(2^0.5)
x = seq(-1,1, length = 100)
b0 = -1
b1 = -2
y = exp(b0 + x*b1)
plot(x,y,type='l', ylim = c(0,5))
abline(h=0, lwd = 2)
abline(v=0, lwd = 2)

set.seed(1)
X <- matrix(runif(15),5,3)
X[3,2]
X[,2,drop=F]
X[4,,drop=F]
Xt = t(X)
X[3,2]
Xt[2,3]
A = Xt %*% X
B = solve(A)   # 역행렬
A %*% B        # 역행렬 확인 
B %*% A

a = matrix(runif(3),3,1)
aa = t(a) %*% a
XX = t(X) %*% X
b = solve(XX)
t(a) %*% b %*% a


x = matrix(c(1,0,1/2),3,1)
x
mu = matrix(c(0,1,-1),3,1)
cov_mat = matrix(c(1,0.5,0,0.5,1,0.3,0,0.3,1),3,3)
cov_mat
exp((t(x-mu) %*% solve(cov_mat) %*% (x-mu))/-2)

x = seq(0,10, length=1000)
y = ppois(x, lambda = 3)
plot(x,y, type = 's')
abline(h=1, col = 'red', lty=2)




par(mfrow=c(1,2))
x = seq(0,10, length=1000)
y = dgamma(x, shape = 2, scale = 0.5)
plot(x,y, ylim = c(0,0.8))
z = dgamma(x, shape = 8, scale = 0.5)
plot(x,z, ylim = c(0,0.8))


det(t(X) %*% X)


#------------------------------------
# 회귀분석과 우도함수
#------------------------------------

x= seq(0,1,length=100)
y= log(x/(1-x))
plot(x,y,type='l')


z = seq(-10,10,length = 1000)
y = exp(z)/(1+exp(z))
plot(z,y,type='l')


#-------------------------------------
# 통계 모형 선택
#-------------------------------------
n = 1000
testResult <- rep(0,n)
for (i in 1:n)
{
  x <- rep(0,20)
  for (j in 2:20) x[j] <- 0.9*x[j-1] + rnorm(1)
  testfit <- t.test(x,mu=0)
  testResult[i] <- testfit$p.value
}
mean(testResult>0.05)



#------------------------------------
# 확률 분포의 표현
#------------------------------------
x <- rnorm(200)
x
summary(x)
var(x)
sd(x)
hist(x, xlim = c(-3,3))
boxplot(x)
abline(h=0, col = 'red')

sum( x>0 )  # x에서 0보다 큰 수의 개수를 count
sum( (x>0) & (x<=1) )  # count
 # 히스토그램이 비슷 = 데이터의 패턴이 비슷 
  # = 임의의 구간에 들어가는 데이터의 상대빈도가 비슷 = 분포가 같음

y <- rgamma(200,2,8)
y
summary(y)
sd(y)
hist(y, xlim = c(0,10))
boxplot(y)
abline(h = 0, col = 'red')
sum( (y>1) & (y<=2) )/200
sum( (y>3) & (y<=5) )/200


n = 1000000
x = rgamma(n,2,1)
hist(x, nclass = sqrt(n), 
     col = 'darkblue',
     probability = T)
?hist
mean((x>3)&(x<=5))    # 상대 빈도 확인 
                      # 숫자가 2개 있어야 함. 1개로 줄이자
                      # 왼쪽 경계를 -Inf로 지정해놓자
                      # 그러면 함수로 표현이 가능해짐 -> cdf 




# cdf 그리기 (패턴을 확인하는 방법)

n=200
x = rgamma(n,2,1)
mean( (x>-Inf) & (x<=3) )    # cdf = 패턴을 나타내는 함수
z = seq(0,10,length = 1000)
y = c()

for (i in 1:length(z)) 
{
  y[i] = mean( (x> -Inf) & (x<=z[i]) )
}

y
plot(z, y, type = 'l')

n=200
x = rgamma(n,2,8)
z = seq(0,10,length = 1000)
y = c()

for (i in 1:length(z)) 
{
  y[i] = mean( (x> -Inf) & (x<=z[i]) )
}

lines(z,y,col='red')



#--------------------------------------
# 확률의 계산
#--------------------------------------

pnorm(2, mean=0, sd = 2)
pnorm(1, 0 ,2)
pnorm(2, mean=0, sd = 2) - pnorm(1, 0 ,2) # 확률 구하기


pgamma(2, 1, 1)
pgamma(1, 1, 1)
pgamma(2, 1, 1) - pgamma(1, 1, 1) # 확률

1 - pgamma(2, 1, 1)
pgamma(2, 1, 1, lower.tail = F)




#-------------------------------------
# 변수 변환 이후 분포의 변화
#-------------------------------------
n=1000000
x = rnorm(n)
y = rnorm(n)
xy = x*y  # x,y 각각의 패턴을 알더라도 
hist(xy)  # x+y, x*y, x/y 의 패턴은 다시 확인해야 함
xx = x^2
hist(xx)  # 카이제곱 분포
x_y = x/y # 코시 분포(자유도 1인 t분포)
summary(x_y)
hist(x_y, 
     breaks = seq(-1000,1000,10),
     probability = T,
     slim = c(-1000,1000))


#--------------------------------
# 회귀모형 만들기 : 두 개 이상의 자료 패턴 분석
#--------------------------------
x = rgamma(200, 2, 1)
ep = rnorm(200)  # 오차 
y = 1 + x + ep   # y = 1 + x + ep이라 함

 # 다음을 관찰된 데이터라 가정
x
y
plot(x,y)

 #-----------------------------
x1 = rgamma(200, 2, 1)
x2 = rgamma(200, 2, 1)
ep = rnomr(200)
y = 1 + x1 + ep  # y = 1 + x1 + ep이라 함

plot(x1, y)
plot(x2, y)
 
 # 더 복잡---------------------
n = 200
p = 10
x = matrix(rgamma(n*p, 1, 2), n, p)
b = rep(0, p)
b[3:4] = c(1.5, -1)
b
head(x)
x %*% b    # matrix x의 col vector에 대한 linear combination
y = 1 + x%*%b + rnorm(n)   # x가 y에 영향을 주는 좀 더 복잡한 모형


plot(x[,3],y)  
plot(x[,4],y)  
plot(x[,1],y)   # 어떤 변수가 y에 영향을 주는지 아는 방법 
                # -> 모형 선택 : 전진법, 후진법
                # -> lm 도움 받기

rdata = data.frame(y=y, x=x)
rdata
names(rdata)

lm(y~1, data = rdata)
lm(y~1+x.1, data = rdata)
lm(y~1+x.2, data = rdata)
lm(y~1+x.3, data = rdata)
lm(y~1+x.4, data = rdata)
lm(y~1+x.1 +x.2, data = rdata)
lm(y~1+x.1 +x.2+x.3, data = rdata)

fit = lm(y~1, data = rdata)
fit = lm(y~1+x.1+x.2+x.5, data = rdata)
fit = lm(y~1+x.3, data=rdata)
fit = lm(y~1+x.4, data=rdata)
fit = lm(y~1+x.10, data=rdata)
str(fit)  # rersiduals : 데이터와 예측값의 차이(like 편차)
sum(fit$residuals^2)  # (유클리드 거리)^2 
                      # 관련없는 x.1, x.2, x.5...라도 추가하면 residual이 줆
                      # 따라서 그냥 줄어들기만 하는 건 의미X
                      # 줄어드는 정도를 확인해야 함
                      # x.4가 제일 많이 줄어들었으므로 x.4를 선택
                      # 영향을 주는 변수를 0~10개까지 지정한 모델을 만들면
                      # -> 그것을 '부모형'이라 함 (11개 나옴)
                      # 부모형 중 모델 하나를 선택하는 방법이 있음
                      # cross validation, criteria 등 

lm(y~1+x.3+x.4+x.5, data=rdata)  # x.5가 0이면 좋겠지만 값이 나타남
                                 # n을 늘려서 확인하자 (data를 늘리자)
                                 # -> 점점 실제 값과 비슷해짐



#------------------------------------
# 훈련 데이터와 예측 데이터
# validation set 이용한 모델 평가
#------------------------------------
 # 위에서 훈련 데이터 만들었음(rdata) -> 활용해서 모델 생성
 # 그 모델이 잘 작동하는지 예측 데이터(vdata)로 확인
n = 100
x = matrix(rgamma(n*p, 1, 2), n, p)
y = 1 + x%*%b + rnorm(n)  
vdata = data.frame(y=y, x=x)
fit0 = lm(y~1, data = rdata)
fit1 = lm(y~1+x.4, data = rdata)
fit2 = lm(y~1+x.4+x.3, data = rdata)
fit3 = lm(y~1+x.4+x.3+x.5, data = rdata)

yhat = predict(fit3, newdata = vdata)  
yhat      # 예측값
vdata$y   # 정답
sum((vdata$y - yhat)^2)  # 260 -> 191 -> 104 -> 104
                         # 즉, fit2가 제일 적합


