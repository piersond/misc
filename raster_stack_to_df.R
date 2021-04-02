library(raster)

r1 = raster(matrix(1:6,2,3))
s1 = stack(list(r1,r1*2,r1*3))
df <- as.data.frame(s1)