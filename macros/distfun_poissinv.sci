// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
//

function x = distfun_poissinv(varargin)
    //  Poisson Inverse CDF
    //
    // Calling Sequence
    //   x = distfun_poissinv(p,lambda)
    //   x = distfun_poissinv(p,lambda,lowertail)
    //
    // Parameters
    //   p : a 1x1 or nxm matrix of doubles, the probability .
    //   lambda : a 1x1 or nxm matrix of doubles,  the average rate of occurrence 
    //   lowertail : a 1x1 matrix of booleans, the tail (default lowertail=%t). If lowertail is true (the default), then considers P(X<=x) otherwise P(X>x).
    //   x : a nxm matrix of doubles, the outcome. x belongs to the set {0,1,2,3,......}
    //
    // Description
    //   Computes the Inverse cumulative distribution function of 
    //   the Poisson distribution function.
    //   
    //   Any scalar input argument is expanded to a matrix of doubles 
    //   of the same size as the other input arguments.
    //
    // Examples
    // // Test with p scalar, lambda scalar
    //x = distfun_poissinv(0.999,5)
    //expected = 13;
    //x = distfun_poissinv(1-0.999,5,%f)
    //expected = 13;
    //
    // // Test with expanded p , scalar lambda
    //x = distfun_poissinv([0.32 0.3],2)
    //expected = [1. 1.];
    //
    // // Test with scalar p, expanded lambda
    // x = distfun_poissinv(0.22,[3 2])
    // expected = [2. 1.];
    //
    //
    // // Test small values of p
    // x = distfun_poissinv(1.e-15,1)
    // expected = 0.;
    // x = distfun_poissinv(1.e-15,1,%f)
    // expected = 17.;
	//
    // Bibliography
    // http://en.wikipedia.org/wiki/Poisson_distribution
    //
    // Authors
    // Copyright (C) 2012 - Prateek Papriwal
    //
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_poissinv",rhs,2:3)
    apifun_checklhs("distfun_poissinv",lhs,0:1)

    p = varargin(1)
    lambda = varargin(2)
    lowertail = apifun_argindefault(varargin,3,%t)

    //
    // Check type
    apifun_checktype("distfun_poissinv",p,"p",1,"constant")
    apifun_checktype("distfun_poissinv",lambda,"lambda",2,"constant")
    apifun_checktype("distfun_poissinv",lowertail,"lowertail",3,"boolean")
	//
	// Check dimensions
    apifun_checkscalar("distfun_poissinv",lowertail,"lowertail",3)
    //
    // Check Content
    apifun_checkrange("distfun_poissinv",p,"p",1,0,1)
    apifun_checkgreq("distfun_poissinv",lambda,"lambda",2,1)
    
    [p,lambda] = apifun_expandvar(p,lambda)

    if (p==[]) then
        x=[]
        return
    end
    
    path = distfun_getpath()
    internallib = lib(fullfile(path,"macros","internals"))
    q = distfun_p2q(p)
    
    if (lowertail) then
        x = ceil(distfun_invcdfpoi(lambda,p,q))
    else
        x = ceil(distfun_invcdfpoi(lambda,q,p))
    end
endfunction