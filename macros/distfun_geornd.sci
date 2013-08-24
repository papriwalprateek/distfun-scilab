// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt


function R = distfun_geornd(varargin)
    // Geometric random numbers
    //
    // Calling Sequence
    //   R = distfun_geornd(pr)
    //   R = distfun_geornd(pr,v)
    //   R = distfun_geornd(pr,m,n)
    //
    // Parameters
    //   pr : a 1x1 or nxm matrix of doubles, the probability of getting success in a Bernoulli trial
    //   v : a 1x2 or 2x1 matrix of doubles, the size of R
    //   v(1) : the number of rows of R
    //   v(2) : the number of columns of R
    //   m : a 1x1 matrix of floating point integers, the number of rows of R
    //   n : a 1x1 matrix of floating point integers, the number of columns of R
    //   R: a matrix of doubles, the random numbers in the set {0,1,2,3,...}.
    //
    // Description
    //   Generates random variables from the Geometric distribution function.
    //
    //   Any scalar input argument is expanded to a matrix of doubles 
    //   of the same size as the other input arguments.
    //
    //   As a side effect, it modifies the internal seed of the grand function.
    //
    // Note - The output argument R belongs to the set {0,1,2,3,...}. 
    // This is not compatible with the <literal>grand(m,n,"geom",p)</literal> function in Scilab v5, 
    // where the choice is the set {1,2,3,...}. 
    // In other words, the calling sequence 
    //
    //<screen>
    // R = grand(m,n,"geom",pr)
    //</screen>
    //
    // is equivalent to 
    //
    //<screen>
    // R = distfun_geornd(pr,m,n) + 1
    //</screen>
    //
    // Examples
    // // set the initial seed for tests
    // distfun_seedset(1);
    // // Test with expanded pr
    // computed = distfun_geornd(1 ./(1:6))
    // expected = [1 0 14 4 12 0];
    //
    // // Check expansion of pr in R = distfun_geornd(pr)
    // distfun_seedset(1);
    // N = 10;
    // computed = distfun_geornd(1 ./(1:6))
    //
    // // Check R = distfun_geornd(pr,v)
    // computed = distfun_geornd(0.2,[4 5])
    //
    // // Check mean and variance
    // N = 5000;
    // pr = 0.3;
    // R = distfun_geornd(pr,[1 N]);
    // RM = mean(R)
    // RV = variance(R)
    // [M,V] = distfun_geostat(pr)
    //
    // Bibliography
    // http://en.wikipedia.org/wiki/Geometric_distribution
    // 
    // Authors
    // Copyright (C) 2012 - Prateek Papriwal
    //

    path = distfun_getpath()
    internallib = lib(fullfile(path,"macros","internals"))

    [lhs,rhs] = argn()

    apifun_checkrhs("distfun_geornd",rhs,1:3)
    apifun_checklhs("distfun_geornd",lhs,0:1)

    pr = varargin(1)
    //
    // Check type
    apifun_checktype("distfun_geornd",pr,"pr",1,"constant")

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

    pr = apifun_expandfromsize ( 1 , varargin(1:$) )

    if(pr == []) then
        R = []
        return
    end

    m = size(pr,"r")
    n = size(pr,"c")

    R = distfun_grandgeom(m,n,pr)

endfunction
