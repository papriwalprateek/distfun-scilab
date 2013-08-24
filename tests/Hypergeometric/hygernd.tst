// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// <-- JVM NOT MANDATORY -->

////////////////////////////////////////////////////////////
//
// Check empty matrix
r = distfun_hygernd([],[],[]);
assert_checkequal(r,[]);

// Check R = distfun_geornd(M,k,N,v)
computed = distfun_hygernd(80,50,30,[4 5]);
assert_checkequal(size(computed),[4 5]);

// Check mean and variance
M = 8;
k = 3;
N = 5;
n = 100;
computed = distfun_hygernd(M,k,N,[1 n]);
[m,v] = distfun_hygestat(M,k,N);
c = mean(computed);
assert_checkalmostequal ( c , m , 0.5 );
d = variance(computed);
assert_checkalmostequal ( d , v , 0.5 );
