%function   :main() 
%Author    ：胡坡
%Versions  ：V1.0
%Last date  :2017年6月8号
%% STEP 1  Load trainData and testData%%%%%%% 
clc
close all
clear all
tic % 开始计时
load trainData
load trainLabel
load testData
load testLabel
disp('加载数据 OK'); 
%% STEP 2  原始数据通过堆叠自动编码器进行特征抽取%%%%%%%
%Set Parameter of AutoEncoder
hidden.num1=10;%第一隐层神经元个数
hidden.num2=20;%第二隐层神经元个数
hidden.num3=10;%第三隐层神经元个数
hidden.trainEpochs=50;%AE迭代次数
hidden.trainMc=0.05;%动量因子(缺省0.9)
hidden.learnRate=0.1-0.01;%AE学习率（范围：（0，1））
numClasses=4;%类别数
%% 请选择离线建模和在线预测
n=input('请选择1（离线建模）or 2（在线预测）:');
switch n
    case 1
disp('离线建模......'); 
%创建自动编码器的第一隐层
net1=feedforwardnet(hidden.num1);%建立第一隐层网络
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
         net1.trainFcn='traingdm';%带动量的梯度下降
         net1.layers{1}.transferFcn='tansig';
         net1.layers{2}.transferFcn='tansig';
         net1.trainParam.epochs=hidden.trainEpochs; %训练次数
         net1.trainParam.mc=hidden.trainMc; %动量因子
         net1.trainParam.lr=hidden.learnRate;%学习率
net1=init(net1);   %初始化网络
[net1]=train(net1,trainData,trainData); %训练网络  
%提取第一隐层特征
options.w1=net1.iw{1,1}; % 只要编码网络的权值即可
options.b1=net1.b{1};      % 偏置等于（hidden_num1*1）
a1=options.w1*trainData+options.b1*ones(1,size(trainData,2));
feature1=tansig(a1);  %用双曲正切激活函数得到第一隐层的特征
disp('训练第一隐层  OK'); 

%创建自动编码器的第二隐层
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
%提取第二隐层特征
options.w2=net2.iw{1,1};
options.b2=net2.b{1};  
a2=options.w2*feature1+options.b2*ones(1,size(trainData,2));
feature2=tansig(a2);
disp('训练第二隐层  OK'); 

%创建自动编码器的第三隐层
net3=feedforwardnet(hidden.num3);
        net3.name = 'Autoencoder';
        net3.layers{1}.name = 'Encoder';
        net3.layers{2}.name = 'Decoder';
        net3.layers{1}.initFcn = 'initwb';
        net3.layers{2}.initFcn = 'initwb';
        net3.inputWeights{1,1}.initFcn = 'rands';
        net3.inputWeights{2,1}.initFcn = 'rands';
        net3.biases{1}.initFcn='initzero';    
        net3.biases{2}.initFcn='initzero' ;
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
%提取第三隐层特征
options.w3=net3.iw{1,1};
options.b3=net3.b{1};
a3=options.w3*feature2+options.b3*ones(1,size(trainData,2));
options.feature3=tansig(a3);
disp('训练第三隐层  OK'); 
%% 特征可视化
F11=options.feature3';
[corrcoef1,score1,lamda1]=princomp(F11);
figure
plot3(score1(1:500,1),score1(1:500,2),score1(1:500,3),'r.');
hold on
plot3(score1(501:1000,1),score1(501:1000,2),score1(501:1000,3),'g.')
hold on
plot3(score1(1001:1500,1),score1(1001:1500,2),score1(1001:1500,3),'k.')
hold on
plot3(score1(1501:2000,1),score1(1501:2000,2),score1(1501:2000,3),'m.')
xlabel('the first PC');
ylabel('the second PC');
zlabel('the third PC');
%% STEP 3 对softmax模型训练，得到模型参数%%%%%%%%%%%%%%%%%%
sae3Features=options.feature3;%第三层的特征
softlambda = 1e-2; %权值下降参数 每一次迭代更新参数时用到
softoptions.maxIter = 100;%最大迭代次数
softmaxModel = softmaxTrain(hidden.num3, numClasses, softlambda, ...
                            sae3Features, trainLabel, softoptions);
saeSoftmaxOptTheta = softmaxModel.optTheta(:);
disp('softmax层训练  OK'); 

%%  STEP 4 fine -tune微调所有模型参数  %%%%%%%%%%%%%%%%%%%%%%%
% 将自动编码器学习到的参数堆叠起来和softmax参数一起整体进行微调
stack = cell(3,1);%3x1的元胞数组
stack{1}.w=options.w1;
stack{2}.w=options.w2;
stack{3}.w=options.w3;
stack{1}.b=options.b1;
stack{2}.b=options.b2;
stack{3}.b=options.b3;
[stackparams, netconfig] = stack2params(stack);
stackedAETheta = [  saeSoftmaxOptTheta ; stackparams ];
%最小化代价函数的参数设置
lambda = 1e-3;       % 权值下降参数
options.Method = 'lbfgs'; %拟牛顿限制内存法
options.alpha=0.05;      %学习率
options.maxIter =100;	%最大迭代次数
%最小代价函数minFunc调整所有参数
[stackedAEOptTheta, ~] =  minFunc(@(p)stackedAECost(p,size(trainData,2),hidden.num3,...
                         numClasses, netconfig,lambda,trainData,trainLabel),...
                        stackedAETheta,options);
disp('模型参数微调  OK'); 

%% STEP 5: 输出训练数据分类精度
[PredTrainOriginal,~] = stackedAEPredict(stackedAEOptTheta, size(trainData,2), hidden.num3, ...
                          numClasses, netconfig, trainData);
accTrainOriginal = mean(trainLabel(:) == PredTrainOriginal(:));
fprintf('训练数据分类正确率: %0.2f%%\n', accTrainOriginal * 100);
save netconfig netconfig
save stackedAEOptTheta stackedAEOptTheta
    case 2
        disp('在线预测......'); 
%% STEP 6: 输出测试数据分类精度
load netconfig
load stackedAEOptTheta
[PredTestOriginal,~] = stackedAEPredict(stackedAEOptTheta, size(testData,2), hidden.num3, ...
                          numClasses, netconfig, testData);
accTestOriginal = mean(testLabel(:) == PredTestOriginal(:));
fprintf('测试数据分类正确率: %0.2f%%\n',accTestOriginal * 100);
end %switch的end
