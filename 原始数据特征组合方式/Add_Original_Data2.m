function Add_Original_Data2() %�������
clc
close all
clear all
x=0.01:0.01*pi:45*pi;
len=length(x);
columns=9;%����
rows=len/columns;%����4500/9=500
%% {***************************--trainData--******************************%}
%% ԭʼ����
%����1
x1=2*sin(x)+ 0.4*rand(1,len);
Fault1=reshape(x1,columns,rows);
%����2
x2=2*sin(4*x)+ 0.4*rand(1,len);
Fault2=reshape(x2,columns,rows);
%����3
x3=3*sin(8*x)+ 0.4*rand(1,len);
Fault3=reshape(x3,columns,rows);
%����4
x4=2*sin(16*x)+ 0.4*rand(1,len);
Fault4=reshape(x4,columns,rows);
trainData_original=[Fault1,Fault2,Fault3,Fault4];

%% б������
%����1���ݵ�б��
x1_slope=zeros(1,len);
for i=1:len-1
    x1_slope(i+1)=x1(i+1)-x1(i);
end
Fault1_slope=reshape(x1_slope,columns,rows);
%����2���ݵ�б��
x2_slope=zeros(1,len);
for i=1:len-1
    x2_slope(i+1)=x2(i+1)-x2(i);
end
Fault2_slope=reshape(x2_slope,columns,rows);
%����3���ݵ�б��
x3_slope=zeros(1,len);
for i=1:len-1
    x3_slope(i+1)=x3(i+1)-x3(i);
end
Fault3_slope=reshape(x3_slope,columns,rows);
%����4���ݵ�б��
x4_slope=zeros(1,len);
for i=1:len-1
    x4_slope(i+1)=x4(i+1)-x4(i);
end
Fault4_slope=reshape(x4_slope,columns,rows);
trainData_slope=[Fault1_slope,Fault2_slope,Fault3_slope,Fault4_slope];

%% ��������
%����1���ݵ�����
x1_curvature=zeros(1,len);
for i=1:len-1
    x1_curvature(i+1)=x1_slope(i+1)-x1_slope(i);
end
Fault1_curvature=reshape(x1_curvature,columns,rows);
%����2���ݵ�����
x2_curvature=zeros(1,len);
for i=1:len-1
    x2_curvature(i+1)=x2_slope(i+1)-x2_slope(i);
end
Fault2_curvature=reshape(x2_curvature,columns,rows);
%����3���ݵ�����
x3_curvature=zeros(1,len);
for i=1:len-1
    x3_curvature(i+1)=x3_slope(i+1)-x3_slope(i);
end
Fault3_curvature=reshape(x3_curvature,columns,rows);
%����4���ݵ�����
x4_curvature=zeros(1,len);
for i=1:len-1
    x4_curvature(i+1)=x4_slope(i+1)-x4_slope(i);
end
Fault4_curvature=reshape(x4_curvature,columns,rows);
trainData_curvature=[Fault1_curvature,Fault2_curvature,Fault3_curvature,Fault4_curvature];
%% �������
trainData=[trainData_original;trainData_slope;trainData_curvature];
save trainData trainData
%% ѵ�����ݱ�ǩ
trainLabel=[ones(1,rows),repmat(2,1,rows),repmat(3,1,rows),repmat(4,1,rows)]';
save trainLabel trainLabel
%% {***************************--testData--******************************%}
%% ԭʼ����
%����1
x1=2*sin(x)+ 0.4*rand(1,len);
Fault1=reshape(x1,columns,rows);
%����2
x2=2*sin(4*x)+ 0.4*rand(1,len);
Fault2=reshape(x2,columns,rows);
%����3
x3=3*sin(8*x)+ 0.4*rand(1,len);
Fault3=reshape(x3,columns,rows);
%����4
x4=2*sin(16*x)+ 0.4*rand(1,len);
Fault4=reshape(x4,columns,rows);
testData_original=[Fault1,Fault2,Fault3,Fault4];

%% б������
%����1���ݵ�б��
x1_slope=zeros(1,len);
for i=1:len-1
    x1_slope(i+1)=x1(i+1)-x1(i);
end
Fault1_slope=reshape(x1_slope,columns,rows);
%����2���ݵ�б��
x2_slope=zeros(1,len);
for i=1:len-1
    x2_slope(i+1)=x2(i+1)-x2(i);
end
Fault2_slope=reshape(x2_slope,columns,rows);
%����3���ݵ�б��
x3_slope=zeros(1,len);
for i=1:len-1
    x3_slope(i+1)=x3(i+1)-x3(i);
end
Fault3_slope=reshape(x3_slope,columns,rows);
%����4���ݵ�б��
x4_slope=zeros(1,len);
for i=1:len-1
    x4_slope(i+1)=x4(i+1)-x4(i);
end
Fault4_slope=reshape(x4_slope,columns,rows);
testData_slope=[Fault1_slope,Fault2_slope,Fault3_slope,Fault4_slope];

%% ��������
%����1���ݵ�����
x1_curvature=zeros(1,len);
for i=1:len-1
    x1_curvature(i+1)=x1_slope(i+1)-x1_slope(i);
end
Fault1_curvature=reshape(x1_curvature,columns,rows);
%����2���ݵ�����
x2_curvature=zeros(1,len);
for i=1:len-1
    x2_curvature(i+1)=x2_slope(i+1)-x2_slope(i);
end
Fault2_curvature=reshape(x2_curvature,columns,rows);
%����3���ݵ�����
x3_curvature=zeros(1,len);
for i=1:len-1
    x3_curvature(i+1)=x3_slope(i+1)-x3_slope(i);
end
Fault3_curvature=reshape(x3_curvature,columns,rows);
%����4���ݵ�����
x4_curvature=zeros(1,len);
for i=1:len-1
    x4_curvature(i+1)=x4_slope(i+1)-x4_slope(i);
end
Fault4_curvature=reshape(x4_curvature,columns,rows);
testData_curvature=[Fault1_curvature,Fault2_curvature,Fault3_curvature,Fault4_curvature];
testData=[testData_original;testData_slope;testData_curvature];
save testData testData
%% �������ݱ�ǩ
testLabel=[ones(1,rows),repmat(2,1,rows),repmat(3,1,rows),repmat(4,1,rows)]';
save testLabel testLabel