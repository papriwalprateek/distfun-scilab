// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// <-- JVM NOT MANDATORY -->



//
// Test distfun_geopdf
//
// Check empty matrix

p = distfun_geopdf([],[]);
assert_checkequal(p,[]);
//
////
//Check with Xn scalar, Pr scalar 
y = distfun_geopdf(3,0.5);
assert_checkalmostequal(y,0.0625,1.e-3);
//
//Check with expanded Xn
//
computed = distfun_geopdf([2 3],0.1);
expected = [0.081 0.0729];
assert_checkalmostequal(computed,expected,%eps);

//
//Check with expanded Pr
//
computed = distfun_geopdf(3,[0.2 0.4]);
expected = [0.1024 0.0864];
assert_checkalmostequal(computed,expected);

//
//Check with both the arguments expanded
//
computed = distfun_geopdf([3 4 8],[0.5 0.8 0.2]);
expected = [0.0625 0.00128 0.033554432];
assert_checkalmostequal(computed,expected);

//Accuracy tests with data present in geopdf.dataset.csv
//
precision = 10.^-13;
path=distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","geometric","geopdf.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);

ntests = size(table,"r");
for i = 1 : ntests
  Xn = table(i,1);
  Pr = table(i,2);
  expected = table(i,3);
  computed = distfun_geopdf(Xn,Pr);
  assert_checkalmostequal ( computed , expected , precision );
end

// Accuracy tests with data present in geopdf.R.dataset.csv
//
precision = 10^-12;
path = distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","geometric","geopdf.R.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);

ntests = size(table,"r");
for i = 1 : ntests
  Xn = table(i,1);
  Pr = table(i,2);
  expected = table(i,3);
  computed = distfun_geopdf(Xn,Pr);
  assert_checkalmostequal ( computed , expected , precision );
end

//Check vectorisation
//
Pr = 0.3;
Xn = linspace(1,100,10);
p = distfun_geopdf(Xn,Pr);

p2 = [];

for i = 1:10
    p2(1,i) = distfun_geopdf(Xn(i),Pr);
end

assert_checkequal(p,p2);

//Check consistency CDF/PDF
n = 10;
Pr = 0.3;
p = linspace(0.01,0.99,n)';
x = distfun_geoinv(p,Pr);
p1 = distfun_geopdf(x,Pr);
p2 = [];
for i=1:n
    if(x(i)==0) then
        p2(i)=distfun_geocdf(x(i),Pr);
    else
        p2(i)=distfun_geocdf(x(i),Pr)-distfun_geocdf(x(i)-1,Pr);
    end
    
end

assert_checkalmostequal ( p1 , p2 , 1.e-7 , [] , "element");