rm(list = ls()); gc(reset = T)

# -------------------------------------------
if(!require(OpenStreetMap)){install.packages("OpenStreetMap"); library(OpenStreetMap)}
if(!require(ggplot2)){install.packages("ggplot2"); library(ggplot2)}

# -------------------------------------------
map = OpenStreetMap::openmap(upperLeft = c(43, 119), lowerRight = c(33, 134),
                             type = 'bing')
plot(map)

# -------------------------------------------
map = openmap(upperLeft = c(43, 119), lowerRight = c(33, 134),
              type = 'bing')
plot(map)

# -------------------------------------------
par(mfrow = c(1,2))
map = openmap(upperLeft = c(43, 119), lowerRight = c(33, 134),
              type = 'bing')
autoplot(map)

# -------------------------------------------
nm = c("osm", "mapbox", "stamen-toner", 
       "stamen-watercolor", "esri", "esri-topo", 
       "nps", "apple-iphoto", "osm-public-transport")
par(mfrow=c(3,3),  mar=c(0, 0, 0, 0), oma=c(0, 0, 0, 0))

for(i in 1:length(nm)){
  map <- openmap(c(43,119),
                 c(33,134),
                 minNumTiles = 3,
                 type = nm[i])
  plot(map, xlab = paste(nm[i]))
}

par(mfrow = c(1, 1))
# -------------------------------------------
map1 <- openmap(c(43.46,119.94),
                c(33.22,133.98))
plot(map1) 
autoplot(map1)
abline(h = 4500000, col = 'blue')

# -------------------------------------------
str(map1) # bbox : bounding box
          # projection : 3차원 구 -> 2차원 평면
          # @는 슬롯 
          # projargs : projection argument. projection 방법
          

# projection argument 확인-------------------
map1$tiles[[1]]$projection@projargs
str(map1$tiles[[1]]$projection)

# 좌표계를 위경도 좌표계로 바꾸고 싶음(openproj)
if(!require(sp)){install.packages("sp"); library(sp)}
map_p <- openproj(map1, projection = CRS("+proj=longlat"))
                    # CRS : as.formula 역할
str(map_p)

# -------------------------------------------
plot(map_p)
autoplot(map_p)   # 좌표 나오는 지도
abline(h = 38, col = 'blue')   # autoplot에서는 abline 작동 X

# -------------------------------------------
map_p <- openproj(map1, projection = 
                    CRS("+proj=utm +zone=52N + datum=WGS84"))
         # datum : data / zone : 위치 / proj : projection 방법
plot(map_p)
abline(h = 38, col = 'blue')  # 안 그려짐. 위경도 좌표계가 아니라는 뜻.   
autoplot(map_p)  

# 38도선을 그리려면 좌표계 변환 과정 필요----
# Coordinate Reference System(CRM)

a  <-data.frame(lon =  seq(100,140,by = 0.1),  # 동경 100도 ~ 140도까지
                lat =  38)                     # 북위 38도의 점들을 생성

  # a를 좌표계 sp 클래스로 변환 (coordinates(만든 좌표계))
sp::coordinates(a) = ~ lon + lat  
str(a)  # slot 3개
a@coords   # slot 가져오기

# -------------------------------------------
sp::proj4string(a) = "+proj=longlat"
#a@proj4string  = CRS("+proj=longlat")  실제 작동하는 것
str(a)
a@coords

# -------------------------------------------
a_tf = spTransform(a,  CRS("+proj=utm +zone=52N + datum=WGS84"))
str(a_tf)
a_tf@coords

# -------------------------------------------
plot(map_p)
points(a_tf@coords[,1], a_tf@coords[,2], type = 'l', col = 'blue')

# -------------------------------------------
if(!require(mapplots)){install.packages("mapplots"); library(mapplots)}

map = openmap(upperLeft = c(43, 119),lowerRight = c(33, 134))
seoul_loc = geocode('Seoul')
coordinates(seoul_loc) = ~lon + lat
proj4string(seoul_loc) = "+proj=longlat +datum=WGS84" 
seoul_loc_Tf = spTransform(seoul_loc,
                           CRS(as.character(map$tiles[[1]]$projection)))
