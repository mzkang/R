###Casting###
#object type의 전환

a = matrix(1:10,5,2)
a[c(1,3,5),]
a[c(T,F,T,F,T),] #df도 가능한 indexing


##matrix -> vector
c(a) 
str(c(a))
drop(a[,1,drop=F])     
str(a[,1,drop=F])


##df -> matrix
a = data.frame(1,2)
a
b = as.matrix(a)
b
class(b)

a = data.frame(v1 = 1,v2 = "a")
a
b = as.matrix(a)
class(b)
b  # 오토캐스팅 : 1이 chr가 됨(matrix는 원소의 type이 모두 같아야 함)


##colnames, rownames
#matrix의 colname, rowname변경
a = matrix(1:10, 5,2)
colnames(a) <- c('x1','x2')
a
rownames(a)
rownames(a) <- c('r1','r2','r3','r4','r5')
a
 #r1~r5와 같이 연속된 숫자 쉽게 만들기
paste0('r',1:5) #paste0 = paste(...,sep = '')
rownames(a) <- paste0('a',1:5)
a
#df의 colname, rowname변경
b = as.data.frame(a)
colnames(b)
names(b) #df = list라서 list의 이름을 알아내는 방법과 동일
names(b) <- c('v1','v2')
names(b)


##df -> list
b = unclass(b)
class(b)
b






##조건문, 반복문
x=0
for (i in 1:3){
  x = x + i
  }
x
i

x=0
for (i in 1:3){     # outer loop
  for (j in 1:2){   # inner loop
    x = x + i + j
  }
  print(x)
}


## control the loop
# next
x=0
for (i in 1:5){
  x= x+i
  if (i %% 2 == 1){
    next} 
  print(x)
  }
  

#hw : stop, break










##function : 코드의 양을 줄이려고 만듦
##사용자 정의 함수
test.f <- function(x1,x2)
{
  v = x1^2 + x2  # 함수를 만들 때엔 선언된 변수만 사용할 것을 권함 
  return(v)      
}
print(test.f) # 함수 내용 보기

x1=1
x2=2
test.f(x1=3, x2=4)
x1    # 함수에서 정의된 변수는 함수 안에서만 유의미함
x2
test.f(x1,x2)
test.f(x2,x1)
test.f(x1 = x2, x2 = x1) # 앞쪽 변수는 함수 안에서의 변수(위치를 지정) 
                         # / 뒤쪽은 일반적 변수(global variable)
test.f(x1 = 2, x2 = 1)


##return은 break, stop의 역할이 포함되어 있음
# return하고 끝
test.ff <- function(x1,x2)
{
  v1 = x1^2 + x2
  v2 = x1^2 - x2
  return(c(v1,v2))
  v3 = 3
  return(v3)
}
test.ff(3,1) #v3는 return 안됨. 앞에 return 실행되고 끝남


# example : column average function
scol_mean <- function(x)
{
  if (class(x) != 'matrix') 
    stop("x is not matrix")
  v = rep(0, ncol(x))
  for (i in 1:ncol(x)) 
  {v[i] = mean(x[,i])}
return(v)
}

x= matrix(1:10,5,2)
scol_mean(x)
x= matrix(1:30,6,5)




##path
CO2
View(CO2)
getwd()
setwd('./R')
save.image('저장할 이름')
load('불러올 파일')

##CO2 데이터 csv로 저장하기, 불러오기
write.csv(CO2, file = 'CO2.csv')
write.csv(CO2, file='CO2.csv',
          row.names = F)
write.table(CO2, 'CO2_Table.csv',
            row.names = F,
            sep='~')
read.csv('CO2_Table.csv',  #read.csv는 
         sep='~')          #read.table의 sep가 ,로 default된 경우
read.table('CO2_Table.csv', sep='~')



##read.table 옵션 

str(CO2)


coco2 <- read.csv('CO2.csv', header = T) #stringAsFactor=F를 안하면
str(coco2)                               #chr가 모두 factor가 됨 
co2 <- read.table('CO2.csv', header = T, sep=',',
                  stringsAsFactors = F)
str(co2)


cococo2 <- read.table('CO2.csv', header = T, sep=',',
                      stringsAsFactors = F,
                      colClasses = 
                        c('character', 'factor', 'factor',
                          'integer', 'numeric')) 
                        #colClasses로 데이터타입을 모두 지정할 수 있음
str(cococo2)

read.table('CO2.csv', sep=',', header = T,
           stringsAsFactors = F,
           colClasses = 
             c('character', 'factor', 'factor',
               'integer', 'numeric'),
           nrow = 5)  #row개수 : 5개만 꺼내라

##제목 빼고 앞에 있는 몇 개의 행 제외하기
co2_5 <- read.table('CO2.csv', sep=',', header = F,
           stringsAsFactors = F,
           colClasses = 
             c('character', 'factor', 'factor',
               'integer', 'numeric'),
           nrow = 5,
           skip = 2)  
head <- read.table('CO2.csv', sep=',', header = F,
                   stringsAsFactors = F,
                   nrow = 1)
head
str(co2_5)
colnames(co2_5) = head
co2_5



##엑셀 읽어오기
install.packages('xlsx')
library(xlsx)
install.packages('rJava')
library(rJava)



##
list.files() # 현재 작업하고있는 working directory안의 파일을 보여줌
a = list.files()
a[1]

list.dirs(recursive = F) #하위 폴더


