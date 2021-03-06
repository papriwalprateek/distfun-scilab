// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// <-- JVM NOT MANDATORY -->



//
// Check empty matrix
X = distfun_binoinv([],[],[]);
assert_checkequal(X,[]);

// Check with all arguments scalar
X = distfun_binoinv(0.21,162,0.5);
expected = 76;
assert_checkequal(X,expected);

// check with p expanded

X = distfun_binoinv([0.05 0.95],162,0.5);
expected = [71 91];
assert_checkequal(X,expected);

// Check with N expanded

X = distfun_binoinv(0.05,[100 162],0.5);
expected = [42 71];
assert_checkequal(X,expected);

// Check with expanded Pr

X = distfun_binoinv(0.05,162,[0.2 0.5]);
expected = [24 71];
assert_checkequal(X,expected);

//Check with all arguments expanded

X = distfun_binoinv([0.05 0.95],[100 162],[0.2 0.5]);
expected = [14 91];
assert_checkequal(X,expected);

// Accuracy test using data in binoinv.R.dataset.csv file
precision = 1.e-12;
path=distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","binomial","binoinv.R.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);

ntests = size(table,"r");
for i = 1 : ntests
  p = table(i,1);
  N = table(i,2);
  pr = table(i,3);
  expected = table(i,4);
  computed = distfun_binoinv(p,N,pr);
  assert_checkalmostequal ( computed , expected , precision );
  // Compute number of significant digits
  if ( %f ) then
    d = assert_computedigits ( computed , expected );
    mprintf("Test #%d/%d: Digits = %.1f\n",i,ntests,d);
  end
end


// check vectorisation

N = 20;
Pr = 0.5;
p = linspace(0.1,0.9,10);
X = distfun_binoinv(p,N,Pr);

x2 = [];

for i=1:10
    x2(1,i) = distfun_binoinv(p(i),N,Pr);
end

assert_checkalmostequal(X,x2);



