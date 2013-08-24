
// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// Test the Binomial the R language
//
//
// Test the PDF
//
dbinom(1,1030,0.5)
dbinom(400,1030,0.5)
dbinom(589,1030,0.5)
dbinom(1,30,0.1)
dbinom(1,50,0.001)
dbinom(16,30,0.999)
dbinom(1,240,0.9999)
dbinom(28,100,022)
dbinom(152,1000,0.71)
dbinom(3,1080,0.001)
 
//
// Test the CDF
//
pbinom(1,1030,0.5)
pbinom(400,1030,0.5)
pbinom(589,1030,0.5)
pbinom(1,30,0.1)
pbinom(1,50,0.001)
pbinom(16,30,0.999)
pbinom(1,240,0.9999)
pbinom(28,100,022)
pbinom(152,1000,0.71)
pbinom(3,1080,0.001)
//
//

# Testing with R
# [x N pr PDF-P CDF-P CDF-Q]

x  <- c(1,400,589,1,1,16,1,28,152,3)
N  <- c(1030,1030,1030,30,50,30,240,100,1000,1080)
pr  <- c(0.5,0.5,0.5,0.1,0.001,0.999,0.9999,0.22,0.71,0.001)

row <- c(0,0,0,0,0,0)
for (i in 1:length(x)) {
	row[1] = x[i]
	row[2] = N[i]
	row[3] = pr[i]
	row[4]= dbinom(x[i],N[i],pr[i])
	row[5]= pbinom(x[i],N[i],pr[i])
	row[6]= pbinom(x[i],N[i],pr[i],lower.tail = FALSE)
	print(row,digits=17)
}

p  <- c(0.1,0.4,0.01,0.9,0.99,0.6,0.11,0.9999)
N  <- c(1030,1030,1030,30,30,240,100,1000)
pr  <- c(0.5,0.5,0.5,0.1,0.999,0.9999,0.22,0.71)

row <- c(0,0,0,0)
for (i in 1:length(p)) {
	row[1] = p[i]
	row[2] = N[i]
	row[3] = pr[i]
	row[4]= qbinom(p[i],N[i],pr[i])
	print(row,digits=17)
}
