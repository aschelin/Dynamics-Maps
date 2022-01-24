function [tempo,n_p,n_c]=blob_flow_abcv2

params= [5 0.8 20/pi];

tau=10;tmax = 5000;

Nx=100;nx = Nx/10;
Ny=100;ny = Ny/10;

blob=zeros(Nx+1,Ny+1);

X0new = zeros(Nx*Ny+nx*ny,5);
tempo = zeros(tmax/tau,1);
n_p = zeros(tmax/tau,1);
n_c = zeros(tmax/tau,1);


xmin = 0.;xmax = 1;
ymin = 0.;ymax = 1;

xini=linspace(xmin,xmax,Nx);
yini=linspace(ymin,ymax,Ny);
sini = ones(1,Nx);
sini(1,ceil(Nx/2)+1:end) = sini(1,ceil(Nx/2)+1:end)+1;

Fnew0 = zeros(Nx*Ny,5);

j = 1;

for i = 1:Ny
    Fnew0((j-1)*Nx+(1:Nx),2) = xini(i);
    Fnew0((j-1)*Nx+(1:Nx),4) = yini(1:Nx);
    Fnew0((j-1)*Nx+(1:Nx),5) = sini(i);

    j = j+1;
end

X0new = Fnew0;

k = 1;Nc = 0;

for i=1:Nx*Ny


    X0 = X0new(i,1:4);

    [Y,T] = trajetoria_flow(params,tau,X0);

    [a1,a2] = acha2(mod(Y(end,2),1),mod(Y(end,4),1),1/Nx,1/Ny,[0 1],[0 1]);

    s= X0new(i,5);

    blob(a1,a2)=( blob(a1,a2)~=s)*(blob(a1,a2)+s)*(blob(a1,a2)>0)+(blob(a1,a2)==0)*s+(s==blob(a1,a2))*s;

    value = blob(a1,a2);

    X0new(k,1:4) = Y(end,:);
    X0new(k,5) = s;
    k = k+1*(value<3);


    Nc = Nc+1*(value>2);





end

xmin = 0.;xmax = .1;
ymin = 0.;ymax = .1;
xini=linspace(xmin,xmax,nx);
yini=linspace(ymin,ymax,ny);
sini = ones(1,nx);
sini(1,ceil(nx/2)+1:end) = sini(1,ceil(nx/2)+1:end)+1;

tempo(1) = tau; Fnew1 = zeros(nx*ny,5);
j =1;


for i = 1:ny
    Fnew1((j-1)*nx+(1:nx),2) = xini(i);
    Fnew1((j-1)*nx+(1:nx),4) = xini(1:nx);
    Fnew1((j-1)*nx+(1:nx),5) = sini(i);
    j = j+1;
end

X0new(k+1:k+(nx*ny),:) = Fnew1(:,:);

n_p(1) = k+nx*ny; np=n_p(1);n_c(1) = Nc;

nt=1; t = tau;

while (t<tmax)

    nt = nt+1;

    t = nt* tau;
    t

    k = 1;blob = zeros(Nx+1,Ny+1); X0new1=zeros(Nx*Ny,4);Nc = 0;

    for jj = 1:np

        X0 = X0new(jj,1:4);

        [Y,T] = trajetoria_flow(params,tau,X0);

        [a1,a2] = acha2(mod(Y(end,2),1),mod(Y(end,4),1),1/Nx,1/Ny,[0 1],[0 1]);

        s= X0new(jj,5);
        blob(a1,a2)=( blob(a1,a2)~=s)*(blob(a1,a2)+s)*(blob(a1,a2)>0)+(blob(a1,a2)==0)*s+(s==blob(a1,a2))*s;

        blob(a1,a2)=blob(a1,a2)+1;

        value = blob(a1,a2);

        X0new1(k,1:4) = Y(end,:);
        X0new1(k,5) = s;

        k = k+1*(value<3);

        Nc = Nc+1*(value>2);

    end



    tempo(nt) = t;

    n_p(nt) =  k+nx*ny; np=n_p(nt);

    n_c(nt) = Nc;

    X0new(1:k,:)=X0new1(1:k,:);

    X0new(k+1:k+(nx*ny),:) = Fnew1(:,:);
end
