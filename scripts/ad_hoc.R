fviz_nbclust(tsne_bgg$Y, hcut, method = "gap_stat", k.max = 50, nboot = 50) +
  geom_vline(xintercept = 3, linetype = 2)
