function Add_Original_Data43() %�������
clc
close all
clear all
xzb=0.1;%��˹�������������
x=0.01:0.01*pi:45*pi;
len=length(x);
columns=9;%����
rows=len/columns;%����4500/9=500
%% {***************************--trainData--******************************%}
%% ԭʼ����
%����1
% y1=6*sin(10*x);
% y1=10*sin(2*x);
y1=5*sin(5*x);
x1=awgn(y1,xzb);
Fault1=reshape(x1,columns,rows);
%����2
% y2=10*cos(10*x);
% y2=10*cos(8*x);
y2=10*cos(10*x);
x2=awgn(y2,xzb); 
Fault2=reshape(x2,columns,rows);
trainData_original=[Fault1,Fault2];
save trainData_original trainData_original
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

trainData_slope=[Fault1_slope,Fault2_slope];
save trainData_slope trainData_slope
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
trainData_curvature=[Fault1_curvature,Fault2_curvature];
save trainData_curvature trainData_curvature
%% ѵ�����ݱ�ǩ
trainLabel=[ones(1,rows),repmat(2,1,rows)]';
save trainLabel trainLabel
%% {***************************--testData--******************************%}
%% ԭʼ����
%����1
%����1
% y1=6*sin(10*x);
% y1=10*sin(2*x);
y1=5*sin(5*x);
x1=awgn(y1,xzb);
Fault1=reshape(x1,columns,rows);
%����2
% y2=10*cos(10*x);
% y2=10*cos(8*x);
y2=10*cos(10*x);
x2=awgn(y2,xzb); 
Fault2=reshape(x2,columns,rows);
testData_original43=[Fault1,Fault2];
save testData_original43 testData_original43
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
testData_slope43=[Fault1_slope,Fault2_slope];
save testData_slope43 testData_slope43
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


testData_curvature43=[Fault1_curvature,Fault2_curvature];
save testData_curvature43 testData_curvature43
%% �������ݱ�ǩ
testLabel=[ones(1,rows),repmat(2,1,rows)]';
save testLabel testLabel