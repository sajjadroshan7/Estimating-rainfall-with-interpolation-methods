clc
clear
data = csvread("data.csv");
[m,n] = size(data);
points(6,3)=0;
p =1;
for i=1:m
    for j=1:n
        if data(i,j)~=0
            points(p,1) = i;
            points(p,2) = j;
            points(p,3) = data(i,j);
            p=p+1;
        end
    end
end
DT = DelaunayTri(points(:,[1,2])); 
tri = DT.Triangulation;
%tri angular equations
[tm,tn] = size(tri);
equtions(tm,3)=0;
syms a b c
for i=1:tm
    eq_1= a*points(tri(i,1),1)+b*points(tri(i,1),2)+c==points(tri(i,1),3);
    eq_2= a*points(tri(i,2),1)+b*points(tri(i,2),2)+c==points(tri(i,2),3);
    eq_3= a*points(tri(i,3),1)+b*points(tri(i,3),2)+c==points(tri(i,3),3);
    [A,B,C] = solve([eq_1,eq_2,eq_3],[a,b,c]);
    equtions(i,1) = A ;
    equtions(i,2) = B ;
    equtions(i,3) = C ;
end
for i=1:m
    for j=1:n
        if data(i,j)==0
            for k=1:tm
               p= [i,j];
               a = [points(tri(k,1),1),points(tri(k,1),2)];
               b = [points(tri(k,2),1),points(tri(k,2),2)];
               c = [points(tri(k,3),1),points(tri(k,3),2)];
               result = isinside(p,a,b,c);
               if result ==1
                   data(i,j) = i*equtions(k,1)+j*equtions(k,2)+equtions(k,3);
               end
            end
        
        end
    end
end
csvwrite("out_u.csv",data)
imshow(mat2gray(data))
    

            
            
