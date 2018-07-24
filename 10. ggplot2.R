rm(list = ls()); gc(reset = T)

# ----------------------
if(!require(ggplot2)){install.packages("ggplot2"); library(ggplot2)}
if(!require(reshape2)){install.packages("reshape2"); library(reshape2)}
if(!require(dplyr)){install.packages("dplyr"); library(dplyr)}

# ----------------------
head(msleep[,c(3, 6 ,11)])
head(msleep)

# ----------------------
ggplot(data = msleep, aes(x = bodywt, y = sleep_total)) + geom_point()
                                   # 너무 몰려있어서 아래에서 log취함
# ----------------------
ggplot(data = msleep, aes(x = log(bodywt), y = sleep_total)) + geom_point()

# ----------------------
scatterplot = ggplot(data = msleep, 
                     aes(x = log(bodywt), y = sleep_total, col = vore)) + 
  geom_point()
scatterplot

# ----------------------
scatterplot = ggplot(data = msleep, 
                     aes(x = log(bodywt), y = sleep_total, col = vore)) + 
  geom_point() + facet_grid(~vore)
scatterplot

# 캔버스 생성----------------------
ggplot(data = msleep, aes(x = bodywt, y = sleep_total))

# 캔버스에 점 찍기-----------------
# 앞에서 배운 plot과 같음
ggplot(data = msleep, aes(x = bodywt, y = sleep_total)) + geom_point()

# 축 변경----------------------
ggplot(data = msleep, aes(x = log(bodywt), y = sleep_total)) + geom_point()

# ggplot 객체 저장과 col 설정----------------------
scatterplot = ggplot(data = msleep, 
                     aes(x = log(bodywt), y = sleep_total, 
                         col = vore)) +     # vore는 factor / col은 aes에 써야함
  geom_point()
scatterplot

# 색깔별로 다른 그래프 만들기----------------------
scatterplot1 = ggplot(data = msleep, 
                      aes(x = log(bodywt), y = sleep_total, col = vore)) + 
  geom_point() + 
  facet_grid(~vore)  # 이전의 mfrow 역할, fomula = 행 ~ 
scatterplot1



scatterplot2 = ggplot(data = msleep, 
                      aes(x = log(bodywt), y = sleep_total, col = vore)) + 
  geom_point() + 
  facet_grid(vore~.)  # 행으로 나눠 그리기
scatterplot2


# 점 size 키우기 ----------------------
Scatterplot <- scatterplot + geom_point(size = 5) + 
xlab('Log Body Weight') +  ylab("Total Hours Sleep") + 
  ggtitle('Some Sleep Data')
Scatterplot

# ----------------------
stripchart <- ggplot(msleep, aes(x = vore, y = sleep_total)) + geom_point()
stripchart

# 위의 그래프에 몰려있는 부분을 더 잘 표현하기 위해 바꿈----------------------
stripchart <- ggplot(msleep, aes(x = vore, y = sleep_total, col = vore)) + 
  geom_jitter(position =  position_jitter(width = 0.2), size = 5, alpha = 0.5)
stripchart

# ----------------------
dane <- data.frame(mylevels=c(1,2,5,9), myvalues=c(2, 5, 3, 4))
head(dane)

# ----------------------
ggplot(dane, aes(x=factor(mylevels), y=myvalues)) + 
  geom_line(group = c(1,1,2,2)) +   # group별로 연결 
  geom_point(size=3)

# ----------------------
data(economics)
data(presidential)
head(economics)
str(economics)
head(presidential)
str(presidential)
    # 실업자 수(unemploy)가 집권당(party)에 따라 어떻게 변하는지 알고 싶음

# 시간에 따른 실업자 수 변화----------------------
ggplot(economics, aes(date, unemploy)) + geom_line()

# 2개의 그래프로 이루어짐----------------------
presidential = subset(presidential, start > economics$date[1])

ggplot(economics) + 
  geom_rect(aes(xmin = start,xmax = end, fill = party),   # 사각형 그래프 
            ymin = -Inf, ymax = Inf, data = presidential,
            col = 'black')   # col 넣으면 대통령이 바뀌는 시기를 나눔 


ggplot(economics) + 
  geom_rect(aes(xmin = start,xmax = end, fill = party),   # 사각형 그래프 
                              ymin = -Inf, ymax = Inf, 
                              data = presidential) +
  geom_line(aes(date, unemploy), data = economics)

# ----------------------
if(!require(datasets)){install.packages("datasets"); library(datasets)}
data(airquality)
plot(airquality$Ozone, type = 'l')

# 7,8,9월을 날짜별로 정렬----------------------
aq_trim <- airquality[which(airquality$Month == 7 |
                              airquality$Month == 8 |
                              airquality$Month == 9), ]
aq_trim$Month <- factor(aq_trim$Month,labels = c("July", "August", "September"))

# ----------------------
ggplot(aq_trim, aes(x = Day, y = Ozone, size = Wind, fill = Temp)) +
  geom_point(shape = 21) +   ggtitle("Air Quality in New York by Day") +
  labs(x = "Day of the month", y = "Ozone (ppb)") +
  scale_x_continuous(breaks = seq(1, 31, 5))

# ----------------------
festival.data <- read.table(file = 'DownloadFestival.dat', sep = '\t', header = T)
head(festival.data)

# ----------------------
Day1Histogram <- ggplot(data = festival.data, aes( x= day1))
Day1Histogram + geom_histogram()

# ----------------------
Day1Histogram + geom_histogram(color = 'royalblue1', fill = 'royalblue2')

# ----------------------
Day1Histogram + geom_histogram(color = 'royalblue1', fill = 'royalblue2', 
                               binwidth  = 0.1)

# ----------------------
Day1Histogram + geom_histogram(binwidth = 0.2, aes( y = ..density..), 
                               color= 'royalblue3', fill = 'yellow', bins = 35) 

# ----------------------
Day1Histogram +geom_histogram(binwidth = 0.1, aes(y=..density..), 
                              color="black", 
                              fill="lightblue") + geom_density(alpha=.2, fill="#FF6666") 

# 날짜별, 성별 festival 만족도 ----------------------
festival.data.stack <- melt(festival.data, id = c('ticknumb', 'gender'))
colnames(festival.data.stack)[3:4] <- c('day', 'score')

# ----------------------
Histogram.3day2 <- ggplot( data = festival.data.stack, aes(x = score)) + 
  geom_histogram(binwidth = 0.4, color= 'black', fill = 'yellow') + 
  labs( x = 'Score', y = 'Counts')
Histogram.3day2

# ----------------------
Histogram.3day2 + facet_grid(~gender)

# ----------------------
Histogram.3day2 + facet_grid(gender~day)

# 상대도수 그래프----------------------
Histogram.3day2 <- ggplot( data = festival.data.stack, aes(x = score,
                                                           y = ..density..)) + 
  geom_histogram(binwidth = 0.4, color= 'black', fill = 'yellow') + 
  labs( x = 'Score', y = 'Counts')
Histogram.3day2

# ----------------------
Histogram.3day2 + facet_grid(~gender)

# 왜도 보기 좋음----------------------
Histogram.3day2 + facet_grid(gender~day)

# ----------------------
Scatterplot <- ggplot(data = festival.data.stack, aes(x = gender, y = score, color = gender)) + 
  geom_point(position = 'jitter') + facet_grid(~day)
Scatterplot

# ----------------------
Scatterplot + scale_color_manual(values = c('darkorange', 'darkorchid4'))

# 평균, 분산 보기 더 좋음----------------------
Scatterplot + geom_boxplot(alpha = 0.1, color= 'black', fill = 'orange')




