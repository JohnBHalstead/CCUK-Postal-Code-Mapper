# read in long and lat capture data from S3

cpt.df <- read.csv("C:\\Users\\HalsteadJ\\Documents\\data\\captures2017.csv", header = T, stringsAsFactors = F)
names(cpt.df) <- c("lat", "long")

# read in the long lat and post code data from freemaptools

pst.df <- read.csv("C:\\Users\\HalsteadJ\\Documents\\data\\ukpostcodesmajor.csv", header = T, stringsAsFactors = F)[,2:4]
names(pst.df)[2:3] <- c("lat", "long")

#create matrices needed to calculate distance between data points and post code location

nr <- dim(cpt.df)[1]
nc <- dim(pst.df)[1]

dist.mat <- (matrix(cpt.df$lat, ncol = nc, nrow =nr)-matrix(pst.df$lat, ncol = nc, nrow = nr, byrow = T))^2 +
  (matrix(cpt.df$long, ncol = nc, nrow= nr) - matrix(pst.df$long, ncol = nc, nrow = nr, byrow = T))^2

for (i in 1:dim(dist.mat)[1]){
  cpt.df$postcode[i] <- pst.df$postcode[which(dist.mat[i,] == min(dist.mat[i,]))]
}

write.csv(cpt.df, "C:\\Users\\HalsteadJ\\Documents\\data\\postcodemap.csv", row.names = F)