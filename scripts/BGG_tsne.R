library(data.table)
library(stringr)
library(Rtsne)

data = fread('./data/games.csv')

#cluster_vars = grep('mechanic_', names(data))
#cluster_vars = grep('category_', names(data))
cluster_vars = grep('category_|mechanic_', names(data))


data_to_cluster = data[,cluster_vars,with=FALSE]

tsne_bgg = Rtsne(data_to_cluster
                 , check_duplicates = FALSE
                 , perplexity=5
                 , verbose=TRUE
                 , max_iter = 5000
                 , theta = 0
                 ,pca = FALSE)

#d = dist(data_to_cluster)
d = dist(tsne_bgg$Y)

clusters <- hclust(d,method = 'ward.D2')
number_of_clusters = 30
clusterCut <- cutree(clusters, number_of_clusters)

palette(rainbow(number_of_clusters))
par(bg = "black")
plot(tsne_bgg$Y, t='n', main="Board Games Map")
text(tsne_bgg$Y, labels=data[,name],cex = 0.6, col = clusterCut)


