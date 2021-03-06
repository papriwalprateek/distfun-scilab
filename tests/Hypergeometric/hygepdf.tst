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
// Test distfun_hygepdf
//
// Check empty matrix
p = distfun_hygepdf([],[],[],[]);
assert_checkequal(p,[]);
//
p=distfun_hygepdf(0,9,5,6);
assert_checkequal(p,0);
//
// Tests with all the arguments scalar
computed = distfun_hygepdf(20,80,50,30);
expected = 0.1596136;
assert_checkalmostequal(computed,expected,1.e-6);
//
// Check that input arguments are correctly checked.
x=[0 17];
M=80;
k=60;
N=30;
computed=distfun_hygepdf(x,M,k,N);
expected = [0.   3.3836127e-003];
assert_checkalmostequal(computed,expected,1.e-6);
//
// Test with x expanded
computed = distfun_hygepdf([20 17],80,50,30);
expected = [0.1596136 0.1329349];
assert_checkalmostequal(computed,expected,1.e-6);
//
// Test with M expanded
computed = distfun_hygepdf(20,[80 100],50,30);
expected = [0.1596136 0.0164823];
assert_checkalmostequal(computed,expected,1.e-5);
//
// Test with x,N expanded
computed = distfun_hygepdf([20 17],80,[50 60],30);
expected = [0.1596136 0.0033836];
assert_checkalmostequal(computed,expected,1.e-5);
//
// Test with all the arguments expanded
computed = distfun_hygepdf([20 17 15],[100 80 90],[50 60 70],[30 20 18]);
expected = [0.0164823 0.1248637 0.2170354];
assert_checkalmostequal(computed,expected,1.e-5);
//
// Check vectorisation
// The parameters below are chosen so that 
// the minimum x such that p(x)>0 is x=10.
// For x=0,1,...,9, p(x)=0.
//
M = 100;
k = 50;
N = 60;
x = floor(linspace(0,40,10));
p = distfun_hygepdf(x,M,k,N);
p2 = [];
for i = 1:10
    p2(1,i) = distfun_hygepdf(x(i),M,k,N);
end
assert_checkequal(p,p2);

// Accuracy test using data in hypergeometric.R.dataset.csv file
precision = 1.e-12;
path=distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","Hypergeometric","hypergeometric.R.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);

ntests = size(table,"r");
for i = 1 : ntests
  x = table(i,1);
  M = table(i,2);
  k = table(i,3);
  N = table(i,4);
  expected = table(i,5);
  computed = distfun_hygepdf(x,M,k,N);
  assert_checkalmostequal ( computed , expected , precision );
  // Compute number of significant digits
  if ( %f ) then
    d = assert_computedigits ( computed , expected );
    mprintf("Test #%d/%d: Digits = %.1f\n",i,ntests,d);
  end
end

// Accuracy test using data in hypergeometric_yalta.dataset.csv file
precision = 1.e-5;
path=distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","Hypergeometric","hypergeometric_yalta.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);
ntests = size(table,"r");
for i = 1 : ntests
  x = table(i,1);
  M = table(i,2);
  k = table(i,3);
  N = table(i,4);
  expected = table(i,5);
  computed = distfun_hygepdf(x,M,k,N);
  assert_checkalmostequal ( computed , expected , precision );
  // Compute number of significant digits
  if ( %f ) then
    d = assert_computedigits ( computed , expected );
    mprintf("Test #%d/%d: Digits = %.1f\n",i,ntests,d);
  end
end

// Check consistency CDF/PDF
M = 100;
N = 60;
k = 40;
n = 10;
p = linspace(0.01,0.99,n);
x = distfun_hygeinv(p,M,k,N);
p1 = distfun_hygepdf(x,M,k,N);
p2 = [];
for i=1:n
    if(x(i)==0) then
        p2(1,i)=distfun_hygecdf(x(i),M,k,N);
    else
        p2(1,i)=distfun_hygecdf(x(i),M,k,N)-distfun_hygecdf(x(i)-1,M,k,N);
    end
    
end
assert_checkalmostequal ( p1 , p2 , 1.e-7 , [] , "element");
//
// Check accuracy
computed = distfun_hygepdf ( 200 , 1030 , 500 , 515 );
expected = 1.6557e-10;
assert_checkalmostequal(computed,expected,1.e-4);
