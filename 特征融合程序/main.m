%function   :main() 
%Author    ������
%Versions  ��V1.0
%Last date  :2018��1��8��
%% ********** STEP 1  Load trainData and testData *****************
clc
close all
clear all
tic % ��ʼ��ʱ
load trainData_original
load trainData_slope
load trainData_curvature
load trainLabel
len=length(trainLabel);
load testData_original
load testData_slope
load testData_curvature
load testLabel
disp('�������� OK');
tData{1}=trainData_original;
tData{2}=trainData_slope;
tData{3}=trainData_curvature;
cData{1}=testData_original;
cData{2}=testData_slope;
cData{3}=testData_curvature;
%% ********** STEP 2  ���������ʼ�� *******************************
%Set Parameter of AutoEncoder
hidden.num1=10;%��һ������Ԫ����
hidden.num2=20;%�ڶ�������Ԫ����
hidden.num3=10;%����������Ԫ����
hidden.trainEpochs=50;%AE��������
hidden.trainMc=0.05;%��������(ȱʡ0.9)
hidden.learnRate=0.1-0.01;%AEѧϰ�ʣ���Χ����0��1����
numClasses=4;%length(a);%�����
%% ********** STEP 3  ��ѡ�����߽�ģ������Ԥ�� ********************** 
n=input('��ѡ��1�����߽�ģ��or 2������Ԥ�⣩:');
switch n
    case 1
disp('���߽�ģ......'); 
%% ********** STEP 4  ѵ���Զ����������� ***************************
parameter =cell(3,1);
for i=1:3   %ԭʼб������
    trainData=tData{i};
%%%%%%%%%%%�����Զ��������ĵ�һ����%%%%%%%%%%%%%%%%%%%%
net1=feedforwardnet(hidden.num1);%������һ��������
         net1.name = 'Autoencoder';
         net1.layers{1}.name = 'Encoder'; 
         net1.layers{2}.name = 'Decoder';
         net1.layers{1}.initFcn = 'initwb';
         net1.layers{2}.initFcn = 'initwb';
         net1.inputWeights{1,1}.initFcn = 'rands';
         net1.inputWeights{2,1}.initFcn = 'rands'; 
         net1.biases{1}.initFcn='initzero';
         net1.biases{2}.initFcn='initzero';
         net1.initFcn = 'initlay';  
         net1.performFcn='mse';
         net1.trainFcn='traingdm';%���������ݶ��½�
         net1.layers{1}.transferFcn='tansig';
         net1.layers{2}.transferFcn='tansig';
         net1.trainParam.epochs=hidden.trainEpochs; %ѵ������
         net1.trainParam.mc=hidden.trainMc; %��������
         net1.trainParam.lr=hidden.learnRate;%ѧϰ��
net1=init(net1);   %��ʼ������
[net1]=train(net1,trainData,trainData); %ѵ������  
%��ȡ��һ��������
options.w1=net1.iw{1,1}; % ֻҪ���������Ȩֵ����
options.b1=net1.b{1};      % ƫ�õ��ڣ�hidden_num1*1��
a1=options.w1*trainData+options.b1*ones(1,size(trainData,2));
feature1=tansig(a1);  %��˫�����м�����õ���һ���������
disp('ѵ��ԭʼ���ݵ�һ����  OK'); 
%%%%%%%%%%%�����Զ��������ĵڶ�����%%%%%%%%%%%%%%%%%%%%
net2=feedforwardnet(hidden.num2);       
             net2.name = 'Autoencoder';
             net2.layers{1}.name = 'Encoder';
             net2.layers{2}.name = 'Decoder';
             net2.layers{1}.initFcn = 'initwb';
             net2.layers{2}.initFcn = 'initwb';
             net2.inputWeights{1,1}.initFcn = 'rands';
             net2.inputWeights{2,1}.initFcn = 'rands';
             net2.biases{1}.initFcn='initzero';
             net2.biases{2}.initFcn='initzero';
             net2.initFcn = 'initlay';
             net2.performFcn='mse';
             net2.trainFcn='traingdm';       
             net2.layers{1}.transferFcn='tansig';
             net2.layers{2}.transferFcn='tansig';
             net2.trainParam.epochs=hidden.trainEpochs;
             net2.trainParam.mc=hidden.trainMc; 
             net2.trainParam.lr=hidden.learnRate;