plot(map)
add.pie(z=1:2,labels = c('a','b'),
        x = seoul_loc_Tf@coords[1],
        y = seoul_loc_Tf@coords[2], radius = 100000)

# -------------------------------------------
if(!require(ggmap)){install.packages("ggmap"); library(ggmap)}
if(!require(mapplots)){install.packages("mapplots"); library(mapplots)}
if(!require(OpenStreetMap)){install.packages("OpenStreetMap"); library(OpenStreetMap)}

map = openmap( upperLeft = c(43, 119), lowerRight = c(33, 134),type = 'bing') # upperLeft lowerRight option
seoul_loc = geocode('Seoul')
coordinates(seoul_loc) = ~lon + lat
proj4string(seoul_loc) <- "+proj=longlat +datum=WGS84"
seoul_loc_Tf <- spTransform(seoul_loc, CRS(as.character(map$tiles[[1]]$projection)))
plot(map)
add.pie(z=1:2,labels = c('a','b'), x = seoul_loc_Tf@coords[1], y = seoul_loc_Tf@coords[2], radius = 100000)

# -------------------------------------------
if(!require(ggmap)){install.packages("ggmap"); library(ggmap)}

# -------------------------------------------
data(crime)
head(crime, 2)    # 산불 data (forrestfire)도 사용해볼 수 있음
                  # 우리나라 산불대장도 있음

# -------------------------------------------
violent_crimes = subset(crime,
                        offense != "auto theft" & 
                          offense != "theft" & 
                          offense != "burglary")
violent_crimes$offense <- factor(violent_crimes$offense,
                                 levels = c("robbery", "aggravated assault", "rape", "murder"))
violent_crimes = subset(violent_crimes,
                        -95.39681 <= lon & lon <= -95.34188 &
                          29.73631 <= lat & lat <=  29.78400)

# -------------------------------------------
HoustonMap = qmap("houston", zoom = 14,
                  color = "bw", legend = "topleft")
HoustonMap + geom_point(aes(x = lon, y = lat,
                            colour = offense, size = offense),
                        data = violent_crimes)

# -------------------------------------------
HoustonMap +
  geom_point(aes(x = lon, y = lat,
                 colour = offense, size = offense),
             data = violent_crimes) +
  geom_density2d(aes(x = lon, y = lat), size = 0.3 , bins = 4, 
                 data = violent_crimes)



# -------------------------------------------
HoustonMap +
  geom_point(aes(x = lon, y = lat,
                 colour = offense, size = offense),
             data = violent_crimes) +
  geom_density2d(aes(x = lon, y = lat), size = 0.2 , bins = 4, 
                 data = violent_crimes) +
  stat_density2d(aes(x = lon, y = lat,
                     fill = ..level..,  alpha = ..level..), 
                      # 점2개는 내부 변수, frequency
                      # ..density..와 같은 것
                 size = 2 , bins = 4,
                 data = violent_crimes,geom = "polygon")

# -------------------------------------------
setwd("C:/Users/hgkang/Desktop/SKT교육/수정/L12-ggmap")
load('airport.Rdata')
head(airport_krjp)

# -------------------------------------------
head(link_krjp)

# -------------------------------------------
map = ggmap(get_googlemap(center = c(lon=134, lat=36),
                          zoom = 5, maptype='roadmap', color='bw'))
map + geom_line(data=link_krjp,aes(x=lon,y=lat,group=group), 
                col='grey10',alpha=0.05) + 
  geom_point(data=airport_krjp[complete.cases(airport_krjp),],
             aes(x=lon,y=lat, size=Freq), colour='black',alpha=0.5) + 
  scale_size(range=c(0,15))


# -------------------------------------------
if (!require(sp)) {install.packages('sp'); library(sp)}
if (!require(gstat)) {install.packages('gstat'); library(gstat)}
if (!require(automap)) {install.packages('automap'); library(automap)}
if (!require(rgdal)) {install.packages('rgdal'); library(rgdal)}
if (!require(e1071)) {install.packages('e1071'); library(e1071)}
if (!require(dplyr)) {install.packages('dplyr'); library(dplyr)}
if (!require(lattice)) {install.packages('lattice'); library(lattice)}
if (!require(viridis)) {install.packages('viridis'); library(viridis)}

