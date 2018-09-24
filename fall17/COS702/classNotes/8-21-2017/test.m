x=[-3 -2 1 0 1 2 3]';
y=[0 2 1 -3 -1 5 -9]';
n=length(x);
A=[ones(n,1) x x.^2];
B=y;
%A1=A'*A;
%B=A'*B;
C=A\B

xt = -3:0.02:3;
yt = C(1) + C(2)*xt + C(3)*xt.^2;
plot(x,y,'*',xt,yt);