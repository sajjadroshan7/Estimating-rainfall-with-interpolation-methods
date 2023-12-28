clc
clear
data = csvread("data.csv");
[m,n] = size(data);
%points format i,j and rainfall
Contorol_points(5,3)=0;
k = 1;
for i=1:m
    for j=1:n
        if data(i,j)>35
            Contorol_points(k,1)= i;
            Contorol_points(k,2)= j;
            Contorol_points(k,3)= data(i,j);
            k = k+1;
            data(i,j) =0;
        end
    end
end
distanc(5,1)=0;
points(24,3)=0;
p =1;
for i=1:m
    for j=1:n
        if data(i,j)~=0 && data(i,j)<=30
            s= 0;
            w = 0;
            distanc(1,1) = sqrt((i- Contorol_points(1,1))^2+(j- Contorol_points(1,2))^2);
            distanc(2,1) = sqrt((i- Contorol_points(2,1))^2+(j- Contorol_points(2,2))^2);
            distanc(3,1) = sqrt((i- Contorol_points(3,1))^2+(j- Contorol_points(3,2))^2);
            distanc(4,1) = sqrt((i- Contorol_points(4,1))^2+(j- Contorol_points(4,2))^2);
            distanc(5,1) = sqrt((i- Contorol_points(5,1))^2+(j- Contorol_points(5,2))^2);
            for d=1:5
                if distanc(d,1)<=5
                    weight = 1/distanc(d,1)^2;
                    w = w + weight;
                    s = s + weight*Contorol_points(d,3);
                end 
            end
            data(i,j) = s/w;
            points(p,1) = i;
            points(p,2) = j;
            points(p,3)=s/w;
            p = p +1;
        end
    end
end
csvwrite("output_points.csv",points);
%evaluation 
control_points_test(5,1)=0;
MAE(5,1)=0;
MBE(5,1)=0; 
for i=1:24
    s = 0;
    w = 0;
    for j=1:5
        dist = (sqrt(points(i,1)-Contorol_points(j,1))^2+(points(i,2)-Contorol_points(j,2))^2);
        if dist<=5
            weight = 1/dist^2;
            s = s + points(i,3)*weight;
            w = w + weight;
        end
        control_points_test(i,1) =s/w; 
        MAE(j,1) = abs(Contorol_points(j,3)-control_points_test(j,1));
        MBE(j,1) = Contorol_points(j,3)-control_points_test(j,1);
    end
end
csvwrite("IDW_5_2.csv",data);
csvwrite("MAE5_2.csv",MAE);
csvwrite("MBE5_2.csv",MBE);
