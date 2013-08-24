// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function R = distfun_chi2rnd(varargin)
    // Chi-Square random numbers
    //
    // Calling Sequence
    //   R = distfun_chi2rnd(k)
    //   R = distfun_chi2rnd(k,v)
    //   R = distfun_chi2rnd(k,m,n)
    //
    // Parameters
    //   k : a 1x1 or nxm matrix of doubles, the number of degrees of freedom. k belongs to the set {1,2,3.......}
    //   v : a 1x2 or 2x1 matrix of doubles, the size of R
    //   v(1) : the number of rows of R
    //   v(2) : the number of columns of R
    //   m : a 1x1 matrix of floating point integers, the number of rows of R
    //   n : a 1x1 matrix of floating point integers, the number of columns of R
    //   R: a matrix of doubles, the positive random numbers.
    //
    // Description
    //   Generates random variables from the Chi-Sqaure distribution function.
    //
    //   Any scalar input argument is expanded to a matrix of doubles 
    //   of the same size as the other input arguments.
    //
    //   As a side effect, it modifies the internal seed of the grand function.
    //
    // Examples
    // // set the initial seed for tests
    // distfun_seedset(1);
    // // Test with expanded k
    // computed = distfun_chi2rnd((1:6))
    // expected = [1.8608435 1.2995079 2.8402769 0.9538728 4.5217814 2.9898461]
    //
    // // Check R = distfun_geornd(k,v)
    // computed = distfun_chi2rnd(2,[4 5])
    //
    // // Check mean and variance
    // N = 50000;
    // k = 3;
    // computed = distfun_chi2rnd(k,[1 N]);
    // c = mean(computed(1:N))
    // d = st_deviation(computed(1:N) )
    // [M,V] = distfun_chi2stat (k)
    //
    // Bibliography
    // http://en.wikipedia.org/wiki/Chi-squared_distribution
    //
    // Authors
    // Copyright (C) 2012 - Prateek Papriwal
    //

    path = distfun_getpath()
    internallib = lib(fullfile(path,"macros","internals"))

    [lhs,rhs] = argn()

    apifun_checkrhs("distfun_chi2rnd",rhs,1:3)
    apifun_checklhs("distfun_chi2rnd",lhs,0:1)

    k = varargin(1)
    //
    // Check type
    apifun_checktype("distfun_chi2rnd",k,"k",1,"constant")

    if ( rhs == 2 ) then
        v = varargin(2)
    end
    if ( rhs == 3 ) then
        m = varargin(2)
        n = varargin(3)
    end
    //
    // Check v,m,n
    distfun_checkvmn ( "distfun_geornd" , 2 , varargin(2:$) )

    k = apifun_expandfromsize ( 1 , varargin(1:$) )

    if(k == []) then
        R = []
        return
    end

    m = size(k,"r")
    n = size(k,"c")

    R = distfun_grandchi(m,n,k)

endfunction