x = linspace(2,-2,20);
y = 1./(x+(1-x).^2);

p = polyfit(x,y,10);
%plot(x,y,'*',x,polyval(p,x),'--');

xx = linspace(2,-2,60);
yy = spline(x,y,xx);

plot(x,y,'*',xx,yy,'--');