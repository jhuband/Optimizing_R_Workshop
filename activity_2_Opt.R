##-------------------------------------------
#  This snippet of code captures the time that
#  it takes to count the number of rows that have
#  have an NA.
#  
#  
#  Your task:  time your optimization of the code
##-------------------------------------------
 data <- read.csv("Data/test_data_1.csv")
 print(head(data))

 startTime = proc.time()
 numRows <- dim(data)[1]
 count <- 0 
 for (i in 1:numRows){
    rowData <- data[i, ]
    if (any(is.na(rowData))){
      count = count + 1
    }
 }
 print(count)

 stopTime = proc.time()
 elapsedTime = (stopTime - startTime)
 print(elapsedTime)

 startTime = proc.time()
##-------------------------------------------
#      INSERT YOUR OPTIMIZED VERSION HERE
##-------------------------------------------
 stopTime = proc.time()
 elapsedTime = (stopTime - startTime)
 print(elapsedTime)
