// Copyright (C) 2012 - Prateek Papriwal
// Copyright (C) 2012 - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// <-- JVM NOT MANDATORY -->

//
// Check empty matrix
x = distfun_hygeinv ( [],[],[],[] );
assert_checkequal ( x , [] );
//
// Test with all the arguments scalar
x = distfun_hygeinv(0.2,80,50,30);
expected = 17;
assert_checkequal(x,expected);
//
x = distfun_hygeinv(0.8,80,50,30,%f);
expected = 17;
assert_checkequal(x,expected);
//
// Test with expanded p
x = distfun_hygeinv([0.2 0.9],80,50,30);
expected = [17 21];
assert_checkequal(x,expected);
//
// Test with expanded p,k
x = distfun_hygeinv([0.2 0.9],80,50,[30 35]);
expected = [17 25];
assert_checkequal(x,expected);
//
// Test with all the arguments expanded
x = distfun_hygeinv([0.2 0.9],[80 100],[50 60],[30 35]);
expected = [17 24];
assert_checkequal(x,expected);
//
// Check vectorisation
//
M = 80;
N = 50;
k = 30;
p = linspace(0.1,0.9,10);
x = distfun_hygeinv(p,M,k,N);
x2 = [];
for i=1:10
    x2(1,i) = distfun_hygeinv(p(i),M,k,N);
end
assert_checkalmostequal(x,x2);


// Accuracy test using data in hypergeometric.R.dataset.csv file
path=distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","Hypergeometric","hypergeometric.R.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);
ntests = size(table,"r");
precision=1.e-12;
for i = 1 : ntests
    expected = table(i,1);
    M = table(i,2);
    k = table(i,3);
    N = table(i,4);
    p = table(i,6);
    computed = distfun_hygeinv(p,M,k,N);
    pxm = distfun_hygecdf(computed-1,M,k,N);
    px = distfun_hygecdf(computed,M,k,N);
    assert_checktrue ( pxm<p*(1+precision) );
    assert_checktrue ( p<=px*(1+precision) );
end
//
// Test inversion at extreme x
// 1. Lower tail
//
x=distfun_hygeinv(0.,80,50,30);
expected=0;
assert_checkequal(x,expected);
//
x=distfun_hygeinv(1.127e-22,80,50,30);
expected=0;
assert_checkequal(x,expected);
//
x=distfun_hygeinv(1.128e-22,80,50,30);
expected=1;
assert_checkequal(x,expected);
//
x=distfun_hygeinv(1-1.e-9,80,50,30);
expected=30;
assert_checkequal(x,expected);
//
x = distfun_hygeinv(1.e-8,80,50,30);
expected = 7;
assert_checkequal(x,expected);
//
x=distfun_hygeinv(1.,80,50,30);
expected=30;
assert_checkequal(x,expected);
//
// 2. Upper tail
//
x=distfun_hygeinv(0.,80,50,30,%f);
expected=30;
assert_checkequal(x,expected);
//
x=distfun_hygeinv(1.e-100,80,50,30,%f);
expected=30;
assert_checkequal(x,expected);
//
x=distfun_hygeinv(1.e-9,80,50,30,%f);
expected=30;
assert_checkequal(x,expected);
//
x=distfun_hygeinv(1.e-8,80,50,30,%f);
expected=29;
assert_checkequal(x,expected);
//
x=distfun_hygeinv(1.e-6,80,50,30,%f);
expected=28;
assert_checkequal(x,expected);
//
x = distfun_hygeinv(1-1.e-8,80,50,30,%f);
expected = 7;
assert_checkequal(x,expected);
//
x=distfun_hygeinv(1.,80,50,30,%f);
expected=0;
assert_checkequal(x,expected);
//
// Performance
tic();
y = distfun_hygeinv(0:0.01:1,80,50,30);
t=toc();
assert_checktrue(t<1.);
//
