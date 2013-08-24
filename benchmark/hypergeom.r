
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
dhyper(0,515,515,500)
dhyper(100,515,515,500)
dhyper(187,515,515,500)
dhyper(188,515,515,500)
dhyper(200,515,515,500)
dhyper(300,515,515,500)
dhyper(312,515,515,500)
dhyper(313,515,515,500)
dhyper(400,515,515,500)
dhyper(500,515,515,500)
 
//
// Test the CDF
//
phyper(0,515,515,500)
phyper(100,515,515,500)
phyper(187,515,515,500)
phyper(188,515,515,500)
phyper(200,515,515,500)
phyper(300,515,515,500)
phyper(312,515,515,500)
phyper(313,515,515,500)
phyper(400,515,515,500)
phyper(500,515,515,500)
//
//

# Testing with R
# [x N pr PDF-P CDF-P CDF-Q]

x  <- c(0,100,187,188,200,300,312,313,400,500)
M  <- c(515,515,515,515,515,515,515,515,515,515)
k  <- c(515,515,515,515,515,515,515,515,515,515)
N  <- c(500,500,500,500,500,500,500,500,500,500)


row <- c(0,0,0,0,0,0,0)
for (i in 1:length(x)) {
	row[1] = x[i]
	row[2] = M[i]
	row[3] = k[i]
	row[4] = N[i]
	row[5]= dhyper(x[i],M[i],k[i],N[i])
	row[6]= phyper(x[i],M[i],k[i],N[i])
	row[7]= phyper(x[i],M[i],k[i],N[i],lower.tail = FALSE)
	print(row,digits=17)
}

