clc
close all
clear all
load IR007_0
load IR014_0
load IR021_0
load Normal_1
len=800;
columns=50;%列数
rows=len/columns;%行数4500/9=500
startl=1;
endl=70;
%故障1
x=X109_DE_time(1:len)';
x1=x(startl:endl);
plot(x1,'b')
hold on
%故障2
y=X173_DE_time(1:len)';
y1=y(startl:endl);
plot(y1,'r')
xlabel('sample time');
ylabel('signal value');
line([0,endl],[0,0],'color','k')
figure
plot(x,'b')
hold on
plot(y,'r')
xlabel('sample time');
ylabel('signal value');
