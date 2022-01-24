function [IND1,IND2] = acha2(x,y,deltat,deltap,vt,vphi)
% [IND,COORDENADAS] = acha2(x,y,DX,DY,X,Y)
% x,y -> COORDENADAS DADAS
% DX - DELTA X, DY - DELTA Y.
% X,Y VETORES DA MALHA.

%(c) A.B.Schelin, Janeiro 2008. 

if (nargin<6), vphi = []; end
if isempty(vphi), vphi = [0,pi]; end

if (nargin<5), vt = []; end
if isempty(vt), vt = [0,2*pi]; end

if (nargin<4), deltap = []; end
if isempty(deltap), deltap = 1E-02; end

if (nargin<3), deltat = []; end
if isempty(deltat), deltat = 1E-02; end

    IND= zeros(1,2);

    THETA = [vt(1,1):deltat:vt(1,2)];
    
    PHI = [vphi(1,1):deltap:vphi(1,2)];
    
    t = arredonda(x,deltat); 
    p = arredonda(y,deltap);

    IND1 = find(THETA == t);
    IND2 = find(PHI == p);
    
    if isempty(IND1), IND1 =1; end 
    if isempty(IND2), IND2 =1; end
    
    ANGULO = [THETA(IND1),PHI(IND2)];