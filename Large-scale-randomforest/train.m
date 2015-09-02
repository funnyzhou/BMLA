function train(varargin)
%TRAIN 此处显示有关此函数的摘要
%   此处显示详细说明
%--------------------------------------------------------------
%input说明
%D 训练样本
%m 最小样本数
%e 准确率
%d 当前深度
%maxd 最大深度
%S forest规模
%--------------------------------------------------------------
clearvars -except D;
disp 'input parameters are not sufficient, the program will be run under default settings'
m=3;e=0.01;maxd=+inf;S=20;d=1;
D=csvread('train.csv');
Dt=csvread('test.csv');
dimD=size(D);
dimDt=size(Dt);
% D(:,1:dimD(2)-1)=D(:,1:dimD(2)-1)-repmat(mean(D(:,1:dimD(2)-1)),dimD(1),1);
% Dt(:,1:dimDt(2)-1)=Dt(:,1:dimDt(2)-1)-repmat(mean(Dt(:,1:dimDt(2)-1)),dimDt(1),1);
% D(:,1:dimD(2)-1)=D(:,1:dimD(2)-1)./repmat(std(D(:,1:dimD(2)-1),0,2),1,dimD(2)-1);
% Dt(:,1:dimDt(2)-1)=Dt(:,1:dimDt(2)-1)./repmat(std(Dt(:,1:dimDt(2)-1),0,2),1,dimDt(2)-1);
tree=cell(1,S);
%建立队列
tic
parfor i=1:S
    tree{i}=BuildTree(D,m,e,d,maxd);
end
toc

sum=0;
for j=1:dimDt(1)
    estimate=zeros(1,11);
    for i=1:S
        pred=TestTree(tree{i},Dt(j,1:dimDt(2)-1));
        if j==1291 && i==5
            disp 'here'
        end
        estimate(pred+1)=estimate(pred+1)+1;
    end
    %sprintf('%d,%d;',j,i)
    id=find(estimate==max(estimate));
    if (id(1)-1)==Dt(j,785)
        sum=sum+1;
    end
end
precision=sprintf('precision %0.5f',sum/dimDt(1))
end