net2=init(net2);
net2=train(net2,feature1,feature1);
%��ȡ�ڶ���������
options.w2=net2.iw{1,1};
options.b2=net2.b{1};  
a2=options.w2*feature1+options.b2*ones(1,size(trainData,2));
feature2=tansig(a2);
disp('ѵ��ԭʼ���ݵڶ�����  OK'); 
%%%%%%%%%%%�����Զ��������ĵ�������%%%%%%%%%%%%%%%%%%%%
net3=feedforwardnet(hidden.num3);
        net3.name = 'Autoencoder';
        net3.layers{1}.name = 'Encoder';
        net3.layers{2}.name = 'Decoder';
        net3.layers{1}.initFcn = 'initwb';
        net3.layers{2}.initFcn = 'initwb';
        net3.inputWeights{1,1}.initFcn = 'rands';
        net3.inputWeights{2,1}.initFcn = 'rands';
        net3.biases{1}.initFcn='initzero';    
        net3.biases{2}.initFcn='initzero';
        net3.initFcn = 'initlay';
        net3.performFcn='mse';
        net3.trainFcn='traingdm'; 
        net3.layers{1}.transferFcn='tansig';
        net3.layers{2}.transferFcn='tansig';
        net3.trainParam.epochs=hidden.trainEpochs;
        net3.trainParam.mc=hidden.trainMc; 
        net3.trainParam.lr=hidden.learnRate;
