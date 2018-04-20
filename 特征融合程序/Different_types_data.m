clc
clear all
close all
Len=30;
xzb=6;%��˹�������������
x=0:0.1:Len;
%ͬƵ�ʲ�ͬ��ֵ
n=input('1��ͬƵ�ʲ�ͬ��ֵ��2��ͬ��ֵ��ͬƵ�ʣ�3����ͬ��ֵ��ͬƵ�ʡ������룺');
switch (n)
    case 1
y1=6*sin(10*x);
y1=awgn(y1,xzb); %���Ը�˹���������ڶ�������Ϊ�����
plot(x,y1,'r');
hold on
y2=10*cos(10*x);
y2=awgn(y2,xzb); 
plot(x,y2,'b');
xlabel('sample time')
ylabel('awgn(10*cos(10*x),10)/awgn(6*sin(10*x),10)');
line([0,Len],[0,0],'color','k');
title('Same frequency with different amplitudes')
%ͬ��ֵ��ͬƵ��
    case 2
y1=10*sin(4*x);
y1=awgn(y1,xzb); %���Ը�˹���������ڶ�������Ϊ�����
plot(x,y1,'r');
hold on
y2=10*cos(8*x);
y2=awgn(y2,xzb); 
plot(x,y2,'b');
xlabel('sample time')
ylabel('awgn(10*cos(8*x),10)/awgn(10*sin(4*x),10)');
line([0,Len],[0,0],'color','k');
title('Same amplitudes with different frequency')
    case 3
y1=5*sin(5*x);
y1=awgn(y1,xzb); %���Ը�˹���������ڶ�������Ϊ�����
plot(x,y1,'r');
hold on
y2=10*cos(10*x);
y2=awgn(y2,xzb); 
plot(x,y2,'b');
xlabel('sample time')
ylabel('awgn(10*cos(10*x),10)/5*awgn(sin(5*x),10)');
line([0,Len],[0,0],'color','k');
title('Different amplitudes with different frequency');
end