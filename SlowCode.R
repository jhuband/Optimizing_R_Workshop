# **********************************************************************
#   Slow Code Example 
#
#   This code reads a series of coordinates (x, y, z)  and charges (q) from 
#    the file specified as argument 1 on the command line.
# 
#    The input file should have the format:
#       I9
#       4F10.4   (repeated I9 times representing x,y,z,q)
# 
#   It then calculates the following made-up function:
#   
#              exp(rij*qi)*exp(rij*qj)   1
#     E = Sum( ----------------------- - - )  (rij <= cut)
#         j<i           r(ij)            a
# 
#   where cut is a cut off value specified as argument 2 on the command line, 
#   r(ij) is the distance between (xi, yi, zi) and (xj, yj, zj) 
#   a is the constant 3.2.
# 
#   The code prints out the number of atoms, the cut off, total number of
#   atom pairs which were less than or equal to the distance cutoff, the
#   value of E, the time take to generate the coordinates and the time
#   taken to perform the calculation of E.
# 
# **********************************************************************
  


  
a = 3.2;
  
#Capture system time
time0 = proc.time()
  
cat("Value of system clock at start: ");
print (time0)
  
#   Step 1 - obtain the filename of the coord file and the value of
#   the cut from the command line.
#      Argument 1 should be the filename of the coord file (char).
#      Argument 2 should be the cut off (float). */
#   Quit if the number of arguments is insufficient
#
cmdArgs = commandArgs(trailingOnly=TRUE)
print (cmdArgs)
if (length(cmdArgs) != 2){
         cat("ERROR: only", length(cmdArgs), "command line options detected")
         cat(" - need 2 options: filename and cutoff.\n")
         on.exit()
}

cat("Coordinates will be read from file", cmdArgs[1],"\n")

cut = as.numeric(cmdArgs[2])
cat("cut =", cut, "\n")

#   
#   Step 2 - Open the coordinate file and read the first line to
#   obtain the number of atoms 
con = try(file(cmdArgs[1], "r"), silent=FALSE)
natom = as.numeric(readLines(con, n=1))
cat("Natom =", natom, "\n")

#   Step 3 - Allocate the arrays to store the coordinate and charge
#   data 
coords = c()
q = c()

#   
#   Step 4 - read the coordinates and charges from the file. 
for (i in 1:natom){
  line = readLines(con, n=1)
  line = unlist(strsplit(line, " "))
  line = as.numeric(line[which(line != "")])
  coords = rbind(coords, line[1:3], deparse.level=0)
  q = c(q, line[4])
   
}

print(dim(coords))
close(con)

time1 = proc.time()
elapsedTime = time1-time0
cat("Value of system clock after coord read:\n")
print(elapsedTime)

#   
#   Step 5 - for each pair of coordinates, compute the distance.
#   If the distance is less than or equal to the cut, calculate the term
#   for E. Keep track of the number of pairs that are used.
total_e = 0.0
cut_count = 0

for (i in 2:natom){
   for (j in 2:natom){

      if (j < i) {
         #    X^2 + Y^2 + Z^2 
         vec2 = (coords[i-1, 1]-coords[j-1, 1])^2.0 + (coords[i-1, 2]-coords[j-1, 2])^2.0 + (coords[i-1, 3]-coords[j-1,3])^2.0
         rij = sqrt(vec2);
         if ( rij <= cut )
         {
             #   Increment the counter of pairs below cutoff 
             cut_count = cut_count + 1;
             #   Compute the term to be added to E and add
             current_e = (exp(rij*q[i-1])*exp(rij*q[j-1]))/rij;
             total_e = total_e + current_e - 1.0/a;
         }
      }
   }

}

time2 = proc.time(); #time after reading of file and calculation 
elapsedTime2 = time2 - time1
cat("Value of system clock after coord read and E calc = \n")
print(time2)
totalTime = time2 - time0


#   
#   Step 6 - write out the results 
cat("                         Final Results\n")
cat("                         -------------\n")
cat("                   Num Pairs = ",cut_count, "\n")
cat("                     Total E = ",total_e, "\n")
cat("     Time to read coord file =", as.numeric(elapsedTime[3]), "Seconds\n")
cat("         Time to calculate E =", as.numeric(elapsedTime2[3]), "Seconds\n") 
cat("        Total Execution Time =", as.numeric(totalTime[3]), "Seconds\n")
