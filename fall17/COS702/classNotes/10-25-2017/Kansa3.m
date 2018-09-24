% Solving Poisson's equation  \Delta u = 1
%  with boundary condiition  u(x,y) = 1
% curve = @ (x) (cos(4*x)+sqrt((18/5)-(sin(4*x)).^2)).^(1/3);
curve = @(x) (2+sin(4*x)/2)/2;
% curve = @(x)  exp(sin(x)).*(sin(2*x)).^2+exp(cos(x)).*(cos(2*x)).^2;
warning off all;
pde =@ (r,c)  c^2*(c^2*r.^2+2)./(1+c^2*r.^2).^(3/2); %(r.^2+2*c^2)./(r.^2+c^2).^(3/2);  
rbf=@(r,c) sqrt(1+r.^2*c^2);
n=120;  M=50;   % n: # of boundary points;  M:# of interior points
t=linspace(0,2*pi,n);
% r=(1+cos(3*t').^2)/2;  
r=curve(t');
% t=t+.5*sin(4*t);  %gear shape
x=r.*cos(t'); y=r.*sin(t');  %boundary points
b = max(x); a = min(x); c = min(y); d = max(y);  %bounding box 
p=haltonset(2);

pts=net(p,2000);  % 2000 Halton points
pts(:,1)=pts(:,1)*(b-a)+a; pts(:,2)=pts(:,2)*(d-c)+c; 
index=inpolygon(pts(:,1),pts(:,2),x,y);
pts=pts(index,:);
interior=pts(1:M,:); %interior points
coll=[interior;[x y]];  %centers: interior points + boundary points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Kansa's method
DM1=DistanceMatrix(interior,coll);
DM2=DistanceMatrix([x y],coll);
f=ones(M,1);  %forcing term of the PDE
g=ones(n,1);   %boundary condition
rhs=[f;g]; 
%LOOCV
 [cc,~] = fminbnd(@(ep) CostEps1(ep,pde,rbf,DM1,DM2,rhs),0,20);
% cc=8;
A1=pde(DM1,cc);   A2=rbf(DM2,cc); 
coe=[A1;A2]\rhs;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = max(x)+.1; a = min(x)-.1; c = min(y)-.1; d = max(y )+.1;
L=80;
h = a:(b-a)/L:b; k = c:(d-c)/L:d;
[X, Y] = meshgrid(h,k);   
DM2 = DistanceMatrix([X(:) Y(:)], coll);

% h=linspace(-1,1,L);
% [X,Y]=meshgrid(h);
% X1=X(:); Y1=Y(:);
% DM3=DistanceMatrix([X1 Y1],coll);
Pf=rbf(DM2,cc)*coe;
% Plot extended data with 2D-fit Pf
  figure (1); 
  %plot3(dsites(:,1),dsites(:,2),rhs,'r.','markersize',20);
  mesh(X,Y,reshape(Pf,L+1,L+1));
  axis tight;
  % Plot data sites with interpolant (zero contour of 2D-fit Pf)
%   figure (2); 
%   plot(dsites(1:N,1),dsites(1:N,2),'bo');
  figure (2)
  contour(X,Y,reshape(Pf,L+1,L+1),[1 1],'r'); axis equal;
  hold on;
  scatter(interior(:,1),interior(:,2));
  hold off;