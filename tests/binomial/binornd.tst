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
r = distfun_binornd([],[]);
assert_checkequal(r,[]);

// set the initial seed for tests
distfun_seedset(1);

// Check with expanded N
N = [10 100 1000 10000];
Pr = 0.1;
computed = distfun_binornd(N, Pr);
expected = [1 19 98 964];
assert_checkequal ( size ( computed ) , [1 4] );
assert_checkequal ( computed , expected );

// set the initial seed
distfun_seedset(1);

//Check with expanded Pr
N =100;
Pr = [0.1 0.2 0.3 0.4];
computed = distfun_binornd(N, Pr);
expected = [9 32 29 38];
assert_checkequal ( size ( computed ) , [1 4] );
assert_checkequal ( computed , expected );

//Check expansion of Pr in R = distfun_binornd(N,Pr)

distfun_seedset(1);
N =100;
Pr = [0.1 0.2 0.3 0.4 0.5 0.6];
computed1 = [];
for i = 1:10
    computed1(1:6,i) = distfun_binornd(N,Pr)';
end

distfun_seedset(1);
computed2  = [];
for i = 1:10
    for k = 1 : 6
        computed2(k,i)=distfun_binornd(N,Pr(k));
    end
end

assert_checkequal(computed1,computed2);

//Check R = distfun_binornd(Pr,v)

computed = distfun_binornd(100,0.2,[4 5]);
assert_checkequal(size(computed),[4 5]);

//Check mean and variance
N = 1000;
Pr = 0.3;
n = 5000;
computed = distfun_binornd(N,Pr,[1 n]);
c = mean(computed(1:n));
[M,V] = distfun_binostat (N,Pr);
assert_checkalmostequal ( c , M , 0.1 );
c = st_deviation(computed(1:n) );
assert_checkalmostequal ( c.^2 , V , 1 );

