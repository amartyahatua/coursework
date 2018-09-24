clear;
load('pear3D.mat');

x = dsites(1:10754,1);
y = dsites(1:10754,2);
z = dsites(1:10754,3);

[rows,cols] = size(x);
kk=1; f=kk*ones(rows,1);  %Dirichlet boundary condition
DM1 = DistanceMatrix([x(:) y(:) z(:)], [x(:) y(:) z(:)]);  
MFS2 = (DM1./(8*pi));
coe = MFS2\f;
b = max(x(:))+.1; a = min(x(:))-.1; c = min(y(:))-.1; d = max(y(:) )+.1; e = max(z(:))+.1; f = min(z(:))-.1;
L=49; %meshgrid in each axis direction
h = a:(b-a)/L:b; k = c:(d-c)/L:d; l = f:(e-f)/L:e;
       
[X, Y, Z] = meshgrid(h,k,l);   
P=[X(:) Y(:) Z(:)];
Q=[x(:) y(:) z(:)];
u=zeros(size(P,1),1);
for i = 1:size(P,1)/500
    starts = 500*(i-1)+1;
    ends = 500*i;    
    DM2 = DistanceMatrix(P(starts:ends,:),Q); 
    u(starts:ends,1) = DM2/(8*pi)*coe(:,1); 
    u(DM2==0)=0;
end
u = reshape(u,L+1,L+1,L+1);
figure;
isosurface(X,Y,Z,u,1);

%%%%%%%%%%%%%%%%%%%%%%%% Calculate Volume %%%%%%%%%%%%%%%%%%%%%

x = dsites(1:10754,1);
y = dsites(1:10754,2);
z = dsites(1:10754,3);
[rows,cols] = size(x);
b = max(x);
a = min(x);
c = min(y);
d = max(y);
e = max(z);
f = min(z);

Q=[x(:) y(:) z(:)];

volCube = (b-a)*(d-c)*(e-f);
p=haltonset(3);

for totalPoints= 50000:10000:70000
    pts=net(p,totalPoints); %Generate 1000 3D Halton points
    epoints_hlt = [(pts(:,1).*(b-a)+a)  (pts(:,2).*(d-c)+c)  (pts(:,3).*(e-f)+f)];
    v=zeros(size(epoints_hlt,1),1);
    %DM_eval_hlt = DistanceMatrix(epoints_hlt,ctrs);
    for i = 1:size(epoints_hlt,1)/500
        starts = 500*(i-1)+1;
        ends = 500*i;
        DM6 = DistanceMatrix(epoints_hlt(starts:ends,:),Q);
        v(starts:ends,1) = (DM6./(8*pi))*coe;
    end

    if(ends<size(epoints_hlt,1))
        starts = ends+1;
        ends = size(epoints_hlt,1);
        DM6 = DistanceMatrix(epoints_hlt(starts:ends,:),Q);
        v(starts:ends,1) = (DM6./(8*pi))*coe(:,1);
    end

            pointsInSide = sum(v<=1);
            calculatedVol = volCube*(pointsInSide/totalPoints);
            fprintf('Calculated volume=%f.\n',calculatedVol);
            fprintf('Boundary points=%d Halton points=%d.\n',(rows),totalPoints);
end







        