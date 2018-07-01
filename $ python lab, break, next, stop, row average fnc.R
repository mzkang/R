## 파이썬 lab-> R로
# 4-3
t= c(1,3,5,7,'a','b','c')
if (5 %in% t){
  print('5 is in it')
}
if ('d' %in% t){
  print('d is in t')
} else {
  print('d is not in t')
}

# 4-4 list에서 홀수만 출력
list <- c(1,2,3,4,5,6,7,8,9,10)
for (i in list){
  if (i %% 2 == 1) {
    print(i)
  }
}




# 4-5
colors = c('red','blue','pink','green','yellow','purple')
colors[grepl("p.*",colors)] #파이썬에서 쉽게 slicing 하던 문자열을
colors[grep('^p',colors)]   #R에서는 grep(정규식)을 이용해야 함 
colors[grep('.e.',colors)]




## stop, break, next
# stop은 결과에 error가 표시됨
for (i in 2:9) {
  if (i %% 7 == 0) stop()
  else {
    for (j in 1:9) {
      print(paste( i, '*', j, '=', i*j))
    } 
  }
}



#next
for (i in 2:9) {
  if (i %% 2 == 0) next()
  else {
    for (j in 1:9) {
      print(paste( i, '*', j, '=', i*j))
    } 
  }
}


for (i in 2:9) {
  for (j in 1:9) {
    if (j %% 2 == 0) next()  #next들은 if문은 for(j in 1:9)에 포함
    print(paste( i, '*', j, '=', i*j)) #next되면 해당 for(j in 1:9)에서
  }                                  #다음 j로 시행
}




# break
for (i in 2:9) {
  if (i %% 3 == 0) break #break가 포함된 if문이 들어간 것이 for(i in 2:9)임
  else {                 #따라서 break되는 순간 for (i in 2:9)가 끝나버림
    for (j in 1:9) {     #실행종료
      print(paste( i, '*', j, '=', i*j))
    } 
  }
}


for (i in 2:9) {
  for (j in 1:9) {
    print(paste( i, "*", j, '=', i*j))
    if (i %% 3 == 0) break #break있는 if문은 for(j in 1:9)에 포함
  }                        #따라서 break되는 순간 for(j in 1:9)를 종료하고
}                          #for(i in 2:9)로 올라가서 다시 계산




for (i in 1:3) {
  for (j in 1:3) {
    print(c(i,j))
    if(j==2) break #break있는 if문은 for(j in 1:3)에 포함
  }                #따라서 break되는 순간 for(j in 1:3)을 종료하고
}                  #for(i in 1:3)으로 올라가서 다시 계산



for (i in 1:3) {
  for (j in 1:3) {
    print(c(i,j))
    if(j==2) stop() 
  }
}







## create function
# column average function
colmean <- function(x){
  if (class(x) != 'matrix') stop()
  v = rep(0, ncol(x))
  for (i in 1:ncol(x)){
    v[i] = mean(x[,i])
  }
  return(v)
}
x=matrix(1:30, 5,6)
colmean(x)
colmean_x <- rbind(x,colmean(x))
colmean_x
x_row <- c(1,2,3,4,5,'col_mean')
colnames(colmean_x) <- x_row
colmean_x


#row average function
rowmean <- function(x){
  if (class(x) != 'matrix') stop()
  u = rep(0,nrow(x))
  for (i in 1:nrow(x)){
    u[i] = mean(x[i,])
  }
  return(u)
}
rowmean(x)
rowmean_x <- cbind(x, rowmean(x))
rowmean_x
x_col <- c(1,2,3,4,5,6, 'row_mean')
colnames(rowmean_x) <- x_col
rowmean_x




