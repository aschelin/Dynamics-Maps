function [state,X] = act_sinemap( A, N, X0)

% valores padroes para os parametros

time_step=1;

K=A(1); L=A(2);

delta=.2;
Vmax=K-delta;Vmin=0+delta;


X( N, 2 ) = 0;

X(1,1) = X0(1,1);
X(1,2) = X0(1,2);

V_atv=-1;V_dep=-1;state=-2;

for n = 1 : N-1
  
    
%    X(n+1,1) = X(n,1)-mod(K*sin(2*pi*X(n,2)+L),1)*time_step;
    
 %   X(n+1,2) = X(n,2)-mod(K*sin(2*pi*X(n+1,1)+L),1)*time_step;

    
    X(n+1,1) = X(n,1)-sin(n).*mod(K*sin(2*pi*X(n,2)+L),1);
    
    X(n+1,2) = X(n,2)-mod(K*sin(2*pi*X(n+1,1)+L),1);

    V_y=abs(K.*sin(L+2*pi*(X(n+1,1)+K*sin(2*pi*X(n+1,2)+L))));
    
    if (V_dep==-1),
        if (V_atv==-1),
            V_atv=sign(V_y./Vmax-1);
            else
            V_dep= sign(Vmin./V_y-1);

        end
       state=V_atv+V_dep;
        
    end
    
end

