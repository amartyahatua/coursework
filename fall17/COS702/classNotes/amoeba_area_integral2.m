rmax = @(theta) exp(sin(theta)).*(sin(2*theta)).^2+exp(cos(theta)).*(cos(2*theta)).^2;
fun = @(theta,r) r;
integral2(fun,0,2*pi,0,rmax)
