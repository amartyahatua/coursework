%function amoeba3_graph
%Solve Modified Helmholtz problem for 2D graphics reconstruction using the Kansa method  
%  \Laplace u - \lamda u= 1  in \Omega
%           u = 1  on \partial \Omega
% Kansa method using interior points and boundary points
clear all;
warning off all;
%  curve = @(x) (cos(4*x)+sqrt((18/5)-(sin(4*x)).^2)).^(1/3);
% curve = @(x) 2*(1+cos(x)); %1-cos(x);  %    
% curve = @(t) (1+cos(4*t).^2);
curve = @(x) (2+sin(4*x)/2)/2; %% 2D Equation for boundary points
% curve = @(x) exp(sin(x)).*(sin(2*x)).^2+exp(cos(x)).*(cos(2*x)).^2;
% pde=@ (r,c,lam) (r.^2+2*c^2)./(r.^2+c^2).^(3/2)-lam*sqrt(r.^2+c*c);
% rbf = @(r,c) sqrt(r.^2+c^2);
 pde=@ (r,c,lam) c^2*(c^2*r.^2+2)./(1+c^2*r.^2).^(3/2)-lam*sqrt(1+r.^2*c*c);
 rbf = @(r,c) sqrt(1+r.^2*c^2);
n=150;  %number of boundary points
lam=20;
tt=2*pi*(1:n)'/n; 
rr=curve(tt); 
tt=tt+.5*sin(4*tt);  %gear shape
x=rr.*cos(tt);   y=rr.*sin(tt); %boundary points
b = max(x); a = min(x); c = min(y); d = max(y);  %bounding box 
L=10; %meshgrid points covering the domain
h1 = a:(b-a)/L:b; k1 = c:(d-c)/L:d;
[X, Y] = meshgrid(h1,k1);   X1 = X(:); Y1 = Y(:);
in=inpolygon(X1,Y1,x,y); %catch interior points
 x1=X1(in); y1=Y1(in); %interior points
xx=[x1;x]; yy=[y1;y]; %interior + boundar points
ctrs=[xx yy];         %center of RBF
DM1=DistanceMatrix([x1 y1], ctrs);  %Distance matrix of interior points
DM2=DistanceMatrix([x y], ctrs);    %Distance matrix of boundary points
k1 = 1;  f = k1*ones(length(x1),1);  %forcing term
k2 =1;  g = k2*ones(n,1); %boundary condition
rhs=[f;g];
%% matrix system  (Kansa method)
 [cc,~] = fminbnd(@(ep) CostEps1(ep,pde,rbf,DM1,DM2,rhs,lam),0,205);
cc
A1=pde(DM1,cc,lam); %(DM1.^2+2*cc^2)./(DM1.^2+cc^2).^(3/2);  %
A2=rbf(DM2,cc); %boundary matrix
coe2=[A1;A2]\rhs;  %Solve Poisson equation
%% %%% reconstruct the curve
L=60; %meshgrid in each axis direction
b = max(x); a = min(x); c = min(y); d = max(y);  %bounding box 
h1 = a:(b-a)/L:b; k1 = c:(d-c)/L:d;
[X, Y] = meshgrid(h1,k1);   X1 = X(:); Y1 = Y(:);
DM2 = DistanceMatrix([X1 Y1], ctrs);
u=rbf(DM2,cc)*coe2;  %rsolution on the meshgrid points
u = reshape(u,L+1,L+1); 
figure (1)
mesh(X, Y, u);
figure (2)
contour(X,Y,u,[k2 k2],'r','LineWidth',3)  %reconstruct the curve by plotting level curve 
hold on;
scatter(x1,y1);
axis equal; hold off;