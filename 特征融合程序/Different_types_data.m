clc
clear all
close all
Len=30;
xzb=6;%高斯白噪声的信噪比
x=0:0.1:Len;
%同频率不同幅值
n=input('1：同频率不同幅值，2：同幅值不同频率，3：不同幅值不同频率。请输入：');
switch (n)
    case 1
y1=6*sin(10*x);
y1=awgn(y1,xzb); %加性高斯白噪声，第二个参数为信噪比
plot(x,y1,'r');
hold on
y2=10*cos(10*x);
y2=awgn(y2,xzb); 
plot(x,y2,'b');
xlabel('sample time')
ylabel('awgn(10*cos(10*x),10)/awgn(6*sin(10*x),10)');
line([0,Len],[0,0],'color','k');
title('Same frequency with different amplitudes')
%同幅值不同频率
    case 2
y1=10*sin(4*x);
y1=awgn(y1,xzb); %加性高斯白噪声，第二个参数为信噪比
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
y1=awgn(y1,xzb); %加性高斯白噪声，第二个参数为信噪比
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