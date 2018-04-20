 clc;
clear all;
tic
% path='C:\Users\Administrator\Desktop\0926\0926\Data';
% files=dir(fullfile(path,'*.mat'));
% for i=1:length(files)
%     load(fullfile(path,files(i).name));
% end

%%%%%%%%% 在数据表示中 IR_xy ;OR_xy ;B_xy中IR代表内圈，OR代表外圈，B代表钢珠；
%%%%%%%%% x代表故障尺寸（0代表0.007',1代表0.014'，2代表0.021'）;
%%%%%%%%% y 代表载荷情况（0,1,2,3分别表示载荷为0hp，1hp, 2hp, 3hp）

for i=1:100
    j=1200*i;
IR_00(i,:) =X105_DE_time(1200*(i-1)+1:1200*i);
IR_10(i,:) =X169_DE_time(1200*(i-1)+1:1200*i); 
IR_20(i,:) =X209_DE_time(1200*(i-1)+1:1200*i);
OR_00(i,:) =X130_DE_time(1200*(i-1)+1:1200*i);
OR_10(i,:) =X197_DE_time(1200*(i-1)+1:1200*i);
OR_20(i,:) =X234_DE_time(1200*(i-1)+1:1200*i);
B_00(i,:) =X118_DE_time(1200*(i-1)+1:1200*i);
B_10(i,:) =X185_DE_time(1200*(i-1)+1:1200*i);
B_20(i,:) =X222_DE_time(1200*(i-1)+1:1200*i);
N_00(i,:) =X097_DE_time(1200*(i-1)+1:1200*i); %载荷为0

IR_01(i,:) =X106_DE_time(1200*(i-1)+1:1200*i);
IR_11(i,:) =X170_DE_time(1200*(i-1)+1:1200*i);
IR_21(i,:) =X210_DE_time(1200*(i-1)+1:1200*i);
OR_01(i,:) =X131_DE_time(1200*(i-1)+1:1200*i);
OR_11(i,:) =X198_DE_time(1200*(i-1)+1:1200*i);
OR_21(i,:) =X235_DE_time(1200*(i-1)+1:1200*i);
B_01(i,:) =X119_DE_time(1200*(i-1)+1:1200*i);
B_11(i,:) =X186_DE_time(1200*(i-1)+1:1200*i);
B_21(i,:) =X223_DE_time(1200*(i-1)+1:1200*i);
N_01(i,:) =X098_DE_time(1200*(i-1)+1:1200*i); %载荷为1

IR_02(i,:) =X107_DE_time(1200*(i-1)+1:1200*i);
IR_12(i,:) =X171_DE_time(1200*(i-1)+1:1200*i);
IR_22(i,:) =X211_DE_time(1200*(i-1)+1:1200*i);
OR_02(i,:) =X132_DE_time(1200*(i-1)+1:1200*i);
OR_12(i,:) =X199_DE_time(1200*(i-1)+1:1200*i);
OR_22(i,:) =X236_DE_time(1200*(i-1)+1:1200*i);
B_02(i,:) =X120_DE_time(1200*(i-1)+1:1200*i);
B_12(i,:) =X187_DE_time(1200*(i-1)+1:1200*i);
B_22(i,:) =X224_DE_time(1200*(i-1)+1:1200*i);
N_02(i,:) =X099_DE_time(1200*(i-1)+1:1200*i); %载荷为2


