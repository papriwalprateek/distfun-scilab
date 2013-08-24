// Copyright (C) 2012 - Prateek Papriwal
// Copyright (C) 2012 - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function R = distfun_frnd(varargin)
    path = distfun_getpath()
    internallib = lib(fullfile(path,"macros","internals"))

    [lhs,rhs] = argn()

    apifun_checkrhs("distfun_frnd",rhs,2:4)
    apifun_checklhs("distfun_frnd",lhs,0:1)
    
    v1 = varargin(1)
    v2=varargin(2)
    
    //
    // Check type
    apifun_checktype("distfun_frnd",v1,"v1",1,"constant")
    apifun_checktype("distfun_frnd",v2,"v2",2,"constant")
    
    // Check content 
    tiniest=number_properties("tiniest")
    apifun_checkgreq("distfun_frnd",v1,"v1",1,tiniest)
    apifun_checkgreq("distfun_frnd",v2,"v2",2,tiniest)
    
    if ( rhs == 3 ) then
        v = varargin(3)
    end
    if ( rhs == 4 ) then
        m = varargin(3)
        n = varargin(4)
    end
    //
    // Check v,m,n
    distfun_checkvmn ( "distfun_frnd" , 3 , varargin(3:$) )
    
    [v1,v2] = apifun_expandfromsize ( 2 , varargin(1:$) )

    if(v1 == []) then
        R = []
        return
    end

    m = size(v1,"r")
    n = size(v2,"c")

    R = distfun_grandf(m,n,v1,v2)

endfunction