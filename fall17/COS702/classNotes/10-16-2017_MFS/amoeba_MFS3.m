%Solve biharmonic problem for 2D graphics reconstruction using the MFS
%     \Laplace^2 u=0 in \Omega
%     u(x,y) = 1 on \partial \Omega
%    
%  u= sum d_i* r^2 log(r)
% curve = @ (x) (cos(4*x)+sqrt((18/5)-(sin(4*x)).^2)).^(1/3);
curve = @(x)  exp(sin(x)).*(sin(2*x)).^2+exp(cos(x)).*(cos(2*x)).^2;
% curve = @ (x) (1+cos(2*x).^2);
% curve = @(x) (2+sin(4*x)/2)/2;
n=100; % # of boundary points
% determination of coordinates of boundary points
tt=2*pi*(1:n)/n; rr=curve(tt); 
% tt=tt+.5*sin(4*tt);  %gear shape
x=rr.*cos(tt);   y=rr.*sin(tt);    x=x'; y=y';
%%%%%%%%%%%%%%%
kk=1; f=kk*ones(n,1);  %Dirichlet boundary condition 
DM1 = DistanceMatrix([x y], [x y]);
index= DM1==0;       
MFS2 = DM1.^2.*log(DM1); 
MFS2(index)=0;
coe = MFS2\f;
b = max(x)+.1; a = min(x)-.1; c = min(y)-.1; d = max(y )+.1;
L=60; %meshgrid in each axis direction
h = a:(b-a)/L:b; k = c:(d-c)/L:d;
[X, Y] = meshgrid(h,k);   
DM2 = DistanceMatrix([X(:) Y(:)], [x y]);
u =   DM2.^2.*log(DM2)*coe; 
u = reshape(u,L+1,L+1);
figure (1)
mesh(X, Y, u);
figure (2)
contour(X,Y,u,[kk kk],'b','LineWidth',3)
axis equal