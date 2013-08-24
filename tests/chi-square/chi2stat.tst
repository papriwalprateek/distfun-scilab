// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

//
// Check empty matrix
[M,V] = distfun_chi2stat ( [] );
assert_checkequal ( M , [] );
assert_checkequal ( V , [] );
//
// Test with expanded k
[m,v] = distfun_chi2stat((1:6))
me = [ 1 2 3 4 5 6];
assert_checkalmostequal(m,me);
ve = [ 2 4 6 8 10 12];
assert_checkalmostequal(v,ve);

//
//Accuracy test
k=[3 6 9];
[M,V] = distfun_chi2stat ( k )
ve= [6 12 18];
assert_checkalmostequal(V,ve);
me = [3 6 9];
assert_checkalmostequal(M,me);
