function Add_Original_Data3() %�������
clc
close all
clear all
% load IR007_0
% load IR014_0
% load IR021_0
% load Normal_1
load B007_0
load IR007_0
load OR007@3_0
load Normal_1
len=4500;
columns=9;%����
rows=len/columns;%����4500/9=500
%% {***************************--trainData--******************************%}
%% ԭʼ����
%����1
% x1=X109_DE_time(1:len)';
x1=X122_DE_time(1:len)';
subplot(2,2,1);
plot(x1,'r');
axis([0 4600 -inf inf]) %xmin��x��С��xmax��x���ymin��ymax����
xlabel('sample time')
ylabel('signal value')
title('fault 1')
Fault1=reshape(x1,columns,rows);
%����2
% x2=X213_DE_time(1:len)';
x2=X109_DE_time(1:len)';
subplot(2,2,2);
plot(x2,'b');
axis([0 4600 -inf inf]) %xmin��x��С��xmax��x���ymin��ymax����
xlabel('sample time')
ylabel('signal value')
title('fault 2')
Fault2=reshape(x2,columns,rows);
%����3
% x3=X173_DE_time(1:len)';
x3=X148_DE_time(1:len)';
subplot(2,2,3);
plot(x3,'k');
axis([0 4600 -inf inf]) %xmin��x��С��xmax��x���ymin��ymax����
xlabel('sample time')
ylabel('signal value')
title('fault 3')
Fault3=reshape(x3,columns,rows);
%����4
x4=X098_DE_time(1:len)';
subplot(2,2,4);
plot(x4,'g');
axis([0 4600 -inf inf]) %xmin��x��С��xmax��x���ymin��ymax����
xlabel('sample time')
ylabel('signal value')
title('Normal')
Fault4=reshape(x4,columns,rows);
trainData_original=[Fault1,Fault2,Fault3,Fault4];
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
save trainData_curvature trainData_curvature
%% ѵ�����ݱ�ǩ
trainLabel=[ones(1,rows),repmat(2,1,rows),repmat(3,1,rows),repmat(4,1,rows)]';
save trainLabel trainLabel
%% {***************************--testData--******************************%}
%% ԭʼ����
%����1
x1=X122_DE_time(4501:9000)';
Fault1=reshape(x1,columns,rows);
%����2
x2=X109_DE_time(len+1:len*2)';
Fault2=reshape(x2,columns,rows);
%����3
x3=X148_DE_time(len+1:len*2)';
Fault3=reshape(x3,columns,rows);
%����4
x4=X098_DE_time(len+1:len*2)';
Fault4=reshape(x4,columns,rows);
testData_original=[Fault1,Fault2,Fault3,Fault4];
save testData_original testData_original
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
save testData_slope testData_slope
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
save testData_curvature testData_curvature
%% �������ݱ�ǩ
testLabel=[ones(1,rows),repmat(2,1,rows),repmat(3,1,rows),repmat(4,1,rows)]';
save testLabel testLabel