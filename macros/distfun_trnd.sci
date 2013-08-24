// Copyright (C) 2012 - Prateek Papriwal
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function R = distfun_trnd(varargin)
    path = distfun_getpath()
    internallib = lib(fullfile(path,"macros","internals"))

    [lhs,rhs] = argn()

    apifun_checkrhs("distfun_trnd",rhs,1:3)
    apifun_checklhs("distfun_trnd",lhs,0:1)
    
    v = varargin(1)
        
    //
    // Check type
    apifun_checktype("distfun_trnd",v,"v",1,"constant")
    
    // Check content 
    
    apifun_checkgreq("distfun_trnd",v,"v",1,1)
    
    apifun_checkflint("distfun_trnd",v,"v",1)
    
    
    if ( rhs == 2 ) then
        v = varargin(2)
    end
    if ( rhs == 3 ) then
        m = varargin(2)
        n = varargin(3)
    end
    //
    // Check v,m,n
    distfun_checkvmn ( "distfun_trnd" , 2 , varargin(2:$) )
    
    [v] = apifun_expandfromsize ( 1 , varargin(1:$) )
    
    if(v == []) then
        R = []
        return
    end

    m = size(v,"r")
    n = size(v,"c")
    
    u = distfun_unifrnd(0,1,m,n)
    R = distfun_tinv(u,v)
    
endfunction