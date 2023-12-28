clc
clear
data = csvread("height.csv");
output = 0.3029.*data + 26.827;
csvwrite("rainfall.csv" ,output )
