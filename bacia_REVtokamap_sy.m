function [t_escape,xescape] =bacia_REVtokamap_sy(A,N_traj,N)
% 
% Produz o tempo de escape do Tokamap backward(da parede em psi=1)
% Fornecer: A = [ K w ]
%           N_traj = Numero de trajetorias 
%           N = Numero de iteracoes para cada condicao inicial

% (c) A. B. Schelin (Maio, 2010).

if (nargin<3), N_traj=30; end
if (nargin<2), N=5e02; end

t_escape(N_traj,N_traj) = 0;
xescape(N_traj,N_traj) = 0;
x01 = linspace(0,1,N_traj);
x02 = linspace(0,2*pi,N_traj);


for i = 1 : N_traj
i
    X0(1)=x01(i);
    
    for j = 1: N_traj
    
    X0(2)=x02(j); 
    
    [X] = traj_revtokamap_sy( A, N, X0);
    
    [a,te]=max(sign(1-X(:,1))==-1);
   
    if (te(1)==1),
        
        t_escape(i,j) = 1000;
        
        xescape(i,j) = -10;
        
    else
        t_escape(i,j) = te(1);
   
        xescape(i,j) = mod((X(te(1),2)-X(te(1)-1,2))./2,2*pi); 
       
    end
        
                       
    end
    
end
