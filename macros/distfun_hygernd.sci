// Copyright (C) 2012 - prateek Papriwal
// Copyright (C) 2012 - Michael Baudin
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function R = distfun_hygernd(varargin)
    // Hypergeometric random numbers
    //
    // Calling Sequence
    //   R = distfun_hygernd(M,k,N)
    //   R = distfun_hygernd(M,k,N,v)
    //   R = distfun_hygernd(M,k,N,m,n)
    //
    // Parameters
    //   M : a 1x1 or nxm matrix of doubles, the total size of the population . M belongs to the set {0,1,2,3........}
    //   k : a 1x1 or nxm matrix of doubles, the number of successful states in the population . k belongs to the set {0,1,2,3.......M-1,M}
    //   N : a 1x1 or nxm matrix of doubles, the total number of draws in the experiment . N belongs to the set {0,1,2,3,.......M-1,M}
    //   v : a 1x2 or 2x1 matrix of doubles, the size of R
    //   v(1) : the number of rows of R
    //   v(2) : the number of columns of R
    //   m : a 1x1 matrix of floating point integers, the number of rows of R
    //   n : a 1x1 matrix of floating point integers, the number of columns of R
    //   R: a matrix of doubles, the random numbers in the set {0,1,2,...,min(N,k)}.
    //
    // Description
    //   Generates random variables from the Hypergeometric distribution function.
    //
    //   Any scalar input argument is expanded to a matrix of doubles 
    //   of the same size as the other input arguments.
    //
    //   As a side effect, it modifies the internal seed of the grand function.
    //
    // Examples
    // // Check R = distfun_hygernd(M,k,N,v)
    // computed = distfun_hygernd(80,50,30,[4 5])
    //
    // // Check mean and variance
    // M = 80;
    // k = 50;
    // N = 30;
    // n = 50000;
    // computed = distfun_hygernd(M,k,N,[1 n]);
    // c = mean(computed(1:n))
    // d = st_deviation(computed(1:n))
    // [M,V] = distfun_hygestat(M,k,N)
    //
    // Bibliography
    // http://en.wikipedia.org/wiki/Hypergeometric_distribution
    //
    // Authors
    // Copyright (C) 2012 - Prateek Papriwal
    // Copyright (C) 2012 - Michael Baudin

    path = distfun_getpath()
    internallib = lib(fullfile(path,"macros","internals"))

    [lhs,rhs] = argn()

    apifun_checkrhs("distfun_hygernd",rhs,3:5)
    apifun_checklhs("distfun_hygernd",lhs,0:1)

    M = varargin(1)
    k = varargin(2)
    N = varargin(3)
    //
    // Check type
    apifun_checktype ( "distfun_hygernd" , M , "M" , 1 , "constant" )
    apifun_checktype ( "distfun_hygernd" , k , "k" , 2 , "constant" )
    apifun_checktype ( "distfun_hygernd" , N , "N" , 3 , "constant" )
    //
    // Check content
    apifun_checkgreq("distfun_hygernd",M,"M",1,0)
    apifun_checkgreq("distfun_hygernd",k,"N",2,0)
    apifun_checkgreq("distfun_hygernd",N,"k",3,0)
	//
    apifun_checkflint("distfun_hygernd",M,"M",1)
    apifun_checkflint("distfun_hygernd",k,"k",2)
    apifun_checkflint("distfun_hygernd",N,"N",3)
	//
    if ( rhs == 4 ) then
        v = varargin(4)
    end
    if ( rhs == 5 ) then
        m = varargin(5)
        n = varargin(6)
    end
    //
    // Check v,m,n
    distfun_checkvmn ( "distfun_hygernd" , 4 , varargin(4:$) )
	//
	[M,k,N] = myexpandfromsize ( 3 , varargin(1:$) )
    if (M == []) then
        R = []
        return
    end
	//
    myloweq("distfun_hygernd",k,"k",2,M) // k<=M
    myloweq("distfun_hygernd",N,"N",3,M) // N<=M
	//
    m = size(M,"r")
    n = size(M,"c")
	u = distfun_unifrnd(0,1,m,n)
	R = distfun_hygeinv(u,M,k,N)
endfunction

function varargout = myexpandfromsize ( varargin )
  // Expand variables from a size.
  //
  // Calling Sequence
  //   [a,b,c] = apifun_expandfromsize ( 3 , a , b , c )
  //   [a,b,c] = apifun_expandfromsize ( 3 , a , b , c , v )
  //   [a,b,c] = apifun_expandfromsize ( 3 , a , b , c , m , n )

  [lhs,rhs]=argn()
  apifun_checkrhs ( "myexpandfromsize" , rhs , 4:6 )
  apifun_checklhs ( "myexpandfromsize" , lhs , 3 )
  //
  nbpar = varargin(1)
  //
  // Check npar
  apifun_checktype ( "myexpandfromsize" , nbpar , "nbpar" , 1 , "constant" )
  apifun_checkscalar ( "myexpandfromsize" , nbpar , "nbpar" , 1 )
  apifun_checkoption ( "myexpandfromsize" , nbpar , "nbpar" , 1 , 3 )
  //
  // Check number of arguments depending on nbpar
    [a,b,c] = dfxpndf_3var ( varargin(2:$) )
    varargout(1) = a
    varargout(2) = b
    varargout(3) = c
