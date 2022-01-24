function [basin] = basin_sinemap( A, N, Ns)

if nargin<3, Ns=400;end
if nargin<2, N=6; end    

xmin = 0;xmax = 1;
ymin = 0;ymax = 1;

xini=linspace(xmin,xmax,Ns);
yini=linspace(ymin,ymax,Ns);

basin=zeros(Ns,Ns);

n=0;

for i=1:Ns
    
    x= xini(i);
    
    for j=1:Ns
        
     y=yini(j);
     
     [state] = act_sinemap( A, N, [x y]);
   
     basin(i,j)=state;
         
    end
    
end
        