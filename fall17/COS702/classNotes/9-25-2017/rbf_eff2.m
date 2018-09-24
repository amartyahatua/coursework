clear all;
load -ascii intpts.txt; % input scattered data (x,y,z)
k=300; n=7;
X=intpts(1:k,1); Y=intpts(1:k,2); Z=intpts(1:k,3);
%DM=DistanceMatrix(intpts(1:k,1:2),intpts(1:k,1:2)); % Create the distance matrix
%x2=X*ones(1,k)-ones(k,1)*X';      y2=Y*ones(1,k)-ones(k,1)*Y';
x2=repmat(X,1,k)-repmat(X',k,1);
y2=repmat(Y,1,k)-repmat(Y',k,1);
DM=sqrt(x2.^2+y2.^2);  %Distance Matrix
A=DM.^n; % Interpolation matrix
c=A\Z;   % Solve A*c=Z
%Reconstruction of the surface.
[M N]=meshgrid(-3:0.15:3);
x1=reshape(M,[],1);  y1=reshape(N,[],1);

testpt=[x1 y1];  m=length(M);
DM1=DistanceMatrix(testpt,intpts(1:k,1:2));
B=DM1.^n*c;
E=reshape(B,m,m);
figure(1) %plot the input data
scatter3(X,Y,Z,'filled'); view(65,20);
figure(2) %plot the reconstructed surface
surf(M,N,E,'FaceColor','red','EdgeColor','none')
view(65,20); camlight left; lighting phong  
