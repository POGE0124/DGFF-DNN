function Add_Original_Data() %ÃÌº” ˝æ›
clc
clear all
close all
x=0.01:0.01*pi:20*pi;
len=length(x);
%’˝≥£
s1=2;
s2=3;
s3=4;
y0=s1*sin(x)+randn(1,len);
y1=s2*cos(x)+randn(1,len);
y2=s3*sin(x)+randn(1,len);
y3=s1*cos(x)+sin(x)+randn(1,len);
y4=s2*sin(x)+cos(x)+randn(1,len);
y5=s3*cos(x)+sin(x)+randn(1,len);
y6=s1*sin(x)+cos(x)+randn(1,len);
y7=s2*sin(x)+cos(x)+randn(1,len);
y8=s3*cos(x)+sin(x)+randn(1,len);
Normal=[y0;y1;y2;y3;y4;y5;y6;y7;y8;];
%π ’œ1
s1=exp(x);
s2=3;
s3=4;
y0=s1.*sin(x)+randn(1,len);
y1=s2*cos(x)+randn(1,len);
y2=s3*sin(x)+randn(1,len);
y3=s1.*cos(x)+sin(x)+randn(1,len);
y4=s2*sin(x)+cos(x)+randn(1,len);
y5=s3*cos(x)+sin(x)+randn(1,len);
y6=s1.*sin(x)+cos(x)+randn(1,len);
y7=s2*sin(x)+cos(x)+randn(1,len);
y8=s3*cos(x)+sin(x)+randn(1,len);
Fault1=[y0;y1;y2;y3;y4;y5;y6;y7;y8;];
%π ’œ2
s1=2;
s2=exp(x);
s3=4;
y0=s1.*sin(x)+randn(1,len);
y1=s2.*cos(x)+randn(1,len);
y2=s3*sin(x)+randn(1,len);
y3=s1.*cos(x)+sin(x)+randn(1,len);
y4=s2.*sin(x)+cos(x)+randn(1,len);
y5=s3*cos(x)+sin(x)+randn(1,len);
y6=s1.*sin(x)+cos(x)+randn(1,len);
y7=s2.*sin(x)+cos(x)+randn(1,len);
y8=s3*cos(x)+sin(x)+randn(1,len);
Fault2=[y0;y1;y2;y3;y4;y5;y6;y7;y8;];
%π ’œ2
s1=2;
s2=3;
s3=exp(x);
y0=s1.*sin(x)+randn(1,len);
y1=s2.*cos(x)+randn(1,len);
y2=s3.*sin(x)+randn(1,len);
y3=s1.*cos(x)+sin(x)+randn(1,len);
y4=s2.*sin(x)+cos(x)+randn(1,len);
y5=s3.*cos(x)+sin(x)+randn(1,len);
y6=s1.*sin(x)+cos(x)+randn(1,len);
y7=s2.*sin(x)+cos(x)+randn(1,len);
y8=s3.*cos(x)+sin(x)+randn(1,len);
Fault3=[y0;y1;y2;y3;y4;y5;y6;y7;y8;];
trainData=[Normal,Fault1,Fault2,Fault3];
save trainData trainData
trainLabel=[ones(1,len),repmat(2,1,len),repmat(3,1,len),repmat(4,1,len)]';
save trainLabel trainLabel
%testData
%’˝≥£
s1=2;
s2=3;
s3=4;
y0=s1*sin(x)+randn(1,len);
y1=s2*cos(x)+randn(1,len);
y2=s3*sin(x)+randn(1,len);
y3=s1*cos(x)+sin(x)+randn(1,len);
y4=s2*sin(x)+cos(x)+randn(1,len);
y5=s3*cos(x)+sin(x)+randn(1,len);
y6=s1*sin(x)+cos(x)+randn(1,len);
y7=s2*sin(x)+cos(x)+randn(1,len);
y8=s3*cos(x)+sin(x)+randn(1,len);
Normal=[y0;y1;y2;y3;y4;y5;y6;y7;y8;];
%π ’œ1
s1=exp(x);
s2=3;
s3=4;
y0=s1.*sin(x)+randn(1,len);
y1=s2*cos(x)+randn(1,len);
y2=s3*sin(x)+randn(1,len);
y3=s1.*cos(x)+sin(x)+randn(1,len);
y4=s2*sin(x)+cos(x)+randn(1,len);
y5=s3*cos(x)+sin(x)+randn(1,len);
y6=s1.*sin(x)+cos(x)+randn(1,len);
y7=s2*sin(x)+cos(x)+randn(1,len);
y8=s3*cos(x)+sin(x)+randn(1,len);
Fault1=[y0;y1;y2;y3;y4;y5;y6;y7;y8;];
%π ’œ2
s1=2;
s2=exp(x);
s3=4;
y0=s1.*sin(x)+randn(1,len);
y1=s2.*cos(x)+randn(1,len);
y2=s3*sin(x)+randn(1,len);
y3=s1.*cos(x)+sin(x)+randn(1,len);
y4=s2.*sin(x)+cos(x)+randn(1,len);
y5=s3*cos(x)+sin(x)+randn(1,len);
y6=s1.*sin(x)+cos(x)+randn(1,len);
y7=s2.*sin(x)+cos(x)+randn(1,len);
y8=s3*cos(x)+sin(x)+randn(1,len);
Fault2=[y0;y1;y2;y3;y4;y5;y6;y7;y8;];
%π ’œ2
s1=2;
s2=3;
s3=exp(x);
y0=s1.*sin(x)+randn(1,len);
y1=s2.*cos(x)+randn(1,len);
y2=s3.*sin(x)+randn(1,len);
y3=s1.*cos(x)+sin(x)+randn(1,len);
y4=s2.*sin(x)+cos(x)+randn(1,len);
y5=s3.*cos(x)+sin(x)+randn(1,len);
y6=s1.*sin(x)+cos(x)+randn(1,len);
y7=s2.*sin(x)+cos(x)+randn(1,len);
y8=s3.*cos(x)+sin(x)+randn(1,len);
Fault3=[y0;y1;y2;y3;y4;y5;y6;y7;y8;];
testData=[Normal,Fault1,Fault2,Fault3];
save testData testData
testLabel=[ones(1,len),repmat(2,1,len),repmat(3,1,len),repmat(4,1,len)]';
save testLabel testLabel