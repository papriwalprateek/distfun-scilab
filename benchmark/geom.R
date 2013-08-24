// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// Test the Geometric law in the R language
//
// Default is the rate, this is why we specify the scale.
options(digits=20)
//
// Test the PDF
//
dgeom(1,0.1)
dgeom(3,0.99)
dgeom(10,0.5)
dgeom(11,0.3333)
dgeom(11,0.00000001)
dgeom(300,0.7)
dgeom(300,0.99)
dgeom(30,0.7)
dgeom(100,0.22)
dgeom(30,0.99999999999999)
//
// Test the CDF
//
dgeom(1,0.1)
dgeom(3,0.99)
dgeom(10,0.5)
dgeom(11,0.3333)
dgeom(11,0.00000001)
dgeom(300,0.7)
dgeom(300,0.99)
dgeom(30,0.7)
dgeom(100,0.22)
dgeom(30,0.99999999999999)
//
//
//

# Testing with R
# [Xn Pr PDF-P CDF-P CDF-Q]

Xn  <- c(1,3,10,11,11,300,300,30,100,30,100)
Pr  <- c(0.1,0.99,0.5,0.3333,0.00000001,0.7,0.99,0.7,0.22,0.99999999999999,0.5)

row <- c(0,0,0,0,0)
for (i in 1:length(Xn)) {
	row[1] = Xn[i]
	row[2] = Pr[i]
	row[3] = dgeom(Xn[i],Pr[i])
	row[4] = pgeom(Xn[i],Pr[i])
	row[5] = pgeom(Xn[i],Pr[i],lower.tail = FALSE)
	print(row,digits=17)
}

}