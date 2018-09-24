clear all;
load -ascii intpts.txt; % input scattered data (x,y,z)
X=intpts(:,1); Y=intpts(:,2); Z=intpts(:,3);
k=length(intpts); 
%A=zeros(k);
% Create the interpolation matrix
for i=1:k
    for j=1:k
        r=sqrt((X(i)-X(j))^2+(Y(i)-Y(j))^2);
        A(i,j)=r^5; % radial basis function
    end
end
c=A\Z; % Solve A*c=Z
%reconstruction of the surface. regenerate f(x,y) at each grid points
[M N]=meshgrid(-3:0.15:3);
E=zeros(41);
for i=1:41
    for j=1:41
          for k1=1:k
            r=sqrt((M(i,j)-X(k1))^2+(N(i,j)-Y(k1))^2);  
            E(i,j)=E(i,j)+c(k1)*r^5;
          end 
    end    
end
%plot the scatter data
figure(1)
scatter3(X,Y,Z,'filled');
view(65,20); 
%plot the reconstructed surface
figure(2)
surf(M,N,E,'FaceColor','red','EdgeColor','none')
view(65,20); camlight left; lighting phong        