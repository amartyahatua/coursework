function cu=curve(x)
cu=exp(sin(x)).*(sin(2*x)).^2+exp(cos(x)).*(cos(2*x)).^2;
end
%%  radial curve derivative function
function cud=curveder(x)
cud=cos(x).*exp(sin(x)).*sin(2*x).^2+4*exp(sin(x)).*sin(2*x).*cos(2*x)...
    -sin(x).*exp(cos(x)).*cos(2*x).^2-4*exp(cos(x)).*cos(2*x).*sin(2*x);end