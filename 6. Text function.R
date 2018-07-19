# <text function> - 정규표현식 어려움


## paste(collape옵션)
paste0(1:12) # 한 덩어리라서 붙일게 없으므로 자기 자신 나옴
paste0(1:12, collapse = "-")  # collapse : 결과를 한 개의 벡터로 합침
paste(1:4,5:8, sep = ';')
paste(1:4,5:8, sep = ';', collapse = '-')



## grep : 지시하는 문자(단어)가 포함된 문자의 위치(index)를 반환
grep('a', c('bbbb', 'bbabb'))
grep('^a', c('bbbb','ababa','bbabb'))


## nchar : 문자열 단어 개수 계산
nchar(c('South Pole', '한글 문자열', NA))


## substring : 문자열 내에서 위치를 참조해서 문자열을 반환
# substr(문자, start=k, stop=n)
substr('Equator',start=2, stop=4)
substring('한글 문자열 추출', first = 2)  # 앞 문자 skip


## strsplit : 문자열을 지정한 문자로 분리시킴(csv처럼)
strsplit('2018-07-05', split = '-')
strsplit(c('6-16-2011','1-1-1-1+2-1-1-1'), split = '-')
strsplit('6*16*2011', split='*')  # *는 escape문자 (모든 문자를 의미)
strsplit('6*16*2011', split='\\*')  # escape 피하기 -> \\
strsplit('6*16*2011', split='*', fixed = T)  # escape 피하기

a <- strsplit(list.files(), split = '.', fixed = T) 
tmp = c()
for (i in 1:length(a)){
  b = a[i]
  if (length(b) == 2) {
    tmp = c(tmp, tail(b, n=1))
  }
}
table(tmp)

a <- strsplit(list.files(), split = '.', fixed = T) 
tmp = rep(NA, length(a))
for (i in 1:length(a))
{
  b = a[i]
  if (length(b) == 2)
  {
    tmp[i] = tail(b, n=1)
  }
}
tmp


## regexpr : 문자열 내에서 지정 문자와 처음으로 일치한 위치

## gregexpr : 문자열 내에서 지정 문자와 일치하는 모든 위치

## gsub : 특정 문자를 지우거나 대치시킴
gsub(pattern = "감자", replacement='고구마',
     x= "머리를 감자마자 감자칩을 먹었다.")

gsub(pattern = "<br>", replacement='',
     x= "머리를 감자마자 <br>감자칩을 먹었다.")

#======================================================================================

## 정규표현식
strsplit('감자, 고구마, 양파 그리고 파이어볼', 
         split ='(,)|(그리고)')   # 패턴을 꼭 ''로 묶어야 함 

grep(pattern = '^(감자)', x = '감자는 고구마를 좋아해')   # ^ : 시작
grep(pattern = '^(감자)', x = '고구마는 감자를 안 좋아해') 

grep(pattern = '(좋아해)$', x = '감자는 고구마를 좋아해')  # $ : 끝
grep(pattern = '(좋아해)$', x = '고구마는 감자를 안 좋아해')

gregexpr(pattern = '[아자차카]', # [] : any / []로 묶인 문자는 1개의 문자임
         text = '고구마는 감자를 안 좋아해') # 문자가 아or자or차or카
gregexpr(pattern = '[(사과)(감자)(양파)]', text = '고구마는 감자를 안 좋아해')
# []안의 ()는 작동 X, 사/과/감/자/양/파 따로따로 구분됨
gregexpr(pattern = '^[(사과)(감자)(양파)]', text = '고구마는 감자를 안 좋아해')
# 해당사항 없으면 -1

grep(pattern = '^[^(사과)(감자)(양파)]',  # [^] : everything
     x = '감자는 고구마를 좋아해')

## 교재의 abbreviation 보기 (이외의 제거해서 읽기)


# 반복
# o{from, to} : o가 from번에서 to번까지 반복되는 패턴
grep(pattern = '^(ab){2,3}', x = 'ababccc')  # ab가 시작위치에서 2번~3번 반복




#=========================================================================
# <정규표현식과 stringr 패키지>

# -----------------------------
^[1-9][0-9]*$
  
# -----------------------------
^[1-9][0-9]*$
  
# -----------------------------
^(0|([1-9][0-9]*))$
  
# -----------------------------
^[0-9]+(\\.[0-9]{1,2})?$
  
# -----------------------------
^[_a-z0-9-]+(\\.[_a-z0-9-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*$
  
# -----------------------------
if(!require(stringr)){install.packages("stringr"); library(stringr)}
hw <- "Hadley Wickham"
str_sub(hw, 1, 6)
strsplit(hw, split = ' ')
strsplit(hw, split = ' ')[[1]][2]
str_sub(hw, 8,100)
str_sub(hw, -5)
str_sub(hw, -5, -2)

# -----------------------------
fruits <- c("apples and oranges and pears and bananas",
            "pineapples and mangos and guavas")
str_split(fruits, " and ")
strsplit(fruits, split = 'and')

# -----------------------------
str_split(fruits, " and ", n = 2)  # 2 덩어리로만 분리 

# -----------------------------
str_split_fixed(fruits, " and ", 4)  # fixed옵션을 통해 행렬로 저장 가능 

# -----------------------------
fruit <- c("apple", "banana", "pear", "pinapple")
str_detect(fruit, "^a")   # 정의한 패턴이 있나 없나 확인

   # ^R[a-z0-9]*(.exe)+$    : R로 시작하고 .exe로 끝나는 단어

# -----------------------------
str_count(fruit, c("a", "b", "p", "p"))    # 들어간 문자 개수
str_count(fruit, c("a", "b", "p{2,3}", "^p"))  # 들어간 패턴 수
str_count(fruit, c("a", "b", "p", "p{1,2}")) 

# -----------------------------
str_locate(fruit, "e")   # 주어진 문자가 발견된 start index와 end index

# -----------------------------
shopping_list <- c("apples x244", "flour", "sugar", "milk x2")
str_extract(shopping_list, "\\d+")   # 패턴과 매칭되는 부분 추출
str_extract_all(shopping_list, '[0-9]+')  # all쓰면 리스트로 추출
str_count(shopping_list, '\\d') 

# -----------------------------
fruits <- c("one apple", "two pears", "three bananas")
str_replace(fruits, "[aeiou]", "-")
str_replace_all(fruits, '[aeiou]','-')
?str_replace_all

# 정규표현식을 이용해서 html 태그를 제거할 수 있ㅇ