function [media_X1,media_X2,T] = xmt_wobig(N_T,N_traj)
% [media_X1,a] = current_tokamap(N_p,N_traj,N)
% Produz a corrente de X1 do Tokamap
% Fornecer: N_p = Numero de parametros
%           N_traj = Numero de trajetorias 
%           N = Numero de iteracoes para cada condicao inicial

% (c) A. B. Schelin (Outubro, 2008).

if (nargin<2), N_traj=1e03; end
if (nargin<1), N_T=10; end

X_final(N_traj,1) = 0;X_ini(N_traj,1) = 0; 

T = logspace(0,2,N_T); media_X1(N_T,1) = 0; A(1) = .5;

media_X2(N_T,1) = 0;

x01inf=.22;x01sup=.25;

for j = 1 : N_T
    j
    
        N=ceil(T(j));
    for i = 1 : N_traj

        X0(1)=10;
        X0(2)=rand(1);
%        X0(2)=x01inf+x01sup*rand(1);
        
        
        [X] = wobig( A, N, X0);

        
        
        X_ini(i,1) = X(	1,1);
        X_final(i,1) = (X(end,1));

    end

    media_X1(j) = mean(X_final);
    media_X2(j) = mean(sqrt(X_final));
   % -mean(X_ini));

end