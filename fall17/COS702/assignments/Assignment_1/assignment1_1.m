load HW1.txt
x = HW1(:,1);
y = HW1(:,2);
plot(x,y, 'bo');
hold on;
n = length(x);
c = ones(n,1); 
o = zeros(n,1);

A = [cos(x).^3,sin(x).^3 ,c; cos(x).^3,sin(x).^3 ,c];
z = [x;y];
r = A\z;

theta = linspace(0,2*pi,200);

xt = r(1)*cos(theta).^3+r(2)*sin(theta).^3+r(3);
yt = r(1)*sin(theta).^3+r(2)*cos(theta).^3+r(3);
figure
plot(x,y, 'bo',xt,yt,'r')
hold on