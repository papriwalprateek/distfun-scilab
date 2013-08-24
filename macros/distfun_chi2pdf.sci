// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function y = distfun_chi2pdf(varargin)
    // Chi-square PDF
    //
    // Calling Sequence
    //   y = distfun_chi2pdf(x,k)
    //   
    // Parameters
    //   x : a 1x1 or nxm matrix of doubles, the outcome, greater or equal to zero
    //   k : a 1x1 or nxm matrix of doubles, the number of degrees of freedom. k belongs to the set {1,2,3.......} 
    //   y : a nxm matrix of doubles, the probability density.
    //
    // Description
    //   Computes the probability distribution function of 
    //   the Chi-square distribution function.
    //   
    //   Any scalar input argument is expanded to a matrix of doubles 
    //   of the same size as the other input arguments.
    //
    // Examples
    // // Test with x scalar, k scalar
    // computed = distfun_chi2pdf(4,5)
    // expected = 0.1439759
    //
    // // Test with expanded x, k scalar
    // computed = distfun_chi2pdf([2 6],5)
    // expected = [0.1383692 0.0973043]
    //
    // // Test with x scalar, k expanded
    // computed = distfun_chi2pdf(4,[4 7])
    // expected = [0.1353353 0.1151807]
    // 
    // // Test with both x,k expanded
    // computed = distfun_chi2pdf([2 6],[3 4])
    // expected = [0.2075537 0.0746806]
    //
    // // Plot the function
    // h=scf();
    // k = [2 3 4 6 9 12];
    // cols = [1 2 3 4 5 6];
    // lgd = [];
    // for i = 1:size(k,"c")
    //   x = linspace(0,10,1000);
    //   y = distfun_chi2pdf ( x , k(i) );
    //   plot(x,y)
    //   str = msprintf("k=%s",string(k(i)));
    //   lgd($+1) = str;
    // end
    // for i = 1:size(k,"c")
    //     hcc = h.children.children;
    //     hcc.children(size(k,"c") - i + 1).foreground = cols(i);
    // end
    // xtitle("Chi-square PDF","x","f(x)")
    // legend(lgd);
    // 
    // Bibliography
    // http://en.wikipedia.org/wiki/Chi-squared_distribution
    //
    // Authors
    // Copyright (C) 2012 - Prateek Papriwal

    
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_chi2pdf",rhs,2)
    apifun_checklhs("distfun_chi2pdf",lhs,0:1)
    
    x=varargin(1)
    k=varargin(2)
    //
    // Check type
    apifun_checktype("distfun_chi2pdf",x,"x",1,"constant")
    apifun_checktype("distfun_chi2pdf",k,"k",2,"constant")
    //
    // Check content
    apifun_checkgreq("distfun_chi2pdf",x,"x",1,0)
    apifun_checkgreq("distfun_chi2pdf",k,"k",2,1)
    
    [x,k] = apifun_expandvar(x,k)
    
    y = distfun_gampdf(x,k ./ 2,2)
    
endfunction
