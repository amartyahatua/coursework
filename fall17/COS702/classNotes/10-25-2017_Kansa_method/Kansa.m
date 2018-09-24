
pde =@ (r,c)  (r.^2+2*c^2)./(r.^2+c^2).^(3/2);
rbf=@(r,c) sqrt(r.^2+c.^2);
forcing=@(x,y) 2*exp(x+y);
bound_con=@(x,y) exp(x+y); 
c=.8;
n=120;  M=400;   % n: # of boundary points;  M:# of interior points
t=linspace(0,2*pi,n);
r=(1+cos(3*t').^2)/2;  
x=r.*cos(t'); y=r.*sin(t');
p=haltonset(2);
pts=net(p,2000)*2-1;
% pts=rand(500,2)*2-1; 
index=inpolygon(pts(:,1),pts(:,2),x,y);
pts=pts(index,:);
pts1=pts(1:M,:);
coll=[pts1;[x y]];
DM1=DistanceMatrix(pts1,coll);
A1=pde(DM1,c);
DM2=DistanceMatrix([x y],coll);
A2=rbf(DM2,c); 
f=forcing(pts1(:,1),pts1(:,2)); 
g=bound_con(x,y);
coe=[A1;A2]\[f;g];

% pts=rand(300,2)*2-1;
% index=inpolygon(pts(:,1),pts(:,2),x,y);
% interior=pts(index,:);
% xt=interior(:,1); yt=interior(:,2);
xt=pts(M+1:M+100,1); yt=pts(M+1:M+100,2);
DM3=DistanceMatrix([xt yt],coll);
approx=rbf(DM3,c)*coe;
exact=exp(xt+yt);
error=abs(exact-approx);
scatter3(xt,yt,error)