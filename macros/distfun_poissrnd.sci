// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function R = distfun_poissrnd(varargin)
    // Poisson random numbers
    //
    // Calling Sequence
    //   R = distfun_poissrnd(lambda)
    //   R = distfun_poissrnd(lambda,v)
    //   R = distfun_poissrnd(lambda,m,n)
    //
    // Parameters
    //   lambda : a 1x1 or nxm matrix of doubles,  the average rate of occurrence 
    //   v : a 1x2 or 2x1 matrix of doubles, the size of R
    //   v(1) : the number of rows of R
    //   v(2) : the number of columns of R
    //   m : a 1x1 matrix of floating point integers, the number of rows of R
    //   n : a 1x1 matrix of floating point integers, the number of columns of R
    //   R: a matrix of doubles, the random numbers in the set {0,1,2,3,...}.
    //
    // Description
    //   Generates random variables from the Poisson distribution function.
    //
    //   Any scalar input argument is expanded to a matrix of doubles 
    //   of the same size as the other input arguments.
    //
    //   As a side effect, it modifies the internal seed of the grand function.
    //
    // Examples
    //
    // // set the initial seed for tests
    // distfun_seedset(1);
    // // Test with expanded lambda
    // computed = distfun_poissrnd(1:6)
    // expected = [1 7 4 7 0 3];
    //
    // // Check expansion of lambda in R = distfun_poissrnd(lambda)
    // distfun_seedset(1);
    // computed = distfun_poissrnd([12 14 20])
    // expected = [11 24 20];
    // // Check R = distfun_poissrnd(lambda,v)
    // computed = distfun_poissrnd(2,[4 5])
    //
    // // Check mean and variance
    // N = 50000;
    // lambda = 13;
    // computed = distfun_poissrnd(lambda,[1 N]);
    // c = mean(computed(1:N))
    // d = st_deviation(computed(1:N) )
    // [M,V] = distfun_poissstat (lambda)
    //
    // Bibliography
    // http://en.wikipedia.org/wiki/Poisson_distribution
    // 
    // Authors
    // Copyright (C) 2012 - Prateek Papriwal
    // 
    path = distfun_getpath()
    internallib = lib(fullfile(path,"macros","internals"))

    [lhs,rhs] = argn()

    apifun_checkrhs("distfun_poissrnd",rhs,1:3)
    apifun_checklhs("distfun_poissrnd",lhs,0:1)

    lambda = varargin(1)
    //
    // Check type
    apifun_checktype("distfun_poissrnd",lambda,"lambda",1,"constant")

    if ( rhs == 2 ) then
        v = varargin(2)
    end
    if ( rhs == 3 ) then
        m = varargin(2)
        n = varargin(3)
    end
    //
    // Check v,m,n
    distfun_checkvmn ( "distfun_poissrnd" , 2 , varargin(2:$) )

    lambda = apifun_expandfromsize ( 1 , varargin(1:$) )

    if(lambda == []) then
        R = []
        return
    end

    m = size(lambda,"r")
    n = size(lambda,"c")

    R = distfun_grandpoi(m,n,lambda)
endfunction