# -------------------------------------------
seoul032823 <- read.csv ("C:/Users/renz/Documents/R/seoul032823.csv")
head(seoul032823)
  # crime은 frequency를 봤지만 여기에서는 value가 중요
  # 공간 내삽 사용 (각 점을 전체 면적에 표현)
  # kriging

# -------------------------------------------
skorea <- raster::getData(name ="GADM", country= "KOR", level=2) # 지도정보
# skorea <- readRDS("KOR_adm2.rds")
head(skorea,2)

# -------------------------------------------
class(skorea)
head(skorea@polygons[[1]]@Polygons[[1]]@coords, 3)
   # 지도를 그리는 경계점

# -------------------------------------------
if (!require(broom)) {install.packages('broom'); library(broom)}

skorea <- broom::tidy(skorea)  # wide format으로 변경. dcast와 같음.
class(skorea)
head(skorea,3)

# 바꿀 부분(geom_point)----------------------
ggplot() + geom_map(data= skorea, map= skorea,
                    aes(map_id=id,group=group),fill=NA, colour="black") +
              # geom_map은 geom_line으로 그린 것
  geom_point(data=seoul032823, aes(LON, LAT, col = PM10),alpha=0.7) +
  labs(title= "PM10 Concentration in Seoul Area at South Korea",
       x="Longitude", y= "Latitude", size="PM10(microgm/m3)")

# -------------------------------------------
class(seoul032823)
coordinates(seoul032823) <- ~LON+LAT
class(seoul032823)

# 바꿀 부분----------------------------------
LON.range <- c(126.5, 127.5)   # 원하는 위치 LON, LAT으로 지정
LAT.range <- c(37, 38)
seoul032823.grid <- expand.grid(       # 원하는 부분 grid로 만들기
  LON = seq(from = LON.range[1], to = LON.range[2], by = 0.01),
  LAT = seq(from = LAT.range[1], to = LAT.range[2], by = 0.01))
 # 격자의 모든 조합을 data frame으로 만듦

# -------------------------------------------
plot(seoul032823.grid)
points(seoul032823, pch= 16,col="red")  # 미세먼지 측정소 위치를 grid에 표시

# -------------------------------------------
coordinates(seoul032823.grid)<- ~LON+LAT ## sp class
gridded(seoul032823.grid)<- T
plot(seoul032823.grid)
points(seoul032823, pch= 16,col="red")

# 바꿀 부분 ------------------------------------
if(!require(automap)){install.packages("autoKrige"); library(automap)}

    # 예측된 PM10 point 올리기
seoul032823_OK <- autoKrige(formula = PM10~1,   # 설명변수 없음
                            input_data = seoul032823,  
                            new_data = seoul032823.grid ) 
                # 설명변수 넣고 싶으면    
                # input data와 new data 모두 그 데이터도 갖고 있어야 함
                # 반응변수는 input data에만 있으면 됨


# -------------------------------------------
str(seoul032823_OK)
head(seoul032823_OK$krige_output@coords, 2)  # 위치
head(seoul032823_OK$krige_output@data$var1.pred,2)
             # 위에서 본 각 위치의 PM10 예측값
             # 위치와 PM10 예측값으로 새로운 data frame을 만들기 -> myKrige

# -------------------------------------------
myPoints <- data.frame(seoul032823)
myKorea <- data.frame(skorea)
myKrige <- data.frame(seoul032823_OK$krige_output@coords, 
                      pred = seoul032823_OK$krige_output@data$var1.pred)   
     # myKrige : 위치와 예측된 PM10 정보
# -------------------------------------------
if(!require(viridis)){install.packages("viridis"); library(viridis)}
                         # palette package
ggplot()+ theme_minimal() +
  geom_tile(data = myKrige, aes(x= LON, y= LAT, fill = pred)) +
  geom_map(data= myKorea, map= myKorea, aes(map_id=id,group=group),
           fill=NA, colour="black") +
  coord_cartesian(xlim= LON.range ,ylim= LAT.range) +
  labs(title= "PM10 Concentration in Seoul Area at South Korea",
       x="Longitude", y= "Latitude")+
  theme(title= element_text(hjust = 0.5,vjust = 1,face= c("bold")))+
  scale_fill_viridis(option="magma")   # 설치한 패키지