endfunction

function [a,b,c] = dfxpndf_3var ( varargin )
  // Expand 3 variables from their size
  //   [a,b,c] = dfxpndf_3var ( a , b , c )
  //   [a,b,c] = dfxpndf_3var ( a , b , c , v )
  //   [a,b,c] = dfxpndf_3var ( a , b , c , m , n )
  [lhs,rhs]=argn()
  select rhs
  case 3 then
    a = varargin(1)
    b = varargin(2)
    c = varargin(3)
    apifun_checktype ( "dfxpndf_3var" , a , "a" , 1 , "constant" )
    apifun_checktype ( "dfxpndf_3var" , b , "b" , 2 , "constant" )
    apifun_checktype ( "dfxpndf_3var" , c , "c" , 3 , "constant" )
    [ a , b , c ] = apifun_expandvar ( a , b , c )
  case 4 then
    a = varargin(1)
    b = varargin(2)
    c = varargin(3)
    v = varargin(4)
    apifun_checktype ( "dfxpndf_3var" , a , "a" , 1 , "constant" )
    apifun_checktype ( "dfxpndf_3var" , b , "b" , 2 , "constant" )
    apifun_checktype ( "dfxpndf_3var" , c , "c" , 3 , "constant" )
    apifun_checktype ( "dfxpndf_3var" , v , "v" , 4 , "constant" )
    m = v(1)
    n = v(2)
    if ( ( size(a,"*") == 1 ) & ( size(b,"*") == 1 ) & ( size(c,"*") == 1 ) ) then
      a = a * ones ( m , n )
      b = b * ones ( m , n )
      c = c * ones ( m , n )
    else
      if ( size(a,"*") <> 1 ) then
        apifun_checkdims ( "dfxpndf_3var" , a , "a" , 1 , [m n] )
      end
      if ( size(b,"*") <> 1 ) then
        apifun_checkdims ( "dfxpndf_3var" , b , "b" , 2 , [m n] )
      end
      if ( size(c,"*") <> 1 ) then
        apifun_checkdims ( "dfxpndf_3var" , c , "c" , 3 , [m n] )
      end
      [ a , b , c ] = apifun_expandvar ( a , b , c )
    end
  case 5 then
    a = varargin(1)
    b = varargin(2)
    c = varargin(3)
    m = varargin(4)
    n = varargin(5)
    apifun_checktype ( "dfxpndf_3var" , a , "a" , 1 , "constant" )
    apifun_checktype ( "dfxpndf_3var" , b , "b" , 2 , "constant" )
    apifun_checktype ( "dfxpndf_3var" , c , "c" , 3 , "constant" )
    apifun_checktype ( "dfxpndf_3var" , m , "m" , 4 , "constant" )
    apifun_checktype ( "dfxpndf_3var" , n , "n" , 5 , "constant" )
    if ( ( size(a,"*") == 1 ) & ( size(b,"*") == 1 ) & ( size(c,"*") == 1 ) ) then
      a = a * ones ( m , n )
      b = b * ones ( m , n )
      c = c * ones ( m , n )
    else
      if ( size(a,"*") <> 1 ) then
        apifun_checkdims ( "dfxpndf_3var" , a , "a" , 1 , [m n] )
      end
      if ( size(b,"*") <> 1 ) then
        apifun_checkdims ( "dfxpndf_3var" , b , "b" , 2 , [m n] )
      end
      if ( size(c,"*") <> 1 ) then
        apifun_checkdims ( "dfxpndf_3var" , c , "c" , 3 , [m n] )
      end
      [ a , b , c ] = apifun_expandvar ( a , b , c )
    end
  else
    errmsg = msprintf(gettext("%s: Internal error: unexpected rhs = %d."), "dfxpndf_3var" , rhs )
    error(errmsg)
  end
endfunction

function myloweq( funname , var , varname , ivar , thr )
    // Workaround for bug http://forge.scilab.org/index.php/p/apifun/issues/867/
    // Caution:
    // This function assumes that var and thr are matrices with
    // same size.
    // Expand the arguments before calling it.
    if ( or ( var > thr ) ) then
        k = find ( var > thr ,1)
        errmsg = msprintf(gettext("%s: Wrong input argument %s at input #%d. Entry %s(%d) is equal to %s but should be lower than %s."),funname,varname,ivar,varname,k,string(var(k)),string(thr(k)));
        error(errmsg);
    end
endfunction
