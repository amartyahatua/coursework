% Solving Poisson's equation  \Delta u = 2 exp(x+y)
%  with boundary condiition  u(x,y) = exp(x+y)
%  exact solution:  u(x,y)=exp(x+y)
warning off all;
pde =@ (r,c)  (r.^2+2*c^2)./(r.^2+c^2).^(3/2);  
rbf=@(r,c) sqrt(r.^2+c.^2);
forcing=@(x,y) 2*exp(x+y);
bound_con=@(x,y) exp(x+y); 
n=100;  M=400;   % n: # of boundary points;  M:# of interior points
t=linspace(0,2*pi,n);
r=(1+cos(3*t').^2)/2;  
x=r.*cos(t'); y=r.*sin(t');  %boundary points
p=haltonset(2);
pts=net(p,2000)*2-1;  % 2000 Halton points
index=inpolygon(pts(:,1),pts(:,2),x,y);
pts=pts(index,:);
interior=pts(1:M,:); %interior points
coll=[interior;[x y]];  %centers: interior points + boundary points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Kansa's method
DM1=DistanceMatrix(interior,coll);
DM2=DistanceMatrix([x y],coll);
f=forcing(interior(:,1),interior(:,2));  %forcing term of the PDE
g=bound_con(x,y);   %boundary condition
rhs=[f;g]; 
%LOOCV
[c,~] = fminbnd(@(ep) CostEps1(ep,pde,rbf,DM1,DM2,rhs),0,1);
A1=pde(DM1,c);   A2=rbf(DM2,c); 
coe=[A1;A2]\rhs;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xt=pts(M+1:M+200,1); yt=pts(M+1:M+200,2);
DM3=DistanceMatrix([xt yt],coll);
approx=rbf(DM3,c)*coe;
exact=exp(xt+yt);
error=max(abs(exact-approx));
fprintf(' ni =  %3d,  nb = %3d,  c = %5.3f, maxerr =  %11.3e\n',M,n,c,error) 