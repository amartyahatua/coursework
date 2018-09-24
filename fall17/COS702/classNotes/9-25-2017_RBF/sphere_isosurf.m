%# create coordinates
[xx,yy,zz] = meshgrid(-2:.2:2,-2:.2:2,-2:.2:2);
%# calculate distance from center of the cube
rr = sqrt(xx.^2 + yy.^2 + zz.^2);
 rr(:,1:10,6:10)=NaN;
%# create the isosurface by thresholding at a iso-value of 10
figure (1);
isosurface(xx,yy,zz,rr,1); 
axis equal 
%# make sure it will look like a sphere
figure (2);
plot3(xx(:),yy(:),zz(:),'b.')
