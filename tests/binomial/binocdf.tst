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

p = distfun_binocdf([],[],[]);
assert_checkequal(p,[]);

// Check with X scalar, N scalar, Pr scalar
//
computed = distfun_binocdf(100,162,0.5);
expected = 0.9989567;
assert_checkalmostequal(computed,expected,1.e-7);

// Check with expanded X
computed = distfun_binocdf([5 15],100,0.05);
expected = [0.6159991 0.9999629];
assert_checkalmostequal(computed,expected,1.e-7);

// Check with expanded N
computed = distfun_binocdf(5,[50 100],0.05);
expected = [0.9622238 0.6159991];
assert_checkalmostequal(computed,expected,1.e-7);

// Check with expanded Pr
computed = distfun_binocdf(5,50,[0.05 0.1]);
expected = [0.9622238 0.6161230];
assert_checkalmostequal(computed,expected,1.e-7);

// Check with two arguments expanded 
computed = distfun_binocdf([5 10],[50 100],0.05);
expected = [0.9622238 0.9885276];
assert_checkalmostequal(computed,expected,1.e-7);

computed = distfun_binocdf([5 10],100,[0.05 0.1]);
expected = [0.6159991 0.5831555];
assert_checkalmostequal(computed,expected,1.e-7);

computed = distfun_binocdf(5,[50 100],[0.05 0.1]);
expected = [0.9622238 0.0575769];
assert_checkalmostequal(computed,expected,1.e-6);

// Check with all the arguments expanded
computed = distfun_binocdf([5 10],[50 100],[0.05 0.1]);
expected = [0.9622238 0.5831555];
assert_checkalmostequal(computed,expected,1.e-7);

//
// Check vectorisation
//
N = 100;
Pr = 0.22;
X = linspace(1,100,10);
p = distfun_binocdf(X,N,Pr);
p2 = [];
for i = 1:10
    p2(1,i) = distfun_binocdf(X(i),N,Pr);
end
assert_checkequal(p,p2);

// Accuracy test using data in binocdf_yalta.dataset.csv file
precision = 1.e-5;
path=distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","binomial","binocdf_yalta.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);
ntests = size(table,"r");
for i = 1 : ntests
  x = table(i,1);
  N = table(i,2);
  pr = table(i,3);
  expected = table(i,4);
  computed = distfun_binocdf(x,N,pr);
  assert_checkalmostequal ( computed , expected , precision );
  // Compute number of significant digits
  if ( %f ) then
    d = assert_computedigits ( computed , expected );
    mprintf("Test #%d/%d: Digits = %.1f\n",i,ntests,d);
  end
end

// Accuracy test using data in binocdf.R.dataset.csv file
precision = 1.e-12;
path=distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","binomial","binocdf.R.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);
ntests = size(table,"r");
for i = 1 : ntests
  x = table(i,1);
  N = table(i,2);
  pr = table(i,3);
  expected = table(i,5);
  computed = distfun_binocdf(x,N,pr);
  assert_checkalmostequal ( computed , expected , precision );
  // Compute number of significant digits
  if ( %f ) then
    d = assert_computedigits ( computed , expected );
    mprintf("Test #%d/%d: Digits = %.1f\n",i,ntests,d);
  end
end

// Accuracy test using data in binomialcdf.dataset.csv file
precision = 1.e-5;
path=distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","binomial","binomialcdf.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);
ntests = size(table,"r");
for i = 1 : ntests
  x = table(i,1);
  N = 1030;
  pr = 0.5;
  expected = table(i,2);
  computed = distfun_binocdf(x,N,pr);
  assert_checkalmostequal ( computed , expected , precision );
  // Compute number of significant digits
  if ( %f ) then
    d = assert_computedigits ( computed , expected );
    mprintf("Test #%d/%d: Digits = %.1f\n",i,ntests,d);
  end
end

// check upper tail
p = distfun_binocdf(3,10,0.1);
lt_expected = 0.9872048;
assert_checkalmostequal(p,lt_expected,1.e-7);
//
clear p;
q = distfun_binocdf(3,10,0.1,%f);
ut_expected = 0.0127952;
assert_checkalmostequal(q,ut_expected,1.e-6);
//
// Check extreme upper tail
q = distfun_binocdf(3,10,0.00001,%f);
assert_checkalmostequal(q,2.099899202099975904e-18);
