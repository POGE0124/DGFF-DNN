%function   :main() 
%Author    ：胡坡
%Versions  ：V1.0
%Last date  :2018年1月8号
%% ********** STEP 1  Load trainData and testData *****************
clc
close all
clear all
tic % 开始计时
load trainData_original
load trainData_slope
load trainData_curvature
load trainLabel
len=length(trainLabel);
load testData_original
load testData_slope
load testData_curvature
load testLabel
disp('加载数据 OK');
tData{1}=trainData_original;
tData{2}=trainData_slope;
tData{3}=trainData_curvature;
cData{1}=testData_original;
cData{2}=testData_slope;
cData{3}=testData_curvature;
%% ********** STEP 2  网络参数初始化 *******************************
%Set Parameter of AutoEncoder
hidden.num1=10;%第一隐层神经元个数
hidden.num2=20;%第二隐层神经元个数
hidden.num3=10;%第三隐层神经元个数
hidden.trainEpochs=50;%AE迭代次数
hidden.trainMc=0.05;%动量因子(缺省0.9)
hidden.learnRate=0.1-0.01;%AE学习率（范围：（0，1））
numClasses=4;%length(a);%类别数
%% ********** STEP 3  请选择离线建模和在线预测 ********************** 
n=input('请选择1（离线建模）or 2（在线预测）:');
switch n
    case 1
disp('离线建模......'); 
%% ********** STEP 4  训练自动编码器网络 ***************************
parameter =cell(3,1);
for i=1:3   %原始斜率曲率
    trainData=tData{i};
%%%%%%%%%%%创建自动编码器的第一隐层%%%%%%%%%%%%%%%%%%%%
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
disp('训练原始数据第一隐层  OK'); 
%%%%%%%%%%%创建自动编码器的第二隐层%%%%%%%%%%%%%%%%%%%%
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
disp('训练原始数据第二隐层  OK'); 
%%%%%%%%%%%创建自动编码器的第三隐层%%%%%%%%%%%%%%%%%%%%
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
%提取第三隐层特征
options.w3=net3.iw{1,1};
options.b3=net3.b{1};
a3=options.w3*feature2+options.b3*ones(1,size(trainData,2));
options.feature3=tansig(a3);
disp('训练原始数据第三隐层  OK'); 
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
title('高育林');
xlabel('the first PC');
ylabel('the second PC');
zlabel('the third PC');

%% ********** STEP 5  对softmax模型训练，得到模型参数 ***************
sae3Features=options.feature3;%第三层的特征
softlambda = 1e-2; %权值下降参数 每一次迭代更新参数时用到
softoptions.maxIter = 100;%最大迭代次数
softmaxModel = softmaxTrain(hidden.num3, numClasses, softlambda, ...
                            sae3Features, trainLabel, softoptions);
saeSoftmaxOptTheta = softmaxModel.optTheta(:);
%% ********** STEP 6   fine -tune微调所有模型参数 ******************
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
parameter{i}=stackedAEOptTheta;
end
save parameter parameter
%% ********** STEP 7   特征融合 ******************
featureFusion =cell(3,1);
softmaxPara =cell(3,1);
for i=1:3
    data=tData{i};
    softmaxTheta = reshape(parameter{i}(1:hidden.num3*numClasses), numClasses, hidden.num3);
    softmaxPara{i}=softmaxTheta;
    % 抽取训练好的参数
    stack = params2stack(parameter{i}(hidden.num3*numClasses+1:end), netconfig);
    % 计算特征
    depth = numel(stack);
    z = cell(depth+1,1);
    a = cell(depth+1, 1);
    a{1} = data;
    for layer = (1:depth)
        z{layer+1} = bsxfun(@plus,stack{layer}.w * a{layer}, stack{layer}.b);%外加bsxfun(@plus,)
        a{layer+1} = 1 ./ (1 + exp(-z{layer+1}));
    end
    featureFusion{i}=a{depth+1};
end
%% ********** STEP 8  输出训练数据分类精度 ********************************
probability=softmaxPara{1}*featureFusion{1}+softmaxPara{2}*featureFusion{2}+softmaxPara{3}*featureFusion{3};
[~, PredTrainOriginal] = max(probability);
accTrainOriginal = mean(trainLabel(:) == PredTrainOriginal(:));
fprintf('训练数据分类正确率: %0.2f%%\n', accTrainOriginal * 100);
%% ********** STEP 9   在线预测 ******************
    case 2
        disp('在线预测......'); 
        load netconfig
        load parameter
        featureFusion =cell(3,1);
        softmaxPara =cell(3,1);
        for i=1:3
            data=cData{i};
            softmaxTheta = reshape(parameter{i}(1:hidden.num3*numClasses), numClasses, hidden.num3);
            softmaxPara{i}=softmaxTheta;
            % 抽取训练好的参数
            stack = params2stack(parameter{i}(hidden.num3*numClasses+1:end), netconfig);
            % 计算特征
            depth = numel(stack);
            z = cell(depth+1,1);
            a = cell(depth+1, 1);
            a{1} = data;
        for layer = (1:depth)
            z{layer+1} = bsxfun(@plus,stack{layer}.w * a{layer}, stack{layer}.b);%外加bsxfun(@plus,)
            a{layer+1} = 1 ./ (1 + exp(-z{layer+1}));
        end
            featureFusion{i}=a{depth+1};
        end
        probability=softmaxPara{1}*featureFusion{1}+softmaxPara{2}*featureFusion{2}+...
            softmaxPara{3}*featureFusion{3};
        [~, PredTestOriginal] = max(probability);
        accTestOriginal = mean(testLabel(:) == PredTestOriginal(:));
        fprintf('测试数据分类正确率: %0.2f%%\n',accTestOriginal * 100);
end%switch的end

% %% step 7 辅助信息输出
% %程序运行总时间
% T=toc;
% fprintf('程序运行总时间: %dh，%dmin, %ds\n',fix(T/3600),fix(mod(T,3600)/60),...
%     fix(mod(mod(T,3600),60)));
% dt=fix(clock);
% %执行时间输出
% fprintf('时间记录：%d年 %d月 %d日 %d时 %d分 %d秒\n',dt(1),dt(2),dt(3),dt(4),dt(5),dt(6)); 
% %将设置的参数和最终分类结果输出Excel中保存
% fprintf('正在保存数据......\n');
% sgc_exist = exist('DNNresult.xls', 'file');
% if sgc_exist==0
%     c=2;
%     save c c
% else 
%     load c
%     c=c+1;
%     save c c 
% end
% d = {'数据纬度','变量数', '隐层1神经元数','隐层2神经元数','隐层3神经元数',...
%     'AE学习率','迭代次数','训练数据分类率','测试数据分类率','总运行时间(分钟)'};
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
% fprintf('训练数据分类正确率: %0.2f%%\n', accTrainOriginal * 100);
% fprintf('测试数据分类正确率: %0.2f%%\n', accTestOriginal * 100);
% fprintf('程序运行完毕');