clc
clear all
close all
q0=[0.3 , 0.2 , 0.1, 0.1, 0.3];
q1=[0.24, 0.06, 0.1,0.1,0.3];
q2=[0.15,0.1,0.08,0.05,0.03];
q3=[0.18,0.16,0.07,0.1,0.3];
data=[q0;q1;q2;q3];
for i=1:4
    cos(i)=(q0(1)*data(i,1)+q0(2)*data(i,2)+q0(3)*data(i,3)+q0(4)*data(i,4)...
        +q0(5)*data(i,5))/(sqrt(sum(q0.^2))*sqrt(sum(data(i,:).^2)));
    average(i)=sum(data(i,:))/length(q0);
end
for i=1:3
    for j=1:5
    cos2(i,j)=1/(1+exp(-(data(i,j)-average(i+1))*(q0(j)-average(1))));
    end
    y(i)=cos(i+1)*sum(cos2(i+1))/abs(sum((data(i+1,:).*data(1,:))));
end
