
#********************************************
#Define the first function
#     This should be the one that you suspect
#     is slower
#********************************************
function_1_desc <- "Repeated computations"
compute_1 = function(numValues){

  values <- runif(numValues)
  variance = 0
  
  for (x in values) {
    distToMean = x - mean(values)
    variance = variance +    
      (distToMean^2)/length(values)
  }
  
}

#********************************************
#Define the second function
#     This should be the one that you hope
#     is faster
#********************************************
function_2_desc <- "'Faster' code"
compute_2 = function(numValues){

  values <- runif(numValues)
  variance = 0
  meanOfValues = mean(values)
  N = length(values)
  
  for (x in values){
    distToMean = x - meanOfValues
    variance = variance + (distToMean^2)/N
  }
  
}


#********************************************
#Initialize data
#********************************************
myCount = 1000
numReps = 30
numLoops = 5
time_1 = rep(0.0, numLoops)
time_2 = rep(0.0, numLoops)
countValues = rep(0.0, numLoops)


#********************************************
#In each iteraction, we will pass a value, myCount,
# to each function.  We will increase myCount each
# time through the loop.  We will capture the average
# time to perform numReps replications of the functions
#********************************************
for (i in 1:numLoops){
  print(i)
  time_1[i] = system.time(replicate(numReps, compute_1(myCount)))[3]
  time_2[i] = system.time(replicate(numReps, compute_2(myCount)))[3]
  countValues[i] = myCount
  myCount = myCount*2
  
}

#Create an empty plot with labeled axes
plot(range(countValues), range(c(time_1, time_2)), type='n', xlab="Number of Operations",
     ylab = "Time (sec)")
legend("topleft",
       c(function_1_desc, function_2_desc),
       fill=c("red", "blue")
)
#Plot the times as a function of the values passed to the function
lines(countValues, time_1, type='b', col='red')
lines(countValues, time_2, type='b', col='blue')

