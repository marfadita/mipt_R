#install.packages('corrplot')
library(corrplot)
cor(c(1:5),c(2,8,9,10,12),method = "spearman")
cor(c(1:5),c(2,8,9,10,12),method = "s")
cor(c(1:5),c(2,8,9,10,12))
cor.test(c(1:5),c(2,8,9,10,12))

head(mtcars)

M <- cor(mtcars,method ="s")
corrplot(M)
corrplot(M, method = 'number') # colorful number
corrplot(M, method = 'color', order = 'alphabet')
corrplot(M) # by default, method = 'circle'
corrplot(M, order = 'AOE') # after 'AOE' reorder
corrplot(M, method = 'shade', order = 'AOE', diag = F)
corrplot(M, method = 'square', order = 'FPC', type = 'lower', diag = FALSE)
corrplot(M, method = 'ellipse', order = 'AOE', type = 'upper')
corrplot.mixed(M, order = 'AOE')
corrplot.mixed(M, lower = 'shade', upper = 'pie', order = 'hclust')
corrplot(M, order = 'hclust', addrect = 2)
corrplot(M, method = 'square', diag = FALSE, order = 'hclust',addrect = 3, rect.col = 'blue', rect.lwd = 3, tl.pos = 'd')

M1 <- cor.mtest(mtcars, method="s")
M1[[2]]
#example 
#function
plot_polished_corrplot <- function(df,plot_name){
  cor_m = cor(df, method="s")#method must be the same!!*
  testRes = cor.mtest(df, method="s")#*method must be the same!!
  #find order after hclust
  ord <- corrMatOrder(cor_m, order="hclust",hclust.method = "ward.D2")
  #find reverse order
  ord_rev<-match(1:length(ord),ord)
  #form p-value matrix
  pv_matrix<-testRes$p[ord,ord]#order as final
  pv_matrix[lower.tri(pv_matrix,diag = F)]<-1#delete significant p in lower triangle
  pv_matrix<-pv_matrix[ord_rev,ord_rev]#restore original order
  # end of p-value matrix forming
  tiff(paste0("corrplot,",plot_name,".tiff"), width = 3.75, height = 3.75, units = 'in', res = 350)
  
  corrplot.mixed(cor_m, 
                 lower.col = "red", 
                 upper = "color", 
                 tl.col = "green", 
                 tl.cex = 0.8,
                 tl.pos = "lt",
                 order = 'hclust',
                 hclust.method="ward.D2",
                 diag = "u",
                 number.cex = 0.5,
                 p.mat = pv_matrix,
                 sig.level = c(0.001, 0.01, 0.05),
                 pch.cex = 0.6,
                 insig = 'label_sig',
                 mar=c(0,1,0,0)
                 )
  dev.off()
}
getwd()
plot_polished_corrplot(df=mtcars,plot_name ="test_corrplot1")
plot_polished_corrplot(df=iris[,-5],plot_name ="test_corrplot2")


