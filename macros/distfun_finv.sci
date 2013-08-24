// Copyright (C) 2012 - Prateek Papriwal
// Copyright (C) 2012 - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
//

function x = distfun_finv(varargin)
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_finv",rhs,3:4)
    apifun_checklhs("distfun_finv",lhs,0:1)
    
    p = varargin(1)
    v1 = varargin(2)
    v2=varargin(3)
    lowertail = apifun_argindefault(varargin,4,%t)
    //
    // Check type
    apifun_checktype("distfun_finv",p,"p",1,"constant")
    apifun_checktype("distfun_finv",v1,"v1",2,"constant")
    apifun_checktype("distfun_finv",v2,"v2",3,"constant")
    apifun_checktype("distfun_finv",lowertail,"lowertail",4,"boolean")
    
    apifun_checkscalar("distfun_finv",lowertail,"lowertail",4)
    //
    // Check content
    apifun_checkgreq("distfun_finv",p,"p",1,0)
    tiniest=number_properties("tiniest")
    apifun_checkgreq("distfun_finv",v1,"v1",2,tiniest)
    apifun_checkgreq("distfun_finv",v2,"v2",3,tiniest)
    
    [p,v1,v2] = apifun_expandvar(p,v1,v2)
    
    if (p == []) then
        x = []
        return
    end
    
    path = distfun_getpath()
    internallib = lib(fullfile(path,"macros","internals"))
    q = distfun_p2q(p)
    
    if (lowertail) then
        x = distfun_invcdff(v1,v2,p,q)
    else
        x = distfun_invcdff(v1,v2,q,p)
    end
endfunction