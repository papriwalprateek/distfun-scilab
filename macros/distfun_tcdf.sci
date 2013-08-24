// Copyright (C) 2012 - Prateek Papriwal
// Copyright (C) 2012 - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function p = distfun_tcdf(varargin)
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_tcdf",rhs,2:3)
    apifun_checklhs("distfun_tcdf",lhs,0:1)
    
    x = varargin(1)
    v = varargin(2)
    lowertail = apifun_argindefault(varargin,3,%t)
    //
    // Check type
    apifun_checktype("distfun_tcdf",x,"x",1,"constant")
    apifun_checktype("distfun_tcdf",v,"v",2,"constant")
    apifun_checktype("distfun_tcdf",lowertail,"lowertail",3,"boolean")
    
    apifun_checkscalar("distfun_tcdf",lowertail,"lowertail",3)
    //
    // Check content
    apifun_checkgreq("distfun_tcdf",v,"v",2,1)
    
    apifun_checkflint("distfun_tcdf",v,"v",2)
    
    [x,v] = apifun_expandvar(x,v)
    
    if (x == []) then
        p = []
        return
    end
    
    if (lowertail) then
        p = distfun_cdft(x,v)
    else
        [ignored,p] = distfun_cdft(x,v)
    end
    
endfunction