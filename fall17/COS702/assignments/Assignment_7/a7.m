clear All;

calError = 100;
n=50; 
flag = 0;
for n = 35:5:100
    theta = 2*pi*(1:n)/n;
    phi = pi*(1:n)/n;

    [theta,phi] = meshgrid(theta,phi);
    r = 1+(1/6).*sin(6*theta).*sin(7*phi);
    x = r.*sin(phi).*cos(theta);
    y = r.*sin(phi).*sin(theta);
    z = r.*cos(phi);

    if (flag == 0)
        flag = 1;
        fun = @(x,y,z) x.*cos(y) + x.^2.*cos(z)
        r = 1+(1/6).*sin(6*theta).*sin(7*phi);
        fun = @(x,y,z) sin(y).*(z.^2);
        xmin = 0;
        xmax = 2*pi;
        ymin = 0;
        ymax = pi;
        zmin = 0;
        zmax = @(x,y) 1+(sin(6.*x).*sin(7.*y))/6;

        exactVolume = integral3(fun,xmin,xmax,ymin,ymax,zmin,zmax,'Method','tiled');
    end
    
   


    %%%%%%%%%%%%%%%
    kk=1; f=kk*ones(n*n,1);  %Dirichlet boundary condition 
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
    if (flag == 1)
        for i = 1:size(P,1)/500
            starts = 500*(i-1)+1;
            ends = 500*i;    
            DM2 = DistanceMatrix(P(starts:ends,:),Q); 
            u(starts:ends,1) = DM2/(8*pi)*coe(:,1); 
        end
        u = reshape(u,L+1,L+1,L+1);
        figure;
        isosurface(X,Y,Z,u,1);
        flag = 2;
    end
    totalPoints = 50000;
    volCube = (b-a)*(d-c)*(e-f);
    p=haltonset(3);
    
    for totalPoints= 50000:10000:400000
    
        pts=net(p,totalPoints); %Generate 1000 3D Halton points
        epoints_hlt = [pts(:,1).*((b-a)+a)  pts(:,2).*((d-c)+c)  pts(:,3).*((e-f)+f)];
        v=zeros(size(epoints_hlt,1),1);
        %DM_eval_hlt = DistanceMatrix(epoints_hlt,ctrs);
        for i = 1:size(epoints_hlt,1)/500
            starts = 500*(i-1)+1;
            ends = 500*i;    
            DM2 = DistanceMatrix(epoints_hlt(starts:ends,:),Q); 
            v(starts:ends,1) = DM2/(8*pi)*coe(:,1); 
        end
        
        if(ends<size(epoints_hlt,1))
            starts = ends+1;
            ends = size(epoints_hlt,1);
            DM2 = DistanceMatrix(epoints_hlt(starts:ends,:),Q); 
            v(starts:ends,1) = DM2/(8*pi)*coe(:,1); 
        end
        
        pointsInSide = sum(sum(sum(v<=1)));
        calculatedVol = volCube*(pointsInSide/totalPoints);
        fprintf('Calculated volume=%f.\n',calculatedVol);
        fprintf('Boundary points=%d Halton points=%d.\n',(n*n),totalPoints);
        
        if(abs(exactVolume-calculatedVol)<calError)
            calError = abs(exactVolume-calculatedVol);
            bestVolume = calculatedVol;
            bestN = n;
            bestH = totalPoints;
        end
        
        error(((n-35)/5)+1,((totalPoints-50000)/10000)+1)=abs(exactVolume-calculatedVol);
        %error(n,totalPoints)=abs(exactVolume-calculatedVol);
    end
end 

fprintf('Exact volume=%f.\n',exactVolume);
fprintf('Best calculated volume=%f.\n',bestVolume);
fprintf('Least error=%f.\n',calError);
fprintf('Best boundary points=%d.\n',(bestN*bestN));
fprintf('Best halton points=%d',bestH);
