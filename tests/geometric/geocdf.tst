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
p = distfun_geocdf([],[]);
assert_checkequal(p,[]);
//
//Test distfun_geocdf
//
p = distfun_geocdf(3,0.5);
assert_checkalmostequal(p,0.9375,1.e-4);

//
//Test with expanded Xn
computed = distfun_geocdf([2 3],0.33);
expected = [0.699237 0.7984888];
assert_checkalmostequal(computed,expected,10.^-7);

//
//Test with expanded Pr
//
computed = distfun_geocdf(3,[0.2 0.4]);
expected = [0.5904 0.8704];
assert_checkalmostequal(computed,expected,10^-7);

//
// Test with both the arguments expanded
computed = distfun_geocdf([3 4 8],[0.5 0.8 0.2]);
expected = [0.9375 0.99968 0.8657823];
assert_checkalmostequal(computed,expected,10^-7);


//
//Check vectorisation
//
Pr = 0.3;
Xn = linspace(1,100,10);
p = distfun_geocdf(Xn,Pr);

p2 = [];

for i = 1:10
    p2(1,i) = distfun_geocdf(Xn(i),Pr);
end

assert_checkequal(p,p2);

// Accuracy test using data in geopdf.dataset.csv file
precision = 1.e-8;
path=distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","geometric","geopdf.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);

ntests = size(table,"r");
for i = 1 : ntests
  Xn = table(i,1);
  Pr = table(i,2);
  expected = table(i,4);
  computed = distfun_geocdf(Xn,Pr);
  assert_checkalmostequal ( computed , expected , precision );
  // Compute number of significant digits
  if ( %f ) then
    d = assert_computedigits ( computed , expected );
    mprintf("Test #%d/%d: Digits = %.1f\n",i,ntests,d);
  end
end

// Accuracy test using data in geopdf.R.dataset.csv file
precision = 1.e-8;
path=distfun_getpath();
dataset = fullfile(path,"tests","unit_tests","geometric","geopdf.R.dataset.csv");
table = assert_csvread ( dataset , "," , [] , "/#(.*)/" );
table = evstr(table);
ntests = size(table,"r");
for i = 1 : ntests
  Xn = table(i,1);
  Pr = table(i,2);
  expected = table(i,4);
  computed = distfun_geocdf(Xn,Pr);
  assert_checkalmostequal ( computed , expected , precision );
  // Compute number of significant digits
  if ( %f ) then
    d = assert_computedigits ( computed , expected );
    mprintf("Test #%d/%d: Digits = %.1f\n",i,ntests,d);
  end
end


///////////////////////////////////////////////////////////////

//check upper tail

p = distfun_geocdf(3,0.1);
lt_expected = 0.3439;
assert_checkalmostequal(p,lt_expected,10.^-7);

q = distfun_geocdf(3,0.1,%f);
ut_expected = 0.6561;
assert_checkalmostequal(q,ut_expected,10.^-7);

// Check upper tail

p = distfun_geocdf(100,0.5,%f);
expected = 3.944304526105059027D-31;
assert_checkalmostequal(p,expected);
//
// Check extreme probability
// See http://forge.scilab.org/index.php/p/distfun/issues/774/
p = distfun_geocdf(1,1.e-20);
assert_checkalmostequal(p,2e-20);

