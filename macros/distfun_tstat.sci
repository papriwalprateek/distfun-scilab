// Copyright (C) 2012 - Prateek Papriwal
// Copyright (C) 2012 - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function [M,V]  = distfun_tstat(varargin)
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_tstat",rhs,1)
    apifun_checklhs("distfun_tstat",lhs,1:2)
    
    v = varargin(1)
    
    //
    // Check type
    apifun_checktype("distfun_tstat",v,"v",1,"constant")
    
    // Check content 
    
    apifun_checkgreq("distfun_tstat",v,"v",1,1)
    
    apifun_checkflint("distfun_tstat",v,"v",1)
    
    [v] = apifun_expandvar(v)
    
    M=ones(v)*%nan
    i=find(v>1)
    Z=zeros(V)
    M(i)=Z(i)
    
    V=ones(v)*%nan
    i=find( v > 1 & v<=2 )
    I=ones(v)*%inf
    V(i)=I(i)
    i=find( v > 2 )
    V(i) = v(i) ./ (v(i)-2)
    
endfunction