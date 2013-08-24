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
r = distfun_poissrnd([]);
assert_checkequal(r,[]);

// set the initial seed for tests
distfun_seedset(1);
// Test with expanded lambda
computed = distfun_poissrnd(1:6);
expected = [1 7 4 7 0 3];
assert_checkalmostequal(computed,expected,%eps);
//
// Check expansion of lambda in R = distfun_poissrnd(lambda)
distfun_seedset(1);
computed = distfun_poissrnd([12 14 20]);
expected = [11 24 20];
assert_checkalmostequal(computed,expected,%eps);
// Check R = distfun_poissrnd(lambda,v)
computed = distfun_poissrnd(2,[4 5]);
assert_checkequal(size(computed),[4 5]);
//
// Check mean and variance
N = 50000;
lambda = 13;
computed = distfun_poissrnd(lambda,[1 N]);
[M,V] = distfun_poissstat (lambda);
c = mean(computed(1:N));
assert_checkalmostequal(M,c,0.01);
d = st_deviation(computed(1:N) );
assert_checkalmostequal(V,d .* d,0.01);
