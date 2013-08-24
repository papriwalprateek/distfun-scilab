// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// <-- JVM NOT MANDATORY -->



//
// Test distfun_poisspdf
//
// Check empty matrix

p = distfun_poisspdf([],[]);
assert_checkequal(p,[]);

// Test with x scalar, lambda scalar
computed = distfun_poisspdf(0,2);
expected = 0.1353353;
assert_checkalmostequal(computed,expected,1.e-6);
//
// Test with x expanded, lambda scalar
computed = distfun_poisspdf([0 3],2);
expected = [0.1353353 0.1804470];
assert_checkalmostequal(computed,expected,1.e-6);
//
// Test with x scalar, lambda expanded
computed = distfun_poisspdf(3,[2 4]);
expected = [0.1804470 0.1953668];
assert_checkalmostequal(computed,expected,1.e-6);
//
// Test with both the arguments expanded
//
computed = distfun_poisspdf([3 4 8],[5 8 2]);
expected = [0.1403739 5.7252288e-2 8.5927164e-4];
assert_checkalmostequal(computed,expected,1.e-6);
//
// Check vectorisation
//
lambda = 3;
x = linspace(1,100,10);
p = distfun_poisspdf(x,lambda);
p2 = [];
for i = 1:10
    p2(1,i) = distfun_poisspdf(x(i),lambda);
end
assert_checkequal(p,p2);

// Accuracy tests with data present in poisspdf.yalta.dataset.csv
//
precision = 1.e-5;
path = distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","poisson","poisspdf.yalta.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);
ntests = size(table,"r");
for i = 1 : ntests
  x = table(i,1);
  lambda = table(i,2);
  expected = table(i,3);
  computed = distfun_poisspdf(x,lambda);
  assert_checkalmostequal ( computed , expected , precision );
end

// Accuracy tests with data present in poisspdf.R.dataset.csv
//
precision = 1.e-5;
path = distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","poisson","poisspdf.R.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);

ntests = size(table,"r");
for i = 1 : ntests
  x = table(i,1);
  lambda = table(i,2);
  expected = table(i,3);
  computed = distfun_poisspdf(x,lambda);
  assert_checkalmostequal ( computed , expected , precision );
end

