##-------------------------------------------
#  This snippet of code reads in a table of data
#  and counts how many rows of the data have an NA
#  
#  Your task:  optimize the code
##-------------------------------------------
data <- read.csv("Data/test_data_1.csv")
 print(head(data))

 numRows <- dim(data)[1]
 count <- 0 
 for (i in 1:numRows){
    rowData <- data[i, ]
    if (any(is.na(rowData))){
      count = count + 1
    }
 }
 print(count)



##-------------------------------------------
#      INSERT YOUR OPTIMIZED VERSION HERE
##-------------------------------------------


