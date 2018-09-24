clear all;
M = 150;  

r = @(x) sqrt((exp(sin(x)).*(sin(2*x).^2)+exp(cos(x)).*(cos(2*x).^2)).^2 + (sin(x).*(-exp(cos(x))).*cos(2*x).^2+ exp(sin(x)).*sin(2*x).^2.*cos(x)-4.*sin(2*x).*exp(cos(x)).*cos(2*x)+4.*exp(sin(x)).*sin(2*x).*cos(2*x)).^2);
S = integral(r,0,2*pi);

p = @(t,tk)   sqrt(((exp(sin(t)).*(sin(2*t)).^2+exp(cos(t)).*(cos(2*t)).^2)*cos(t)...
    -(exp(sin(tk)).*(sin(2*tk)).^2+exp(cos(tk)).*(cos(2*tk)).^2)*cos(tk)).^2 + ...
    ((exp(sin(t)).*(sin(2*t)).^2+exp(cos(t)).*(cos(2*t)).^2)*sin(t)...
    -(exp(sin(tk)).*(sin(2*tk)).^2+exp(cos(tk)).*(cos(2*tk)).^2)*sin(tk)).^2)-S/M; 

theta=zeros(M,1);
for i = 2:M
    tk = theta(i-1);           
    fun = @(t) p(t,tk);    
    theta(i) = fzero(fun,[tk tk+pi/4]);
end
t = theta;
r = exp(sin(t)).*(sin(2*t)).^2+exp(cos(t)).*(cos(2*t)).^2;
xt = r.*cos(t); yt = r.*sin(t);
scatter(xt,yt,'.')

