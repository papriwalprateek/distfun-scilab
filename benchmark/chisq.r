// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// Test the Chi-Square law in the R language
//
//
// Test the PDF
//
dchisq(1,1)
dchisq(0.22,5)
dchisq(0.00001,1)
dchisq(10,5)
dchisq(1000,10)
dchisq(10 ^ -100,1)
dchisq(10 ^ 100,1)
dchisq(9,10 ^ 5)
dchisq(10,10)
dchisq(50,5)
//
// Test the CDF
//
pchisq(1,1)
pchisq(0.22,5)
pchisq(0.00001,1)
pchisq(10,5)
pchisq(1000,10)
pchisq(10 ^ -100,1)
pchisq(10 ^ 100,1)
pchisq(9,10 ^ 5)
pchisq(10,10)
pchisq(50,5)
//
//

# Testing with R
# [Xn Pr PDF-P CDF-P CDF-Q]

x  <- c(1,0.22,0.00001,10,1000,10 ^ -100,10 ^ 100,9,10,50)
k  <- c(1,5,1,5,10,1,1,10 ^ 5,10,5)

row <- c(0,0,0,0,0)
for (i in 1:length(x)) {
	row[1] = x[i]
	row[2] = k[i]
	row[3] = dchisq(x[i],k[i])
	row[4] = pchisq(x[i],k[i])
	row[5] = pchisq(x[i],k[i],lower.tail = FALSE)
	print(row,digits=17)
}

}
