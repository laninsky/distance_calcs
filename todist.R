args = commandArgs(trailingOnly=TRUE)

library(stringr)

files <- list.files(path=args[1],pattern=".out", full.names = TRUE)

outputmatrix <- matrix(c("locus","sample1","sample2","raw_dist","standtolocusmax"),ncol=5,nrow=1)

for (i in files) {
  temp <- readLines(i)
  for (k in 1:length(temp)) {
    if (grepl("Gap weighting",temp[k])) {
      break
    }
  } 
  k <- k + 2
  
  temp <- temp[k:length(temp)]
  
  ncols <- str_count(temp[1],"\t")+1
  nrows <- length(temp)
  
  tempmat <- matrix(NA,ncol=ncols,nrow=nrows)
  
  temptemp <- gsub("[[:space:]]", "", unlist(strsplit(temp[1],"(\t)+")))[-1]
  tempmat[1,1:(length(temptemp))] <- temptemp
  
  for (j in 2:length(temp)) {
    temptemp <- gsub("[[:space:]]", "", unlist(strsplit(temp[j],"(\t)+")))[-1]
    tempmat[j,(ncols-length(temptemp)+1):ncols] <- temptemp
  }  
  
  for (j in 2:length(temp)) {
    tempmat[j,ncols] <- gsub(paste((j-1),"$",sep=""),"",tempmat[j,ncols])
  }
  
  tempoutmatrix <- matrix(NA,nrow=((ncols-1)*nrows)/2,ncol=5)
  tempoutmatrix[,1] <- i 
  x <- 1
  for (j in 2:length(temp)) {
    for (k in 1:(ncols-1)) {
      if (!(is.na(tempmat[j,k]))) {
        tempoutmatrix[x,2] <- tempmat[j,ncols]
        tempoutmatrix[x,3] <- tempmat[(k+1),ncols]
        tempoutmatrix[x,4] <- tempmat[j,k]
        x <- x + 1
      }
    }
  }  
  tempoutmatrix[,5] <- as.numeric(tempoutmatrix[,4])/max(as.numeric(tempoutmatrix[,4]),na.rm=TRUE)
  outputmatrix <- rbind(outputmatrix,tempoutmatrix)  
}
write.table(outputmatrix,"dist_between_samples.txt",row.names=FALSE,col.names=FALSE,quote=FALSE)
