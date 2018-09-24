clear
load cow3D.mat

x = dsites(:,1);
y = dsites(:,2);
z = dsites(:,3);

[rows,cols] = size(x);
kk=1; f=kk*ones(rows,1);  %Dirichlet boundary condition
DM1 = DistanceMatrix([x(:) y(:) z(:)], [x(:) y(:) z(:)]);  
% MFS2 = (DM1./(8*pi));
lam =0.9;
%MFS2 = exp(-(lam.*DM1))/(4*pi*DM1);
MFS2 = - (exp(-(lam.*DM1)))./(8*pi*lam);
coe = MFS2\f;
b = max(x(:))+.1; a = min(x(:))-.1; c = min(y(:))-.1; d = max(y(:) )+.1; e = max(z(:))+.1; f = min(z(:))-.1;
L=49; %meshgrid in each axis direction
h = a:(b-a)/L:b; k = c:(d-c)/L:d; l = f:(e-f)/L:e;

[X, Y, Z] = meshgrid(h,k,l);   
P=[X(:) Y(:) Z(:)];
Q=[x(:) y(:) z(:)];
u=zeros(size(P,1),1);

for i = 1:size(P,1)/500
    starts = 500*(i-1)+1;
    ends = 500*i;    
    DM2 = DistanceMatrix(P(starts:ends,:),Q); 
    %u(starts:ends,1) = DM2/(8*pi)*coe(:,1); 
    temp = -(exp(-(lam.*DM2))./(8*pi*lam));
    u(starts:ends,1) = temp *coe(:,1);
    u(DM2==0)=0;
end
u = reshape(u,L+1,L+1,L+1);
figure;
isosurface(X,Y,Z,u,1);