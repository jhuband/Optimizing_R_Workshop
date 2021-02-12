##-------------------------------------------
#  This snippet of code captures the time that
#  it takes to count the number of rows that have
#  have an NA.
#  
#  
#  Your task:  time your optimization of the code
##-------------------------------------------
count_rows_1 <- function(data){
    numRows <- dim(data)[1]
    count <- 0 
    for (i in 1:numRows){
       rowData <- data[i, ]
       if (any(is.na(rowData))){
         count = count + 1
       }
    }
    return(count)
 }
##-------------------------------------------
#      INSERT YOUR OPTIMIZED FUNCTION HERE

 count_rows_2 <- function(data){
    count <- 0 

    return(count)
 }
##-------------------------------------------

 data <- read.csv("Data/test_data_1.csv")
 print(head(data))

 numReps = 1000
 elapsedTime = system.time(
                replicate(numReps,      
                          count_rows_1(data))
              )
 print(elapsedTime/numReps)

 elapsedTime = system.time(
                replicate(numReps,      
                          count_rows_2(data))
              )
 print(elapsedTime/numReps)


