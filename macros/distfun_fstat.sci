// Copyright (C) 2012 - Prateek Papriwal
// Copyright (C) 2012 - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function [M,V]  = distfun_fstat(varargin)
    [lhs,rhs] = argn()
    apifun_checkrhs("distfun_fstat",rhs,2)
    apifun_checklhs("distfun_fstat",lhs,1:2)
    
    v1 = varargin(1)
    v2 = varargin(2)
    
    //
    // Check type
    apifun_checktype("distfun_fstat",v1,"v1",1,"constant")
    apifun_checktype("distfun_fstat",v2,"v2",2,"constant")
    
    // Check content 
    tiniest=number_properties("tiniest")
    apifun_checkgreq("distfun_fstat",v1,"v1",1,tiniest)
    apifun_checkgreq("distfun_fstat",v2,"v2",2,tiniest)
    
    [v1,v2] = apifun_expandvar(v1,v2)
    
    M=ones(v1)*%nan
    i=find(v2>2)
    M(i)=v2(i)./(v2(i)-2)
    
    V=ones(v1)*%nan
    i=find(v2>4)
    V(i)=(2.*v2(i).^2.*(v1(i)+v2(i)-2))./(v1(i).*(v2(i)-2).^2.*(v2(i)-4))
endfunction