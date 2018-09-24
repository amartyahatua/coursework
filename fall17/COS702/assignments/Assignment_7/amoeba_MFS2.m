%Solve biharmonic problem for 2D graphics reconstruction using the MFS
%     \Laplace^2 u=0 in \Omega
%     u(x,y) = 1 on \partial \Omega
%     \partial u / \partial n = g  on \partial \Omega   (g=0 or 1 or ...)
%
%  u= sum c_i* log(r) +sum d_i* r^2 log(r)
%  \partial u /partial n = sum c_i (1/r^2)*(x*nx+y*ny) +sum d_i (1+2*log(r))*(x*nx+y*ny)
% curve = @ (x) (cos(4*x)+sqrt((18/5)-(sin(4*x)).^2)).^(1/3);
   curve = @(x)  exp(sin(x)).*(sin(2*x)).^2+exp(cos(x)).*(cos(2*x)).^2;
% curve = @ (x) (1+cos(2*x).^2);
%curve = @(x) (2+sin(4*x)/2)/2;
n=100; % # of boundary points
% determination of coordinates of boundary points
tt=2*pi*(1:n)/n; rr=curve(tt); 
% tt=tt+.5*sin(4*tt);  %gear shape
x=rr.*cos(tt);   y=rr.*sin(tt);    x=x'; y=y';
dx = gradient(x); dy = gradient(y);
nx= dy;    ny= -dx;     %normal vectors
%%%%%%%%%%%%%%%
kk=1; f=kk*ones(n,1);  %Dirichlet boundary condition 
g=(x.^2+y.^2)/5 ; %zeros(n,1); %1*ones(n,1); %  %  Neumann boundary condition
h=.0001; 
xs=x+h*nx;   ys=y+h*ny;  % coordinates of source points
% xs=xs(1:1:end,1); ys=ys(1:1:end,1);
DM1 = DistanceMatrix([x y], [xs ys]);
nv = (x.*nx+y.*ny);  nv = repmat(nv,1,n);
MFS1 =  log(DM1);         MFS2 = DM1.^2.*log(DM1); 
MFS3 = (1./DM1.^2).*nv;   MFS4 = (1+2*log(DM1)).*nv;  %Neumann boundary condition
% MFS3=zeros(n);  MFS4=4*log(DM1)+4; %Laplace boundary condition
MFS = [MFS1 MFS2; MFS3 MFS4];
coe = MFS\[f;g];
b = max(x)+.1; a = min(x)-.1; c = min(y)-.1; d = max(y )+.1;
L=80; %meshgrid in each axis direction
h = a:(b-a)/L:b; k = c:(d-c)/L:d;
[X, Y] = meshgrid(h,k);   
DM2 = DistanceMatrix([X(:) Y(:)], [xs ys]);
u = log(DM2)*coe(1:n,1)+  DM2.^2.*log(DM2)*coe(n+1:2*n); 
% u1=u;
% index=inpolygon(X(:),Y(:),x,y);
% u1(~index)=NaN;
u = reshape(u,L+1,L+1);
figure (1)
mesh(X, Y, u);
figure (2)
contour(X,Y,u,[kk kk],'b','LineWidth',3)
axis equal