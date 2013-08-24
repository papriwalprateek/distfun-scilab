// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function x = distfun_tinv(varargin)
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_tinv",rhs,2:3)
    apifun_checklhs("distfun_tinv",lhs,0:1)
    
    p = varargin(1)
    v = varargin(2)
    lowertail = apifun_argindefault(varargin,3,%t)
    //
    // Check type
    apifun_checktype("distfun_tinv",p,"p",1,"constant")
    apifun_checktype("distfun_tinv",v,"v",2,"constant")
    apifun_checktype("distfun_tinv",lowertail,"lowertail",3,"boolean")
    
    apifun_checkscalar("distfun_tinv",lowertail,"lowertail",3)
    //
    // Check content
    apifun_checkgreq("distfun_tinv",v,"v",2,1)
    
    apifun_checkflint("distfun_tinv",v,"v",2)
    
    [p,v] = apifun_expandvar(p,v)
    
    if (p == []) then
        x = []
        return
    end
    
    path = distfun_getpath()
    internallib = lib(fullfile(path,"macros","internals"))
    q = distfun_p2q(p)
    
    
    if (lowertail) then
        x = distfun_invcdft(v,p,q)
    else
        x = distfun_invcdft(v,q,p)
    end
endfunction