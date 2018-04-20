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
trainData=[Fault1,Fault2,Fault3,Fault4];
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
testData=[Fault1,Fault2,Fault3,Fault4];
save testData testData
%% �������ݱ�ǩ
testLabel=[ones(1,rows),repmat(2,1,rows),repmat(3,1,rows),repmat(4,1,rows)]';
save testLabel testLabel