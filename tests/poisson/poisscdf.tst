// Copyright (C) 2012 - Prateek Papriwal
//
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// <-- JVM NOT MANDATORY -->


//
// Check empty matrix
p = distfun_poisscdf([],[]);
assert_checkequal(p,[]);
//
//Test with x scalar, lambda scalar
computed = distfun_poisscdf(0,2);
expected = 0.1353353;
assert_checkalmostequal(computed,expected,1.e-6);
//
// Test with x expanded, lambda scalar
computed = distfun_poisscdf([0 3],2);
expected = [0.1353353 0.8571235];
assert_checkalmostequal(computed,expected,1.e-6);
//
// Test with x scalar, lambda expanded 
computed = distfun_poisscdf(3,[2 4]);
expected = [0.8571235 0.4334701];
assert_checkalmostequal(computed,expected,1.e-6);
//
// Test with both the arguments expanded
//
computed = distfun_poisscdf([3 4 8],[5 8 2]);
expected = [0.2650259 0.0996324 0.9997626];
assert_checkalmostequal(computed,expected,1.e-6);

//
// Check vectorisation
//
lambda = 3;
x = linspace(1,100,10);
p = distfun_poisscdf(x,lambda);
p2 = [];
for i = 1:10
    p2(1,i) = distfun_poisscdf(x(i),lambda);
end
assert_checkequal(p,p2);

// check upper tail
p = distfun_poisscdf(3,1);
lt_expected = 0.9810118;
assert_checkalmostequal(p,lt_expected,1.e-7);

q = distfun_poisscdf(3,1,%f);
ut_expected = 0.0189882;
assert_checkalmostequal(q,ut_expected,1.e-5);

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
  expected = table(i,4);
  computed = distfun_poisscdf(x,lambda);
  assert_checkalmostequal ( computed , expected , precision );
end
