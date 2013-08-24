// Copyright (C) 2012 - Prateek Papriwal
// Copyright (C) 2012 - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function p = distfun_fcdf(varargin)
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_fcdf",rhs,3:4)
    apifun_checklhs("distfun_fcdf",lhs,0:1)
    
    x = varargin(1)
    v1 = varargin(2)
    v2=varargin(3)
    lowertail = apifun_argindefault(varargin,4,%t)
    //
    // Check type
    apifun_checktype("distfun_fcdf",x,"x",1,"constant")
    apifun_checktype("distfun_fcdf",v1,"v1",2,"constant")
    apifun_checktype("distfun_fcdf",v2,"v2",3,"constant")
    apifun_checktype("distfun_fcdf",lowertail,"lowertail",4,"boolean")
    
    apifun_checkscalar("distfun_fcdf",lowertail,"lowertail",4)
    //
    // Check content
    apifun_checkgreq("distfun_fcdf",x,"x",1,0)
    tiniest=number_properties("tiniest")
    apifun_checkgreq("distfun_fcdf",v1,"v1",2,tiniest)
    apifun_checkgreq("distfun_fcdf",v2,"v2",3,tiniest)
    
    [x,v1,v2] = apifun_expandvar(x,v1,v2)
    
    if (x == []) then
        p = []
        return
    end
    
    if (lowertail) then
        p = distfun_cdff(x,v1,v2)
    else
        [ignored,p] = distfun_cdff(x,v1,v2)
    end
    
endfunction