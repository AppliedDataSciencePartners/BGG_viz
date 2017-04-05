library(data.table)
library(stringr)
library(Rtsne)
library(plotrix)

data = fread('./data/games.csv')

#cluster_vars = grep('mechanic_', names(data))
#cluster_vars = grep('category_', names(data))
cluster_vars = grep('category_|mechanic_', names(data))


data_to_cluster = data[,cluster_vars,with=FALSE]

set.seed(1067)

tsne_bgg = Rtsne(data_to_cluster
                 , check_duplicates = FALSE
                 , perplexity=5
                 , verbose=TRUE
                 , max_iter = 5000
                 , theta = 0
                 ,pca = TRUE)

#d = dist(data_to_cluster)
d = dist(tsne_bgg$Y)




clusters <- hclust(d,method = 'ward.D2')
number_of_clusters = 30
clusterCut <- cutree(clusters, number_of_clusters)

palette(rainbow(number_of_clusters))
par(bg = "black")
plot(tsne_bgg$Y, t='n', main="Board Games Map")
text(tsne_bgg$Y, labels=data[,name],cex = 1, col = clusterCut)


###CODE TO DETERMINE CLUSTER DEFINITIONS
cat('-------------\n')
for (i in 1:number_of_clusters){
  cat(i,'\n\n')
  print(
    sort(sapply(data_to_cluster[which(clusterCut == i)], mean),decreasing=TRUE)[1:5]
  )
  
  print(unlist(sapply(rainbow(number_of_clusters),color.id)[i])[1])
  print(data[which(clusterCut == i)[1:5],name])
  cat('-------------\n')
}
