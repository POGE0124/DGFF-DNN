clc
close all
clear all
load IR007_0
load IR014_0
load IR021_0
load Normal_1
load IR021_3

%% 原始数据
%故障1
len=4500;
x1=X109_DE_time(1:len)';
x2=X213_DE_time(1:len)';
x3=X173_DE_time(1:len)';
x4=X098_DE_time(1:len)';

N=4500;

n =[1:N];
figure
X = fftshift(fft(x1,N));  
subplot(1,2,1)
plot(2*n/N,abs(X),'r'); 
title('fault1')
xlabel('frequency/Hz');
ylabel('amplitude');

X = fftshift(fft(x2,N));  
subplot(1,2,2)
plot(2*n/N,abs(X),'b'); 
title('fault2')
xlabel('frequency/Hz');
ylabel('amplitude');
% 
% X = fftshift(fft(x3,N));  
% subplot(1,2,1)
% plot(2*n/N,abs(X),'k'); 
% title('fault3')
% xlabel('frequency/Hz');
% ylabel('amplitude');
% 
% X = fftshift(fft(x4,N));  
% subplot(1,2,2)
% plot(2*n/N,abs(X),'g'); 
% title('Normal')
% xlabel('frequency/Hz');
% ylabel('amplitude');

figure
y=[x1,x2,x3,x4];

% plot(x1(1:len),'r')
% hold on
% plot(x2(1:len),'b')
% hold on 
plot(x3(1:len),'k')
hold on
plot(x4(1:len),'g')
xlabel('sample time')
ylabel('signal value')
