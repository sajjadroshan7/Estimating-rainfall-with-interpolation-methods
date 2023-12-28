clc
clear
data = csvread("DEM.csv");
[m,n] = size(data);
data(m,n)=0;
for i=1:m
    for j=1:n
        if data(i,j)~=0
            output(i,j) = -0.6225.*data(i,j) + 410.26;
        end
    end
end
csvwrite("Regression-rainfall.csv" ,output )