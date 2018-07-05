# <Data Processing : 데이터 전처리(dplyr)>

rm(list = ls()); gc(reset = T)

## indexing 및 filtering을 통한 데이터 정리
# df에서 열 추출하기
surveys <- read.csv('surveys.csv', header = T)
head(surveys)
names(surveys)
surveys[,c(5,6,9)] # 의미를 알 수 없는 코딩. 열이 추가 되면 잘못 추출하게 됨.
match(c('plot_id','species_id','weight'), names(surveys)) # 복잡
surveys[c('plot_id','species_id','weight')] # df가 list이므로 list slicing 사용

# df에서 행 추출하기
str(surveys)
surveys[surveys$year == 1995,]
head(surveys[surveys$year == 1995,])

# 둘다 추출할 때, 서로 다른 두 경우
surveys[surveys$weight<5, c("species_id", "sex", "weight")]  # NA를 출력
surveys[which(surveys$weight<5), c("species_id", "sex", "weight")]

# 새로운 열 추가
surveys_ex <- surveys
surveys_ex$weight_kg <- surveys_ex$weight/1000      
surveys_ex <- surveys_ex[!is.na(surveys_ex$weight_kg),]
head(surveys_ex)

#--------------------------------------------------------------------------------------

## 평균 계산하기
u = unique(surveys$sex)
length(u)
u  # missing 데이터가 있어서 3개임
levels(u)
u[1]
u[2]
u[3]

# 기본 : 여러번 써야해서 귀찮
mean( surveys$weight[surveys$sex == u[1]], na.rm = T )
mean( surveys$weight[surveys$sex == u[2]], na.rm = T )
mean( surveys$weight[surveys$sex == u[3]], na.rm = T )

# by함수 사용 : 기준이 여러개 일 때, INDEX array를 생성해줘야 해서 귀찮
a <- by(data = surveys$weight, INDICES = surveys$sex,  # INDEX랑 data의 길이 같아야함
   FUN = mean, na.rm = T)
a
class(a)
str(a)
unclass(a)  # unlist(a)도 똑같은 결과 나옴

# aggregate함수 : 한가지 통계량을 구할 때만 유용. 여러가지를 구할 땐 여러번 실행해야
b <- aggregate(formula = weight ~ sex, data = surveys,
                FUN = mean, na.rm = T)
str(b)

 # 기준이 2개
aggregate(formula = weight ~ sex + species_id, 
           data = surveys, FUN = mean, na.rm = TRUE) 
aggregate(formula = weight ~ sex + species_id, 
          data = surveys, FUN = sd, 
          na.rm = TRUE)  # NA가 나온 건, 데이터가 1개라는 뜻(mean은 있는데 sd가 없음)



## 
table(surveys$sex)
table(surveys$sex, surveys$plot_id)

#------------------------------------------------------------------------------------

## 재배열하기
## 정렬
a = c(10,5,3,7)
order(a) # 오름차순으로 위치 알려줌
order(a, decreasing = T) # 내림차순으로 위치 알려줌
sort(a) # 오름차순 정렬
sort(a, decreasing = T) # 내림차순 정렬

surveys[order(surveys$plot_id),] # plot_id 값의 오름차순으로 surveys 데이터 정렬

tmp <- surveys 
tmp <- tmp[order(tmp$plot_id),]
tmp <- tmp[order(tmp$month, decreasing = TRUE),] # plot_id로 오름차순, month로 내림차순 

##====================================================================================

# <dplyr> : 위에서 했던 연산이 쉬워지고, 코딩 독해도 쉬워짐. df에서 작동(matrix는 X)
library(dplyr)

## 열 추출 : select
surveys %>% 
  select(plot_id, species_id, weight) %>% 
  head()

## 행 추출 : filter
surveys %>% 
  filter(year == 1995) %>%     # attach하지 않아도 주어진 데이터에서 정의함을 안다
  head()

## 한 번에 여러개 (파생)칼럼 추가 : mutate


## 통계량 추출 : group by, summarize
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) # summarize에 있는 것만 출력

surveys %>%
  group_by(sex) %>%
  summarize(mean(weight, na.rm = TRUE))

surveys %>%
  group_by(sex) %>%
  tally()       # 빈도수


## 정렬 : arrange
surveys %>% arrange(desc(month), plot_id) %>% head()


#====================================================================================

# <reshape2>
if (!require(reshape2)) { install.packages("reshape2") ; library(reshape2) }

head(airquality)
names(airquality) <-  tolower(names(airquality))
melt(data = airquality) %>% head(n=3)
aql <- melt(data = airquality, id.vars= c("month","day"))
head(aql, n = 3)
