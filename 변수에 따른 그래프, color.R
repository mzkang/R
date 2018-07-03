#<Visualization of K-nearest neighborhood method>
library(FNN)
set.seed(1)
x<-sort(rnorm(100))
y<-3+x^2+rnorm(100)
plot(x,y,pch=20)
knnx.index(x,0,k=10)
idx <- c(knnx.index(x,10,k=10))
class(idx)
class(knnx.index(x,10,k=10)) # matrix로 나옴

eval.n = 100
eval.point = seq(-3,3,length=eval.n)
plot(x,y,pch=20)



## 3차원 plotting
#image
a = matrix(1:25,5,5)
image(a)        # ggplot에서 tile
a               # 작은 값은 빨강, 큰 값일수록 흰색 
                # 4행5열 숫자는 (4,5)에 표시 : 행이 x좌표, 열이 y좌표


x= c(2.1, 2.3, 2.7)  
y= c(0.1, 0.5, 0.7, 0.8, 0.85)  # increasing 함수여야 함(축을 구성할 거라서)
z = matrix(1:15, 3,5)
image(x,y,z)  # 등분한 것이 아니라 위에서 지정한대로 tile을 구성



#persp
z <- 2 * volcano
x <- 10 * (1:nrow(z))
y <- 10 * (1:ncol(z))
persp(x, y, z, theta = 135, phi = 30, col = "green3", scale = FALSE,
      ltheta = -120, shade = 0.75, border = NA, box = FALSE)
persp3d(x, y, z, col = "green3")





#=========================================================================


# <EDA : Frequency of univariate variable>

### 범주형 변수 1개 ###

## barplot(table) 
#
state.region
table(state.region)
counts <- table(state.region)
barplot(counts, main = 'simple bar chart',      # 도수
        xlab= 'region', ylab='freq')
barplot(counts/sum(counts), main = 'simple bar chart',   # 상대도수
        xlab = 'region', ylab= 'freq')

#
counts_cyl <- table(mtcars$cyl)
counts_cyl
barplot(counts_cyl, main = 'bar chart',   # 도수 
        xlab = 'cyl', ylab = 'freq')

cyl.name = c('4 cyl','6 cyl','8 cyl')
barplot(counts_cyl/sum(counts_cyl), names.arg = cyl.name)     # 상대도수 


## pie chart
rel.cyl = counts_cyl/sum(counts_cyl)
rel.cyl = round(rel.cyl, 3)
sum(rel.cyl) # 1보다 커서 rel.cyl에서 남는 값만큼 빼주자
             # 임의의 규칙 : 값이 가장 큰 항목을 바꾸자 
if ((sum(rel.cyl)-1) != 0){
  d = sum(rel.cyl) - 1
  rel.cyl[which.max(rel.cyl)] =     # which.max() : 제일 큰 값의 위치 확인
    rel.cyl[which.max(rel.cyl)] - d 
}
sum(rel.cyl)
pie(rel.cyl)
cyl.name
cyl.name2 = paste0(cyl.name, "(", rel.cyl * 100 ,"%)")
cyl.name2
pie(rel.cyl, labels = cyl.name2,  #piechart의 labels = barchart의 names.arg
    col = rainbow(length(rel.cyl)), main = 'pie chart') 





### 범주형 변수 2개 ###
install.packages('vcd')
library(vcd)
my.table <- xtabs( ~ Treatment + Improved, data = Arthritis)
my.table
barplot(my.table, legend.text = T,
        col = c('red','yellow'))
?xtabs
barplot(t(my.table), legend.text = T,
        col = c('white','yellow','red'))   # 도수


my.table<-t(my.table)
sum <- c(sum(my.table[,1]), sum(my.table[,2]))
my.table / rep(sum, each=3)
rel.table <- my.table / rep(sum, each=3)
barplot(rel.table, legend.text = T,
        col = c('white','yellow','red'))    # 상대도수



#-------------------------------------------------------------------------


### 연속형 변수 1개 ###
x = faithful$waiting
fit = density(x)
fit
str(fit)
hist(x, probability = T)
lines(x= fit$x, y = fit$y, col = 'red',lwd =2) # pdf추정량 



#==========================================================================


# <R color>

##
heat.colors(4,alpha = 1)  # 4개의 파레트 생성. 처음이 흰색(높은 수)
rev(heat.colors(4,alpha = 1))  # 마지막이 흰색

x <- 10*(1:nrow(volcano))
y <- 10*(1:ncol(volcano))
image(x,y,volcano, col = rev(heat.colors(20, alpha = 1)), axes = F)
contour(x,y,volcano, levels = seq(90,200, by =5),
        add = T, col = 'white') # 등고선 



