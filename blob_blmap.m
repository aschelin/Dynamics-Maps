function [X_tracer] = blob_blmap( A, N, delta,Nlim)

if nargin<4, Nlim=[100 100];end
if nargin<3, delta=1e-6;end
if nargin<2, N=6; end    

Nx=Nlim(1);Ny=Nlim(2);

xcentro = 0;ycentro=0;

xmin = xcentro-delta;xmax = xcentro+delta;
ymin = ycentro-delta;ymax = ycentro+delta;

xini=linspace(xmin,xmax,Nx);
yini=linspace(ymin,ymax,Ny);



X_tracer=zeros(Nx*Ny,4);

n=0;

for ii=1:Nx
    
    x= xini(ii);
    
    for j=1:Ny
        
     y=yini(j);
     
     [Z,escape] = blinkingmapv2( A, N, [x y]);

         n=n+1;
        ultimo = find((abs(Z)>0)==1); T_fim = length(ultimo);
        X_tracer(n,1)=real(Z(end));
        X_tracer(n,2)=imag(Z(end));
        X_tracer(n,3) = x + i*y; 
        X_tracer(n,4) = escape;
         
    end
    
end
        