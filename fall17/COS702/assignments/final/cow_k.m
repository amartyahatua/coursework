clear
load cow3D.mat
L=20;

x = dsites(:,1);
y = dsites(:,2);
z = dsites(:,3);
[rows,cols] = size(x);
b = max(x)+.1;
a = min(x)-.1;
c = min(y)-.1;
d = max(y)+.1;
e = max(z)+.1;
f = min(z)-.1;
volumeCube = (b-a)*(d-c)*(e-f);
h = a:(b-a)/L:b;
k = c:(d-c)/L:d;
l = f:(e-f)/L:e;

[X, Y, Z] = meshgrid(h,k,l);

P=[X(:) Y(:) Z(:)];
Q=[x(:) y(:) z(:)];
u=zeros(size(P,1),1);

[rows,cols] = size(x);
kk=1; f=kk*ones(rows,1);  %Dirichlet boundary condition
DM1 = DistanceMatrix([x(:) y(:) z(:)], [x(:) y(:) z(:)]);
%MFS2 = (DM1./(8*pi));
lam =0.85;
MFS2 = - (exp(-(lam.*DM1)))./(8*pi*lam);

coe = MFS2\f;

for i = 1:size(P,1)/500
    starts = 500*(i-1)+1;
    ends = 500*i;
    DM2 = DistanceMatrix(P(starts:ends,:),Q);
    temp = -(exp(-(lam.*DM2))./(8*pi*lam));
    u(starts:ends,1) = temp *coe(:,1);
    u(DM2==0)=0;
end
u = (u<1);
X = X(:); Y = Y(:); Z = Z(:);
x1=X(u); y1=Y(u); z1=Z(u);%interior points
xx=[x1;x]; yy=[y1;y]; zz=[z1;z]; %interior + boundar points

ctrs=[xx yy zz];         %center of RBF
DM1=DistanceMatrix([x1 y1 z1], ctrs);  %Distance matrix of interior points
DM2=DistanceMatrix([x y z], ctrs);    %Distance matrix of boundary points
k1 = 1;  f = k1*ones(length(x1),1);  %forcing term
k2 =1;  g = k2*ones(rows,1); %boundary condition
rhs=[f;g];
lam_p = 210.004;

pde =@ (r,c,lam_p)  (2*r.^2+3*c^2)./(r.^2+c^2).^(3/2)-lam_p*sqrt(1+r.^2*c*c);
rbf=@(r,c) sqrt(r.^2+c.^2);
 
% [cc,~] = fminbnd(@(ep) CostEps1(ep,pde,rbf,DM1,DM2,rhs,lam_p),0,5);
%  cc =  5.5728e-05;
cc = 0.00009;
A1=pde(DM1,cc,lam_p); %(DM1.^2+2*cc^2)./(DM1.^2+cc^2).^(3/2);  %
A2=rbf(DM2,cc); %boundary matrix
coe2=[A1;A2]\rhs;  %Solve Poisson equation

L=20;
b = max(x(:))+.1;
a = min(x(:))-.1;
c = min(y(:))-.1;
d = max(y(:) )+.1;
e = max(z(:))+.1;
f = min(z(:))-.1;

h1 = a:(b-a)/L:b;
k1 = c:(d-c)/L:d;
l1 = f:(e-f)/L:e;

[X, Y, Z] = meshgrid(h1,k1,l1);   X1 = X(:); Y1 = Y(:); Z1 = Z(:);

DM3 = DistanceMatrix([X1 Y1 Z1], ctrs);

u=rbf(DM3,cc)*coe2;  %rsolution on the meshgrid points
u = reshape(u,L+1,L+1,L+1); 
figure;
isosurface(X,Y,Z,u,1);








