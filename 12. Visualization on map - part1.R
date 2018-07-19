rm(list = ls()); gc(reset = T)

# -----------------------------
if(!require(maps)){install.packages("maps") ;library(maps)}
if(!require(mapdata)){install.packages("mapdata") ;library(mapdata)}

# -----------------------------
par(mfrow = c(1,2))
map(database = "usa")
map(database = "county") ## county map을 이용, 자세한 USA map을 그릴 수 있음

# -----------------------------
map(database = 'world', region = 'South Korea')
# world2Hires에서 보다 높은 자세한 map을 그릴 수 있음
map('world2Hires', 'South Korea') 
par(mfrow=c(1,1))
map(database = 'world')
?text  # offset 옵션 : 사이 거리

# -----------------------------
data(us.cities)
head(us.cities)

# -----------------------------
map('world', fill = TRUE, col = rainbow(30))

# -----------------------------
map('world', fill = TRUE, col = rainbow(30))

# -----------------------------
data(unemp) # unemployed rate data
data(county.fips) # county fips data
head(unemp,3)
head(county.fips,3)

# -----------------------------
summary(unemp$unemp)
cut(unemp$unemp, c(0,2,4,6,8,10,100))  # 지정한 값의 factor 생성
?match
unemp$colorBuckets <- as.numeric(cut(unemp$unemp, 
                                     c(0, 2, 4, 6, 8, 10, 100)))
colorsmatched <- unemp$colorBuckets[match(county.fips$fips, unemp$fips)]
colorsmatched
# -----------------------------
colors = c("#F1EEF6","#D4B9DA","#C994C7","#DF65B0","#DD1C77","#980043")
if(!require(mapproj)){install.packages("mapproj") ;library(mapproj)}
map("county", col = colors[colorsmatched], fill = TRUE,
    resolution = 0, lty = 0, projection = "polyconic")

# -----------------------------
colors = c("#F1EEF6","#D4B9DA","#C994C7","#DF65B0","#DD1C77","#980043")
map("county", col = colors[colorsmatched], fill = TRUE,
    resolution = 0, lty = 0, projection = "polyconic")

# -----------------------------
map("county", col = colors[colorsmatched], fill = TRUE,
    resolution = 0, lty = 0, projection = "polyconic")
map("state", col = "white", fill = FALSE, add = TRUE, lty = 1,
    lwd = 0.2,projection = "polyconic")
title("unemployment by county, 2009")

# -----------------------------
colors = c("#F1EEF6","#D4B9DA","#C994C7","#DF65B0","#DD1C77","#980043")
colorsmatched <- unemp$colorBuckets[match(county.fips$fips, unemp$fips)]
map("county", col = colors[colorsmatched], fill = TRUE,
    resolution = 0, lty = 0, projection = "polyconic")
map("state", col = "white", fill = FALSE, add = TRUE, lty = 1,
    lwd = 0.2,projection = "polyconic")
title("unemployment by county, 2009")

# -----------------------------
if(!require(dplyr)){install.packages("dplyr") ;library(dplyr)}
if(!require(ggplot2)){install.packages("ggplot2") ;library(ggplot2)}

wm <- ggplot2::map_data('world')
str(wm)      # group이 그려지는 순서임
wm[400:500,]
wm %>% dplyr::select(region) %>% unique()%>%head()

# -----------------------------
ur <- wm %>% dplyr::select(region)%>%unique()
nrow(ur)
grep( "Korea", ur$region )
ur$region[c(125,185)]
grep('China', ur$region)
ur$region[c(42)]

# -----------------------------
map("world", ur$region[c(42,125,185)],fill = T,
    col = "blue")
map("world", ur$region[c(42,125,185)],fill = T,
    col = rainbow(4))  # 칠해지는 단위가 폴리곤이라 제주도가 다른색으로 나옴


wmr <- wm %>% filter(region == 'South Korea' | region == 'North Korea')
wmr
wmr <- wm %>% filter(region == 'South Korea')
unique(wmr$group)
map('world', ur$region[c(125,185)], fill = T,
    col = c(rep('skyblue',11), rep('pink',2)))
    # 나라별로 (stats이 주어지면 그에 따라)색칠하는 map함수 짜보기
# -----------------------------
if(!require(mapplots)){install.packages("mapplots") ;library(mapplots)}
if(!require(ggmap)){install.packages("ggmap") ;library(ggmap)}
if(!require(mapdata)){install.packages("mapdata") ;library(mapdata)}

map('worldHires', 'South Korea')
seoul_loc = geocode('seoul')
busan_loc = geocode('Busan')
add.pie(z=1:2,labels = c('a','b'), 
        x = seoul_loc$lon, y = seoul_loc$lat, radius = 0.5)
add.pie(z=4:3,labels = c('a','b'),
        x = busan_loc$lon, y = busan_loc$lat, radius = 0.5)

















