// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function R = distfun_binornd(varargin)
    // Binomial random numbers
    //
    // Calling Sequence
    //   R = distfun_binornd(N,pr)
    //   R = distfun_binornd(N,pr,v)
    //   R = distfun_binornd(N,pr,m,n)
    //
    // Parameters
    //   N : a 1x1 or nxm matrix of doubles , the total number of binomial trials . N belongs to the set {1,2,3,4,.......}
    //   pr : a 1x1 or nxm matrix of doubles, the probability of getting success in a Bernoulli trial
    //   v : a 1x2 or 2x1 matrix of doubles, the size of R
    //   v(1) : the number of rows of R
    //   v(2) : the number of columns of R
    //   m : a 1x1 matrix of floating point integers, the number of rows of R
    //   n : a 1x1 matrix of floating point integers, the number of columns of R
    //   R: a matrix of doubles, the random numbers, in the set {0,1,2,3,...}.
    //
    //
    // Description
    //   Generates random variables from the Binomial distribution function.
    //
    //   Any scalar input argument is expanded to a matrix of doubles 
    //   of the same size as the other input arguments.
    //
    //   As a side effect, it modifies the internal seed of the grand function.
    //
    // Examples
    //
    // // set the initial seed for tests
    // distfun_seedset(1)
    //
    // // Check with expanded N
    // N = [10 100 1000 10000]
    // pr = 0.1
    // computed = distfun_binornd(N, pr)
    // expected = [1 19 98 964]
    //
    // // set the initial seed
    // distfun_seedset(1)
    // // Check with expanded pr
    // N =100
    // pr = [0.1 0.2 0.3 0.4]
    // computed = distfun_binornd(N, pr)
    // expected = [9 32 29 38]
    //
    // //Check R = distfun_binornd(pr,v)
    // computed = distfun_binornd(100,0.2,[4 5])
    //
    // //Check mean and variance
    // N = 1000
    // pr = 0.3
    // n = 5000
    // R = distfun_binornd(N,pr,[1 n]);
    // RM = mean(R)
    // RV = variance(R)
    // [M,V] = distfun_binostat(N,pr)
    //
    // Bibliography
    // http://en.wikipedia.org/wiki/Binomial_distribution
    //
    // Authors
    // Copyright (C) 2012 - Prateek Papriwal
    //
    path = distfun_getpath()
    internallib = lib(fullfile(path,"macros","internals"))
    
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_binornd",rhs,2:4)
    apifun_checklhs("distfun_binornd",lhs,0:1)
    
    N = varargin(1)
    pr = varargin(2)
    //
    // Check type
    apifun_checktype("distfun_binornd",N,"N",1,"constant")
    apifun_checktype("distfun_binornd",pr,"pr",2,"constant")
    //
    apifun_checkflint("distfun_binornd",N,"N",1)
    //
    if ( rhs == 3 ) then
        v = varargin(3)
    end
    if ( rhs == 4 ) then
        m = varargin(3)
        n = varargin(4)
    end
    //
    // Check v,m,n
    distfun_checkvmn ( "distfun_binornd" , 3 , varargin(3:$) )
    
    [N,pr] = apifun_expandfromsize ( 2 , varargin(1:$) )
    if (N == []) then
        R = []
        return
    end
    
    m = size(pr,"r")
    n = size(pr,"c")
    
    R = distfun_grandbin(m,n,N,pr)
    
endfunction
