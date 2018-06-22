
##큰 수의 법칙
set.seed(1)
n=1000000
x = runif(n)
x[1]
x>0.5
x[x>0.5]
sum(x>0.5)
length(x[x>0.5]) /n

##추출, 인덱싱 
y=x[F]
length(y)  #주의


##NA 있을 때의 추출 결과 
x=c(11:14, NA, 15:18)
x
x<=14
which(x<=14)
x[which(x<=14)]
x[x<=14] #NA도 추출




##%in%는 논리값을 반환 
x=c(3,1,4,1)
x %in% c(2,1,4)
x[x %in% c(2,1,4)]



##matrix에서 열이나 행이 1개만 남으면 vector가 됨 
y=matrix(c(1,3,4,5,1,3,4,1),4)
class(y)
class(y[,1])
class(y[,1, drop = F]) #데이터 형식을 유지하고 싶으면 drop옵션 사용


z = matrix(c(5:8, rep(-1,4), rep(0,4)), nr=4)
z
cbind(1,z)
cbind(c(1,2), z)


##오토캐스팅(데이터 형태의 변화-빨리 찾기 위해 그릇의 size를 같게 만듦)
#vector, matrix는 오토캐스팅으로 모든 원소가 같은 형태임
#다양한 형태의 데이터를 관리하기 위해 -> data frame이 나옴
x=1:10
x
x[1] ='a'
x

x=matrix(1:4,2,2)
x
x[1]='a'
x


##data frame
kids = c('Jack', 'Jill')
ages = c(12, 10)
d= data.frame(kids, ages, stringsAsFactors = F)
d
str(d)

d= data.frame(x1 = kids, x2 = ages,   #variable의 이름 변경 
              stringsAsFactors = F)
names(d)

##data frame에서 rbind는 variable을 따라감 
A = data.frame(x1 = rep(0,10),
               x2 = rep(1,10))
B = data.frame(x2 = rep(0,10),
               x1 = rep(1,10))
rbind(A,B) #variable name이 다르면 error 




##list = not array
j = list(names='joe',
         salary=c(55000,1),  #names,union과 salary의 개수가 달라도 됨 
         union=TRUE)
j
jn = list( 'joe', 55000, TRUE)
jn

##list chain 개수 미리 정하기 
jini = vector(mode = 'list', length = 10)
jini

##list indexing
j = list(names=c('joe','nick'),
         salary=matrix(1:4,2),  
         union=TRUE)
j
j[['salary']][,2,drop=FALSE]
j[['salary']][,2]


##list에서 chain 지우기 
j$salary = NULL #NULL값을 주는게 아니고 chain 자체가 사라짐
j



##data frame은 list다?!
d[1]
class(d[1])
class(d[[1]])
d$add = c('a','b')
d
d$kids = NULL
d
#data frame은 특히 행을 참조할 때 느림
#사이즈가 큰 df는 matrix로 바꿔서 분석해야 함


##cf
a = c('jack','jill','nick','richard')
a[c(2,1,1,3)] #참조할 때 연속되거나 unique할 필요X







##factor
str(a)
af <- factor(a)
af
str(af)
levels(af) #factor는 level을 가지고 있음

a=c('jack','jill','nick','richard',
    'jack','richard')
af <- factor(a)
af
as.numeric(af)
b=c('a','b','c')
b[af[5]]  #factor는 chr로 보이지만 실제는 int 값이라는 사실을 알 수 있음 
          ###따라서 factor를 이용해서 slicing을 할 수 있음###


cand = c('jack','jill','nick','richard')
a = c('jack','nick','richard','jack','richard')
table(a) #jill이 0개라는 정보가 없음
af = factor(a, levels = cand)
table(af) #0 counting을 반영하기 위해서는 factor가 유용
          #but 가지고 있는 factor를 다 알고 있어야 함



