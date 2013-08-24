// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function y = distfun_tpdf(varargin)
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_tpdf",rhs,2)
    apifun_checklhs("distfun_tpdf",lhs,0:1)
    
    x=varargin(1)
    v=varargin(2)
    //
    // Check type
    apifun_checktype("distfun_tpdf",x,"x",1,"constant")
    apifun_checktype("distfun_tpdf",v,"v",2,"constant")
    //
    // Check content
    apifun_checkgreq("distfun_tpdf",v,"v",2,1)
    apifun_checkflint("distfun_tpdf",v,"v",2)
    
    tmp = 1 ./ 2
    
    [x,v,tmp] = apifun_expandvar(x,v,tmp)
    
    if (x == []) then
        y = []
        return
    end
    
    y = (exp(-(v+1) .* log(1+x .^ 2 ./ v ) ./ 2) ./ (sqrt (v) .* beta(v ./ 2 , tmp)))
    
endfunction