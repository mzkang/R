if(!require(networkD3)){install.packages("networkD3"); library(networkD3)}
if(!require(igraph)){install.packages("igraph"); library(igraph)}
if(!require(reshape2)){install.packages("reshape2"); library(reshape2)}
src <- c("A", "A", "A", "A",
         "B", "B", "C", "C", "D")
target <- c("B", "C", "D", "J",
            "E", "F", "G", "H", "I")
networkData <- data.frame(src, target)
head(networkData)
networkD3::simpleNetwork(networkData, fontSize = 15, zoom = T)
data(MisLinks)
head(MisLinks)
data(MisNodes)
head(MisNodes)


forceNetwork(Links = MisLinks, Nodes = MisNodes, NodeID="name",
             Source = "source", Target = "target",
             Value = "value", arrows = T,
             Group = "group", opacity = 0.8, zoom = TRUE)
sankeyNetwork(Links = MisLinks, Nodes = MisNodes,
              Source = "source", Target = "target",
              Value = "value", NodeID = "name",
              fontSize = 12, nodeWidth = 18)


if(!require(data.table)){install.packages("data.table"); 
  library(data.table)}
if(!require(dplyr)){install.packages("dplyr"); library(dplyr)}
if (!require(reshape2)) { install.packages("reshape2") ; library(reshape2) }

setwd("G:/강의자료/4차산업") # dataset이 존재하는 library지정
load("data_list.Rdata")
str(data_list)
head(data_list$data$word[data_list$data$date==2014])
head(data_list$data$count[data_list$data$date==2014])
head(data_list$data$word[data_list$data$date==2015])
head(data_list$data$count[data_list$data$date==2015])

barplot(table(data_list$date))

word.df=as.data.frame(data_list$data)
word.df=dcast(word.df,word~date,value.var ="count")
word.df=cbind(word.df,sum=rowSums(word.df[-1]))
word_order=order(word.df[6],decreasing = T)
head(word.df[word_order,],10)


doc_list = data_list$n_gram
uniq_words = sort(unique(do.call('c', doc_list)))
count_doc<-function(word,year){
  return(
  sum(sapply(data_list$n_gram[data_list$date==year], function(x) word %in% x))
  )
}
word_count_2016<-
  sapply(uniq_words, function(word) count_doc(word,2016))

conf_2016<-word_count_2016/sum(data_list$date==2016)
all(abs(conf_2016-data_list$conf_data$value_2016)<1e-10)


conf_result = data_list$conf_data
mean_conf = apply(conf_result[,2:4],1,mean) 
conf_result$increasing_rate = conf_result[,5] / mean_conf
attach(conf_result)
text_conf = conf_result[c(which(is.finite(increasing_rate) & 
                                  increasing_rate > 20), which(mean_conf > 0.3)),]
loc_conf = mean_conf[c(which(is.finite(increasing_rate) &
                               increasing_rate > 20), which(mean_conf > 0.3))]
sum(conf_result$increasing_rate==Inf)


plot(mean_conf, conf_result$increasing_rate, ylim = c(-0.5, 27),
     xlim = c(-0.01, 0.5))
text(loc_conf + 0.03, text_conf$increasing_rate,
     labels = text_conf$word, cex = 1, pos = 3)
abline(h = 1, col = 'red')

plot(mean_conf+1e-4, conf_result$increasing_rate+1e-2, ylim = c(1e-2, 27),log = "xy",
     xlim = c(1e-4, 2))
text(loc_conf, text_conf$increasing_rate,
     labels = text_conf$word, cex = 1, pos = 3)
abline(h = 1, col = 'red')

doc_list = data_list$n_gram
uniq_words = unique(do.call('c', doc_list))
occur_vec_list = lapply(doc_list, function(x) uniq_words %in% x)

dtm_mat = do.call('rbind', occur_vec_list)
colnames(dtm_mat) = uniq_words
length(uniq_words)
refined_dtm_mat = dtm_mat[, colSums(dtm_mat) != 0]
refined_dtm_mat = refined_dtm_mat[rowSums(refined_dtm_mat) != 0,]
cooccur_mat = t(refined_dtm_mat) %*% refined_dtm_mat
cooccur_mat[1:4, 1:4]


# 방법 1
inx = diag(cooccur_mat) >= 150
cooccur_plot_mat1 = cooccur_mat[inx, inx]

# 방법 2
idx = which(conf_result$increasing_rate[
  which(is.finite(conf_result$increasing_rate))] >= 5)
cooccur_plot_mat2 = cooccur_mat[idx, idx]

g = graph.adjacency(cooccur_plot_mat1, weighted = T, mode = 'undirected')
g = simplify(g)
wc = cluster_walktrap(g)
members = membership(wc)
members
network_list = igraph_to_networkD3(g, group = members)
sankeyNetwork(Links = network_list$links, Nodes = network_list$nodes,
              Source = "source", Target = "target", 
              Value = "value", NodeID = "name",
              units = "TWh", fontSize = 18, nodeWidth = 30)

network_list = igraph_to_networkD3(g, group = as.character(members))
network_list$links$group=network_list$nodes$group[network_list$links$source+1]
sankeyNetwork(Links = network_list$links, Nodes = network_list$nodes,
              Source = "source", Target = "target", 
              Value = "value", NodeID = "name", NodeGroup = "group", LinkGroup = "group",
              units = "TWh", fontSize = 18, nodeWidth = 30)

wc = cluster_fast_greedy(g)
members = membership(wc)
members
network_list = igraph_to_networkD3(g, group = as.character(members))
network_list$links$group=network_list$nodes$group[network_list$links$source+1]
sankeyNetwork(Links = network_list$links, Nodes = network_list$nodes,
              Source = "source", Target = "target", 
              Value = "value", NodeID = "name", NodeGroup = "group", LinkGroup = "group",
              units = "TWh", fontSize = 18, nodeWidth = 30, nodePadding = 3)



if(!require(circlize)){install.packages("circlize"); library(circlize)}
name=c(3,10,10,3,6,7,8,3,6,1,2,2,6,10,2,3,3,10,4,5,9,10)
feature=paste("feature ", c(1,1,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5),
              sep="")
dat <- data.frame(name,feature)
dat <- table(name, feature)
head(dat,4)
chordDiagram(as.data.frame(dat), transparency = 0.5)




if(!require(chorddiag)){devtools::install_github("mattflor/chorddiag"); 
  library(chorddiag)}
if(!require(RColorBrewer)){install.packages("RColorBrewer")}

doc_list = data_list$n_gram
table_list = lapply(doc_list, table)[1:3]
table_name = unique(unlist(do.call("c", doc_list[1:3] )))
names(table_list) = paste0("doc_", 1:3)

table_list = lapply(table_list, function(x){
  ifelse(uniq_words %in% names(x), x, 0)  
}
)

table_list = do.call("rbind", table_list)

refined_table_list = t(table_list[, apply(table_list, 2, sum) != 0])
rownames(refined_table_list) = table_name

groupColors <- brewer.pal(3, "Set3")

chorddiag(refined_table_list
          , groupColors = groupColors,  type = "bipartite", tickInterval = 3
          ,groupnameFontsize = 15)
