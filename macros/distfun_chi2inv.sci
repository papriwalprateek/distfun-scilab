// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
//

function x = distfun_chi2inv(varargin)
    // Chi-square Inverse CDF
    //
    // Calling Sequence
    //   x = distfun_chi2cdf(p,k)
    //   x = distfun_chi2cdf(p,k,lowertail)
    //   
    // Parameters
    //   p : a nxm matrix of doubles, the probability.
    //   k : a 1x1 or nxm matrix of doubles, the number of degrees of freedom. k belongs to the set {1,2,3.......} 
    //   lowertail : a 1x1 matrix of booleans, the tail (default lowertail=%t). If lowertail is true (the default), then considers P(X<=x) otherwise P(X>x).
    //   x : a nxm matrix of doubles, the outcome. x belongs to the set {0,1,2,3,......}
    //
    // Description
    //   Computes the Inverse cumulative distribution function of 
    //   the Chi-square distribution function.
    //   
    //   Any scalar input argument is expanded to a matrix of doubles 
    //   of the same size as the other input arguments.
    //
    // Examples
    // // Test with p scalar, k scalar
    // computed = distfun_chi2inv(0.4,5)
    // expected = 3.6554996
    //
    // // Test with expanded p, k scalar
    // computed = distfun_chi2inv([0.2 0.6],5)
    // expected = [2.3425343 5.1318671]
    //
    // // Test with p scalar, k expanded
    // computed = distfun_chi2inv(0.44,[4 7])
    // expected = [2.9870195 5.827751]
    // 
    // // Test with both p,k expanded
    // computed = distfun_chi2inv([0.22 0.66],[3 4])
    // expected = [1.0878828 4.5215487]
    //
    // // Test small values of p
    // x = distfun_chi2inv(1.e-15,6)
    // expected = 0.0000363
    // x = distfun_chi2inv(1.e-15,6,%f)
    // expected = 82.67507
    //
    // Bibliography
    // http://en.wikipedia.org/wiki/Chi-squared_distribution
    //
    // Authors
    // Copyright (C) 2012 - Prateek Papriwal
    
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_chi2inv",rhs,2:3)
    apifun_checklhs("distfun_chi2inv",lhs,0:1)

    p = varargin(1)
    k = varargin(2)
    lowertail = apifun_argindefault(varargin,3,%t)

    //
    // Check type
    apifun_checktype("distfun_chi2inv",p,"p",1,"constant")
    apifun_checktype("distfun_chi2inv",k,"k",2,"constant")
    apifun_checktype("distfun_chi2inv",lowertail,"lowertail",3,"boolean")

    apifun_checkscalar("distfun_chi2inv",lowertail,"lowertail",3)
    //
    // Check Content
    apifun_checkrange("distfun_chi2inv",p,"p",1,0,1)
    apifun_checkgreq("distfun_chi2inv",k,"k",2,1)
    
    [p,k] = apifun_expandvar(p,k)

    if (p==[]) then
        x=[]
        return
    end
    
    path = distfun_getpath()
    internallib = lib(fullfile(path,"macros","internals"))
    q = distfun_p2q(p)
    
    if (lowertail) then
        x = distfun_invcdfchi(k,p,q)
    else
        x = distfun_invcdfchi(k,q,p)
    end
    
endfunction