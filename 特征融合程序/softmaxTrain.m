%% softmaxTrain Train%%%%%%%%%%%%%%
%��������� inputSize: ����������С
% numClasses: ��������10��
% lambda: Ȩ���½�����1e-3; %Ȩֵ�½����� ÿһ�ε������²���ʱ�õ�
% inputData: �������ݣ�������������
% labels: ����ѵ������ �� ��ǩ
% options (optional): options
% options.maxIter: ѵ��ʱ�ĵ�������
%���������softmaxModel���ṹ�壩
function [softmaxModel] = softmaxTrain(inputSize, numClasses, lambda, inputData, labels, options)
%% exist('im', 'var')�Ǽ��im�еı����Ƿ���ڣ���������ڷ���0�����ڷ���1��
%~exist('im', 'var')�ǶԽ��ȡ������
if ~exist('options', 'var')%���������һ��options�Ľṹ����ִ��if����ľ���
    options = struct;%����һ���ṹ��options������֮ǰ����������������δִ�У�
end
%% ͨ������fieldnames����ȡ�ֶ����ƣ��ṹ����������ԣ�
%ͨ������isfield���ж��Ƿ����ĳһ�ֶ�
%����ṹ��options�д���maxIter���ԣ���Ϊ1����~ȡ������Ϊ0����ôif����ľ��Ӳ�ִ�С�
if ~isfield(options, 'maxIter')
    options.maxIter = 200;%ʵ��δִ��
end
%%  ��ʼ������%%%%%%%%%
theta = 0.005 * randn(numClasses * inputSize, 1);%�����ʼ������theta��1000x1��
%% ����С�����ۺ���minFuncȥѵ������
addpath minFunc/            %�����С���������ڵ��ļ��е�·��
%��ţ�������ڴ淨%���ݶ��½����õĶ�
%���ṹ��������Կ���ֱ��д������ɾ��Ҫ��Rmfield����
options.Method = 'lbfgs'; 
%����minFunc����ȥ��������Theta���������ص�softmaxOptTheta��1000x1
[softmaxOptTheta] = minFunc( @(p) softmaxCost(p,numClasses, inputSize, lambda,inputData, labels),theta, options);
% ������Theta�ĽṹΪ10x100
softmaxModel.optTheta = reshape(softmaxOptTheta, numClasses, inputSize);
softmaxModel.inputSize = inputSize;%100
softmaxModel.numClasses = numClasses;%10
end                          
