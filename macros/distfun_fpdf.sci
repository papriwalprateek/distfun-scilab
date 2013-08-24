// Copyright (C) 2012 - Prateek Papriwal
// Copyright (C) 2012 - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function y = distfun_fpdf(varargin)
    // Examples
    // distfun_fpdf(3,4,5) // 0.06817955
    // distfun_fpdf(3,2.5,1.5) // 0.0623281
    // distfun_fpdf(1.e2,1.e10,1.e-10) // 5.000D-13
    // distfun_fpdf(1.e2,1.e200,1.e-200) // 5e-203: TODO : fix this!
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_fpdf",rhs,3)
    apifun_checklhs("distfun_fpdf",lhs,0:1)
    
    x = varargin(1)
    v1 = varargin(2)
    v2=varargin(3)
    //
    // Check type
    apifun_checktype("distfun_fpdf",x,"x",1,"constant")
    apifun_checktype("distfun_fpdf",v1,"v1",2,"constant")
    apifun_checktype("distfun_fpdf",v2,"v2",3,"constant")
    //
    // Check content
    apifun_checkgreq("distfun_fpdf",x,"x",1,0)
    tiniest=number_properties("tiniest")
    apifun_checkgreq("distfun_fpdf",v1,"v1",2,tiniest)
    apifun_checkgreq("distfun_fpdf",v2,"v2",3,tiniest)
    
    [x,v1,v2] = apifun_expandvar(x,v1,v2)
    
    if (x == []) then
        y = []
        return
    end
    
    halfv1=v1./2
    v = log(v1) - log(v2)
    r=v1./v2
    tmp=r.*x
    ynumerator=exp((halfv1-1).*log(tmp)-((v1+v2)./2).*log(1+tmp) + v)
    ydenominator=beta(halfv1,v2./2)
    y=ynumerator./ydenominator
endfunction