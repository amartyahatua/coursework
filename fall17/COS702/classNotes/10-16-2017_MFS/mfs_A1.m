n=60;
t=linspace(0,2*pi,n);
r=(1+cos(3*t').^2);  
r2=6;
x=r.*cos(t'); y=r.*sin(t');
xs=r2*x; ys=r2*y;
DM=DistanceMatrix([x y],[xs ys]);
rhs=exp(x).*cos(y);
coe=log(DM)\rhs;
pts=rand(300,2)*2-1;
index=inpolygon(pts(:,1),pts(:,2),x,y);
interior=pts(index,:);
xt=interior(:,1); yt=interior(:,2);
DM2=DistanceMatrix(interior,[xs ys]);
approx=log(DM2)*coe;
exact=exp(xt).*cos(yt);
error=abs(exact-approx);
scatter3(xt,yt,error)