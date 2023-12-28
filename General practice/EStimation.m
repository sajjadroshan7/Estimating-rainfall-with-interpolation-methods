clc
clear

triang = csvread("Triangulation.csv");
IDW_5_2 = csvread("IDW_5_2.csv");
IDW_10_1 = csvread("IDW_10_1.csv");
regres = csvread("Triangulation.csv");

mean__ = mean(mean(triang+IDW_5_2+IDW_10_1+regres));
sd_ = std(std(triang+IDW_5_2+IDW_10_1+regres));
max_= max(max(triang+IDW_5_2+IDW_10_1+regres));
min_= sort(unique(triang+IDW_5_2+IDW_10_1+regres));
min_ = min_(2,1);