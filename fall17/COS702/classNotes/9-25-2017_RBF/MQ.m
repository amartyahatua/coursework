clear all;
warning off all;
f1 = @(x,y) .75*exp(-((9*x-2).^2+(9*y-2).^2)/4);
f2 = @(x,y) .75*exp(-((9*x+1).^2/49+(9*y+1).^2/10));
f3 = @(x,y) .5*exp(-((9*x-7).^2+(9*y-3).^2)/4);
f4 = @(x,y) .2*exp(-((9*x-4).^2+(9*y-7).^2));
rbf = @ (r,c) sqrt(r.^2*c^2+1);
testfunction = @(x,y) f1(x,y)+f2(x,y)+f3(x,y)-f4(x,y);
k=600; %total number of interpolation points
p=haltonset(2);
pts=net(p,1000); %Generate 1000 2D Halton points
ctrs=pts(1:k,:);  % center or training set
x=ctrs(1:k,1); y=ctrs(1:k,2); 
xt=pts(k+1:k+200,1); yt=pts(k+1:k+200,2);  %test points or test set
Z=testfunction(x,y); % produce f(x,y)
DM=DistanceMatrix(ctrs,ctrs);
c=linspace(1,5,60); 
error=zeros(length(c),1);
exact=testfunction(xt,yt);  %exact value of f(x,y)
for i=1:length(c)
A=rbf(DM,c(i)); % Create the interpolation matrix
coe=A\Z;
DM1=DistanceMatrix([xt yt],ctrs);
approx=rbf(DM1,c(i))*coe;
error(i)=norm((exact-approx),inf);
end
semilogy(c,error)      