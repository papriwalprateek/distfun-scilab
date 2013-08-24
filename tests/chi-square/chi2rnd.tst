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
r = distfun_chi2rnd([]);
assert_checkequal(r,[]);

// set the initial seed for tests
distfun_seedset(1);
// Test with expanded k
computed = distfun_chi2rnd((1:6));
expected = [
    9.725889821404753999D-02    5.606986655143224585D-01    1.581889671734412861D+00    8.146710214654660831D+00    5.061479166520056694D+00    4.495127186591671986D+00  ];
assert_checkequal ( size ( computed ) , [1 6] );
assert_checkequal ( computed , expected );
//
//
//Check expansion of Pr in R = distfun_geornd(Pr)

distfun_seedset(1);
N = 10;
k = (1:6);
computed1 = [];
for i = 1:N
    computed1(1:6,i) = distfun_chi2rnd(k)';
end

distfun_seedset(1);
computed2  = [];
for i = 1:N
    for l = 1 : 6
        computed2(l,i)=distfun_chi2rnd(k(l));
    end
end

assert_checkequal(computed1,computed2);
//
// Check R = distfun_geornd(k,v)
computed = distfun_chi2rnd(2,[4 5]);
assert_checkequal(size(computed),[4 5]);
//
// Check mean and variance
N = 50000;
k = 3;
computed = distfun_chi2rnd(k,[1 N]);
[M,V] = distfun_chi2stat (k);
c = mean(computed(1:N));
assert_checkalmostequal ( c , M , 0.1 );
d = st_deviation(computed(1:N) );
assert_checkalmostequal ( d .^ 2 , V , 0.1 );