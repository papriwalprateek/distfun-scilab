// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// <-- JVM NOT MANDATORY -->


//
// Test distfun_binopdf
//
// Check empty matrix

y = distfun_binopdf([],[],[]);
assert_checkequal(y,[]);

// Check with X scalar, N scalar, Pr scalar
y = distfun_binopdf(0,200,0.02);
assert_checkalmostequal(y,0.0175879,1.e-5);

// Check with expanded X
computed = distfun_binopdf([5 15],100,0.05);
expected = [0.1800178 9.8800163e-5];
assert_checkalmostequal(computed,expected,1.e-6);

// Check with expanded N
computed = distfun_binopdf(5,[50 100],0.05);
expected = [0.0658406 0.1800178];
assert_checkalmostequal(computed,expected,1.e-6);

// Check with expanded Pr
computed = distfun_binopdf(5,50,[0.05 0.1]);
expected = [0.0658406 0.1849246];
assert_checkalmostequal(computed,expected,1.e-6);

// Check with two arguments expanded 
computed = distfun_binopdf([5 10],[50 100],0.05);
expected = [0.0658406 0.0167159];
assert_checkalmostequal(computed,expected,1.e-6);

computed = distfun_binopdf([5 10],100,[0.05 0.1]);
expected = [0.1800178 0.1318653];
assert_checkalmostequal(computed,expected,1.e-6);

computed = distfun_binopdf(5,[50 100],[0.05 0.1]);
expected = [0.0658406 0.0338658];
assert_checkalmostequal(computed,expected,1.e-6);

// Check with all the arguments expanded
computed = distfun_binopdf([5 10],[50 100],[0.05 0.1]);
expected = [0.0658406 0.1318653];
assert_checkalmostequal(computed,expected,1.e-6);

// Check distfun_binopdf for values of pr closer to 1
computed = distfun_binopdf(1,2,0.9999);
expected = 1.999799999999779835D-04;
assert_checkalmostequal(computed,expected);

// Check vectorisation
N = 100;
Pr = 0.1;
X = linspace(1,100,10);
y = distfun_binopdf(X,N,Pr);
y2 = [];
for i = 1:10
    y2(1,i) = distfun_binopdf(X(i),N,Pr);
end
assert_checkequal(y,y2);

// Accuracy tests with data present in binocdf.R.dataset.csv
//
precision = 10^-12;
path = distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","binomial","binocdf.R.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);
ntests = size(table,"r");
for i = 1 : ntests
  x = table(i,1);
  N = table(i,2);
  pr = table(i,3);
  expected = table(i,4);
  computed = distfun_binopdf(x,N,pr);
  assert_checkalmostequal ( computed , expected , precision );
end

// Check consistency CDF/PDF
N = 100;
Pr = 0.1;
p = linspace(0.01,0.99,10);
x = distfun_binoinv(p,N,Pr);
y1 = distfun_binopdf(x,N,Pr);
y2 = [];
for i=1:10
    if(x(1,i)==0) then
        y2(1,i)=distfun_binocdf(x(i),N,Pr);
    else
        y2(1,i)=distfun_binocdf(x(i),N,Pr)-distfun_binocdf(x(i)-1,N,Pr);
    end
    
end
assert_checkalmostequal ( y1 , y2 , 1.e-6 , [] , "element");

// See http://forge.scilab.org/index.php/p/distfun/issues/900
x=1;
N=1.e20;
pr=1.e-20;
computed = distfun_binopdf(x,N,pr);
expected = 0.3678794;
assert_checkalmostequal ( computed , expected , 1.e-6 );
//
x=2;
N=1.e20;
pr=1.e-20;
computed = distfun_binopdf(x,N,pr);
expected = 0.1839397;
assert_checkalmostequal ( computed , expected , 1.e-6 );

