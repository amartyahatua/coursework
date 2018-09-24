load data2.mat
n=length(x);
A=[ones(n,1), zeros(n,1), cos(2*pi*t/T);
    zeros(n,1), ones(n,1), sin(2*pi*t/T)];
z=[x;y];
x1=A\z;
theta=linspace(0,2*pi,200);
xt=x1(1)+x1(3)*cos(theta);
yt=x1(2)+x1(3)*sin(theta);
plot(x,y,'r.',xt,yt)
axis equal