net3=init(net3);
net3=train(net3,feature2,feature2);
%��ȡ������������
options.w3=net3.iw{1,1};
options.b3=net3.b{1};
a3=options.w3*feature2+options.b3*ones(1,size(trainData,2));
options.feature3=tansig(a3);
disp('ѵ��ԭʼ���ݵ�������  OK'); 
temp1=options.feature3;
[corrcoef1 score1 lamda1]=princomp(temp1');
figure
plot3(score1(1:len/4,1),score1(1:len/4,2),score1(1:len/4,3),'r.');
hold on
plot3(score1(len/4+1:len/2,1),score1(len/4+1:len/2,2),score1(len/4+1:len/2,3),'g.')
hold on
plot3(score1(len/2+1:len*3/4,1),score1(len/2+1:len*3/4,2),score1(len/2+1:len*3/4,3),'k.')
hold on
plot3(score1(len*3/4+1:len,1),score1(len*3/4+1:len,2),score1(len*3/4+1:len,3),'m.')
title('������');
xlabel('the first PC');
ylabel('the second PC');
zlabel('the third PC');

%% ********** STEP 5  ��softmaxģ��ѵ�����õ�ģ�Ͳ��� ***************
sae3Features=options.feature3;%�����������
softlambda = 1e-2; %Ȩֵ�½����� ÿһ�ε������²���ʱ�õ�
softoptions.maxIter = 100;%����������
softmaxModel = softmaxTrain(hidden.num3, numClasses, softlambda, ...
                            sae3Features, trainLabel, softoptions);
saeSoftmaxOptTheta = softmaxModel.optTheta(:);
%% ********** STEP 6   fine -tune΢������ģ�Ͳ��� ******************
% ���Զ�������ѧϰ���Ĳ����ѵ�������softmax����һ���������΢��
stack = cell(3,1);%3x1��Ԫ������
stack{1}.w=options.w1;
stack{2}.w=options.w2;
stack{3}.w=options.w3;
stack{1}.b=options.b1;
stack{2}.b=options.b2;
stack{3}.b=options.b3;
[stackparams, netconfig] = stack2params(stack);
stackedAETheta = [  saeSoftmaxOptTheta ; stackparams ];
%��С�����ۺ����Ĳ�������
lambda = 1e-3;       % Ȩֵ�½�����
options.Method = 'lbfgs'; %��ţ�������ڴ淨
options.alpha=0.05;      %ѧϰ��
options.maxIter =100;	%����������
%��С���ۺ���minFunc�������в���
[stackedAEOptTheta, ~] =  minFunc(@(p)stackedAECost(p,size(trainData,2),hidden.num3,...
                         numClasses, netconfig,lambda,trainData,trainLabel),...
                        stackedAETheta,options);
disp('ģ�Ͳ���΢��  OK');
parameter{i}=stackedAEOptTheta;
end
save parameter parameter
%% ********** STEP 7   �����ں� ******************
featureFusion =cell(3,1);
softmaxPara =cell(3,1);
for i=1:3
    data=tData{i};
    softmaxTheta = reshape(parameter{i}(1:hidden.num3*numClasses), numClasses, hidden.num3);
    softmaxPara{i}=softmaxTheta;
    % ��ȡѵ���õĲ���
    stack = params2stack(parameter{i}(hidden.num3*numClasses+1:end), netconfig);
    % ��������
    depth = numel(stack);
    z = cell(depth+1,1);
    a = cell(depth+1, 1);
    a{1} = data;
    for layer = (1:depth)
        z{layer+1} = bsxfun(@plus,stack{layer}.w * a{layer}, stack{layer}.b);%���bsxfun(@plus,)
        a{layer+1} = 1 ./ (1 + exp(-z{layer+1}));
    end
    featureFusion{i}=a{depth+1};
end
%% ********** STEP 8  ���ѵ�����ݷ��ྫ�� ********************************
probability=softmaxPara{1}*featureFusion{1}+softmaxPara{2}*featureFusion{2}+softmaxPara{3}*featureFusion{3};
[~, PredTrainOriginal] = max(probability);
accTrainOriginal = mean(trainLabel(:) == PredTrainOriginal(:));
fprintf('ѵ�����ݷ�����ȷ��: %0.2f%%\n', accTrainOriginal * 100);
%% ********** STEP 9   ����Ԥ�� ******************
    case 2
        disp('����Ԥ��......'); 
        load netconfig
        load parameter
        featureFusion =cell(3,1);
        softmaxPara =cell(3,1);
        for i=1:3
            data=cData{i};
            softmaxTheta = reshape(parameter{i}(1:hidden.num3*numClasses), numClasses, hidden.num3);
            softmaxPara{i}=softmaxTheta;
            % ��ȡѵ���õĲ���
            stack = params2stack(parameter{i}(hidden.num3*numClasses+1:end), netconfig);
            % ��������
            depth = numel(stack);
            z = cell(depth+1,1);
            a = cell(depth+1, 1);
            a{1} = data;
        for layer = (1:depth)
            z{layer+1} = bsxfun(@plus,stack{layer}.w * a{layer}, stack{layer}.b);%���bsxfun(@plus,)
            a{layer+1} = 1 ./ (1 + exp(-z{layer+1}));
        end
            featureFusion{i}=a{depth+1};
        end
        probability=softmaxPara{1}*featureFusion{1}+softmaxPara{2}*featureFusion{2}+...
            softmaxPara{3}*featureFusion{3};
        [~, PredTestOriginal] = max(probability);
        accTestOriginal = mean(testLabel(:) == PredTestOriginal(:));
        fprintf('�������ݷ�����ȷ��: %0.2f%%\n',accTestOriginal * 100);
end%switch��end

% %% step 7 ������Ϣ���
% %����������ʱ��
% T=toc;
% fprintf('����������ʱ��: %dh��%dmin, %ds\n',fix(T/3600),fix(mod(T,3600)/60),...
%     fix(mod(mod(T,3600),60)));
% dt=fix(clock);
% %ִ��ʱ�����
% fprintf('ʱ���¼��%d�� %d�� %d�� %dʱ %d�� %d��\n',dt(1),dt(2),dt(3),dt(4),dt(5),dt(6)); 
% %�����õĲ��������շ��������Excel�б���
% fprintf('���ڱ�������......\n');
% sgc_exist = exist('DNNresult.xls', 'file');
% if sgc_exist==0
%     c=2;
%     save c c
% else 
%     load c
%     c=c+1;
%     save c c 
% end
% d = {'����γ��','������', '����1��Ԫ��','����2��Ԫ��','����3��Ԫ��',...
%     'AEѧϰ��','��������','ѵ�����ݷ�����','�������ݷ�����','������ʱ��(����)'};
% xlswrite('DNNresult.xls', d, 'result', 'A1');
% xlswrite('DNNresult.xls', size(trainData,2),'result', strcat('A',num2str(c)));
% xlswrite('DNNresult.xls', size(trainData,1), 'result', strcat('B',num2str(c)));
% xlswrite('DNNresult.xls', hidden.num1, 'result', strcat('C',num2str(c)));
% xlswrite('DNNresult.xls', hidden.num2, 'result', strcat('D',num2str(c)));
% xlswrite('DNNresult.xls', hidden.num3, 'result', strcat('E',num2str(c)));
% xlswrite('DNNresult.xls', hidden.learnRate, 'result', strcat('F',num2str(c)));
% xlswrite('DNNresult.xls', hidden.trainEpochs, 'result', strcat('G',num2str(c)));
% xlswrite('DNNresult.xls', accTrainOriginal * 100, 'result', strcat('H',num2str(c)));
% xlswrite('DNNresult.xls', accTestOriginal * 100, 'result', strcat('I',num2str(c)));
% xlswrite('DNNresult.xls', fix(T/3600)*60+fix(mod(T,3600)/60), 'result', strcat('J',num2str(c)));
% fprintf('ѵ�����ݷ�����ȷ��: %0.2f%%\n', accTrainOriginal * 100);
% fprintf('�������ݷ�����ȷ��: %0.2f%%\n', accTestOriginal * 100);
% fprintf('�����������');