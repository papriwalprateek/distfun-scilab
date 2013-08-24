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
r = distfun_geornd([]);
assert_checkequal(r,[]);

// set the initial seed for tests
distfun_seedset(1);

// Test with expanded Pr
computed = distfun_geornd(1 ./(1:6));
expected = [1.    0.    14.    4.    12.    0.];
assert_checkequal ( size ( computed ) , [1 6] );
assert_checkequal ( computed , expected );

//Check expansion of Pr in R = distfun_geornd(Pr)

distfun_seedset(1);
N = 10;
Pr = 1 ./(1:6);
computed1 = [];
for i = 1:N
    computed1(1:6,i) = distfun_geornd(Pr)';
end

distfun_seedset(1);
computed2  = [];
for i = 1:N
    for k = 1 : 6
        computed2(k,i)=distfun_geornd(Pr(k));
    end
end

assert_checkequal(computed1,computed2);
////////////////////////////////////////////////////////////

//Check R = distfun_geornd(Pr,v)

computed = distfun_geornd(0.2,[4 5]);
assert_checkequal(size(computed),[4 5]);


//Check mean and variance
N = 5000;
Pr = 0.3;

computed = distfun_geornd(Pr,[1 N]);
c = mean(computed(1:N));
[M,V] = distfun_geostat (Pr);
assert_checkalmostequal ( c , M , 0.1 );
c = st_deviation(computed(1:N) );
assert_checkalmostequal ( c.^2 , V , 1 );