load HW1a.txt
x = HW1a(:,1);
y = HW1a(:,2);
plot(x,y, 'bo');
hold on;

A = [x.^3 x.^2 x.^1 x.^0];
r = A\y;
xt = linspace(1,3,500);
yt = r(1)*xt.^3 + r(2)*xt.^2 + r(3)*xt.^1 + r(4);

%plot(x,y, 'bo', xt, yt, 'r--');
%hold on;