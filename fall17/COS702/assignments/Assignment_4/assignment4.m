[X1,X2] = ndgrid(-1:.02:1, -1:.02:1); 


Z = exp(-(81/4)*(X1.^2 + X2.^2));

for i= 1:101
    for j = 1:101
        if((X1(i,j).^2 + X2(i,j).^2 -1) > 0)
            X1(i,j) = NaN;
            X2(i,j) = NaN;
        end
    end
end

for i= 1:101
    for j = 1:101
        if(((X1(i,j)+0.3).^2 + (X2(i,j)+0.3).^2 -0.09) <= 0)
            X1(i,j) = NaN;
            X2(i,j) = NaN;
        end
    end
end


mesh(X1,X2,Z);