IR_03(i,:) =X108_DE_time(1200*(i-1)+1:1200*i); 
IR_13(i,:) =X172_DE_time(1200*(i-1)+1:1200*i);  
IR_23(i,:) =X212_DE_time(1200*(i-1)+1:1200*i); 
OR_03(i,:) =X133_DE_time(1200*(i-1)+1:1200*i); 
OR_13(i,:) =X200_DE_time(1200*(i-1)+1:1200*i);
OR_23(i,:) =X237_DE_time(1200*(i-1)+1:1200*i); 
B_03(i,:) =X121_DE_time(1200*(i-1)+1:1200*i); 
B_13(i,:) =X188_DE_time(1200*(i-1)+1:1200*i); 
B_23(i,:) =X225_DE_time(1200*(i-1)+1:1200*i); 
N_03(i,:) =X100_DE_time(1200*(i-1)+1:1200*i); %载荷为3
end
X1=[IR_00; IR_10; IR_20; OR_00; OR_10; OR_20; B_00; B_10; B_20; N_00 ];%载荷为0
X2=[IR_01; IR_11; IR_21; OR_01; OR_11; OR_21; B_01; B_11; B_21; N_01 ];%%载荷为1
X3=[IR_02; IR_12; IR_22; OR_02; OR_12; OR_22; B_02; B_12; B_22; N_02 ];%载荷为2
X4=[IR_03; IR_13; IR_23; OR_03; OR_13; OR_23; B_03; B_13; B_23; N_03 ]; %载荷为3
N=1200;
fs=12000;
n=0:N-1;
t=n/fs;
f1=n*fs/N;
for i=1:1000
Y10(i,:)=fft(X1(i,:),N);
Y20(i,:)=fft(X2(i,:),N);
Y30(i,:)=fft(X3(i,:),N);
Y40(i,:)=fft(X4(i,:),N);
end

Y11=abs(Y10)/N;
Y21=abs(Y20)/N;
Y31=abs(Y30)/N;
Y41=abs(Y40)/N;
figure 
subplot(2,2,1);plot(f1,Y11);xlabel('频率/Hz');ylabel('振幅');title('N=1200');grid on;
subplot(2,2,2);plot(f1,Y21);xlabel('频率/Hz');ylabel('振幅');title('N=1200');grid on;
subplot(2,2,3);plot(f1,Y31);xlabel('频率/Hz');ylabel('振幅');title('N=1200');grid on;
subplot(2,2,4);plot(f1,Y41);xlabel('频率/Hz');ylabel('振幅');title('N=1200');grid on;
%%%取前600个作为样本系数
Y12=Y11(:,1:600);
Y22=Y21(:,1:600);
Y32=Y31(:,1:600);
Y42=Y41(:,1:600);
f2=f1(1:600);
figure 
subplot(2,2,1);plot(f2,Y12);xlabel('频率/Hz');ylabel('振幅');title('N=600');grid on;
subplot(2,2,2);plot(f2,Y22);xlabel('频率/Hz');ylabel('振幅');title('N=600');grid on;
subplot(2,2,3);plot(f2,Y32);xlabel('频率/Hz');ylabel('振幅');title('N=600');grid on;
subplot(2,2,4);plot(f2,Y42);xlabel('频率/Hz');ylabel('振幅');title('N=600');grid on;

data=[Y12;Y22;Y32;Y42]; %4000*600
%%% 数据的一半用来训练，一半用来测试
data1=data(1:2:end,:);   %训练数据
data2=data(2:2:end,:);    %测试数据


Z=500;
trainData1=data1'; 
testData1=data2';
% testData1=trainData1;
trainLabels1=[repmat(1,1,Z)';repmat(2,1,Z)';repmat(3,1,Z)';repmat(4,1,Z)']; %故障位置标签
testLabels1 =trainLabels1;

[feature1 ,cost1,acc1,acc2,pred1,pred2]=dnn1(trainData1,testData1,trainLabels1,testLabels1);
F11=feature1';
[corrcoef1 score1 lamda1]=princomp(F11);
figure
plot3(score1(1:500,1),score1(1:500,2),score1(1:500,3),'r.');
hold on
plot3(score1(501:1000,1),score1(501:1000,2),score1(501:1000,3),'g.')
hold on
plot3(score1(1001:1500,1),score1(1001:1500,2),score1(1001:1500,3),'k.')
hold on
plot3(score1(1501:2000,1),score1(1501:2000,2),score1(1501:2000,3),'m.')
title('高育林');
xlabel('the first PC');
ylabel('the second PC');
zlabel('the third PC');
toc 
%%%%%%





