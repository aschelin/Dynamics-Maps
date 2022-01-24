function sigma = ftle_magbilliard(A,X0,N)

delta = 1e-6;

X01 = [X0(1)+delta X0(2)];
X02 = [X0(1)-delta X0(2)];
X03 = [X0(1) X0(2)+delta];
X04 = [X0(1) X0(2)-delta];

[X1] = mbilliard_map( A, N, X01)
[X2] = mbilliard_map( A, N, X02)
[X3] = mbilliard_map( A, N, X03)
[X4] = mbilliard_map( A, N, X0)


A1 = abs(X1(end,1)-X2(end,1))./(X01(1)-X02(1));
A2 = abs(X3(end,1)-X4(end,1))./(X03(2)-X04(2));
A3 = abs(X1(end,2)-X2(end,2))./(X01(1)-X02(1));
A4 = abs(X3(end,2)-X4(end,2))./(X03(2)-X04(2));

Atot = [A1 A2;A3 A4];

sigma = real(1/N*log(sqrt(max(eig(Atot)))));