function Add_Original_Data2() %添加数据
clc
close all
clear all
x=0.01:0.01*pi:45*pi;
len=length(x);
columns=9;%列数
rows=len/columns;%行数4500/9=500
%% {***************************--trainData--******************************%}
%% 原始数据
%故障1
x1=2*sin(x)+ 0.4*rand(1,len);
Fault1=reshape(x1,columns,rows);
%故障2
x2=2*sin(4*x)+ 0.4*rand(1,len);
Fault2=reshape(x2,columns,rows);
%故障3
x3=3*sin(8*x)+ 0.4*rand(1,len);
Fault3=reshape(x3,columns,rows);
%故障4
x4=2*sin(16*x)+ 0.4*rand(1,len);
Fault4=reshape(x4,columns,rows);
trainData_original=[Fault1,Fault2,Fault3,Fault4];

%% 斜率数据
%故障1数据的斜率
x1_slope=zeros(1,len);
for i=1:len-1
    x1_slope(i+1)=x1(i+1)-x1(i);
end
Fault1_slope=reshape(x1_slope,columns,rows);
%故障2数据的斜率
x2_slope=zeros(1,len);
for i=1:len-1
    x2_slope(i+1)=x2(i+1)-x2(i);
end
Fault2_slope=reshape(x2_slope,columns,rows);
%故障3数据的斜率
x3_slope=zeros(1,len);
for i=1:len-1
    x3_slope(i+1)=x3(i+1)-x3(i);
end
Fault3_slope=reshape(x3_slope,columns,rows);
%故障4数据的斜率
x4_slope=zeros(1,len);
for i=1:len-1
    x4_slope(i+1)=x4(i+1)-x4(i);
end
Fault4_slope=reshape(x4_slope,columns,rows);
trainData_slope=[Fault1_slope,Fault2_slope,Fault3_slope,Fault4_slope];

%% 曲率数据
%故障1数据的曲率
x1_curvature=zeros(1,len);
for i=1:len-1
    x1_curvature(i+1)=x1_slope(i+1)-x1_slope(i);
end
Fault1_curvature=reshape(x1_curvature,columns,rows);
%故障2数据的曲率
x2_curvature=zeros(1,len);
for i=1:len-1
    x2_curvature(i+1)=x2_slope(i+1)-x2_slope(i);
end
Fault2_curvature=reshape(x2_curvature,columns,rows);
%故障3数据的曲率
x3_curvature=zeros(1,len);
for i=1:len-1
    x3_curvature(i+1)=x3_slope(i+1)-x3_slope(i);
end
Fault3_curvature=reshape(x3_curvature,columns,rows);
%故障4数据的曲率
x4_curvature=zeros(1,len);
for i=1:len-1
    x4_curvature(i+1)=x4_slope(i+1)-x4_slope(i);
end
Fault4_curvature=reshape(x4_curvature,columns,rows);
trainData_curvature=[Fault1_curvature,Fault2_curvature,Fault3_curvature,Fault4_curvature];
%% 特征组合
trainData=[trainData_original;trainData_slope;trainData_curvature];
save trainData trainData
%% 训练数据标签
trainLabel=[ones(1,rows),repmat(2,1,rows),repmat(3,1,rows),repmat(4,1,rows)]';
save trainLabel trainLabel
%% {***************************--testData--******************************%}
%% 原始数据
%故障1
x1=2*sin(x)+ 0.4*rand(1,len);
Fault1=reshape(x1,columns,rows);
%故障2
x2=2*sin(4*x)+ 0.4*rand(1,len);
Fault2=reshape(x2,columns,rows);
%故障3
x3=3*sin(8*x)+ 0.4*rand(1,len);
Fault3=reshape(x3,columns,rows);
%故障4
x4=2*sin(16*x)+ 0.4*rand(1,len);
Fault4=reshape(x4,columns,rows);
testData_original=[Fault1,Fault2,Fault3,Fault4];

%% 斜率数据
%故障1数据的斜率
x1_slope=zeros(1,len);
for i=1:len-1
    x1_slope(i+1)=x1(i+1)-x1(i);
end
Fault1_slope=reshape(x1_slope,columns,rows);
%故障2数据的斜率
x2_slope=zeros(1,len);
for i=1:len-1
    x2_slope(i+1)=x2(i+1)-x2(i);
end
Fault2_slope=reshape(x2_slope,columns,rows);
%故障3数据的斜率
x3_slope=zeros(1,len);
for i=1:len-1
    x3_slope(i+1)=x3(i+1)-x3(i);
end
Fault3_slope=reshape(x3_slope,columns,rows);
%故障4数据的斜率
x4_slope=zeros(1,len);
for i=1:len-1
    x4_slope(i+1)=x4(i+1)-x4(i);
end
Fault4_slope=reshape(x4_slope,columns,rows);
testData_slope=[Fault1_slope,Fault2_slope,Fault3_slope,Fault4_slope];

%% 曲率数据
%故障1数据的曲率
x1_curvature=zeros(1,len);
for i=1:len-1
    x1_curvature(i+1)=x1_slope(i+1)-x1_slope(i);
end
Fault1_curvature=reshape(x1_curvature,columns,rows);
%故障2数据的曲率
x2_curvature=zeros(1,len);
for i=1:len-1
    x2_curvature(i+1)=x2_slope(i+1)-x2_slope(i);
end
Fault2_curvature=reshape(x2_curvature,columns,rows);
%故障3数据的曲率
x3_curvature=zeros(1,len);
for i=1:len-1
    x3_curvature(i+1)=x3_slope(i+1)-x3_slope(i);
end
Fault3_curvature=reshape(x3_curvature,columns,rows);
%故障4数据的曲率
x4_curvature=zeros(1,len);
for i=1:len-1
    x4_curvature(i+1)=x4_slope(i+1)-x4_slope(i);
end
Fault4_curvature=reshape(x4_curvature,columns,rows);
testData_curvature=[Fault1_curvature,Fault2_curvature,Fault3_curvature,Fault4_curvature];
testData=[testData_original;testData_slope;testData_curvature];
save testData testData
%% 测试数据标签
testLabel=[ones(1,rows),repmat(2,1,rows),repmat(3,1,rows),repmat(4,1,rows)]';
save testLabel testLabel