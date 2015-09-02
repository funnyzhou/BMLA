function [w,b]= Linear(D,e)
%LINEAR 此处显示有关此函数的摘要
%   此处显示详细说明
dim=size(D);
trainData=D(:,1:dim(2)-1);
trainLabel=D(:,dim(2));
%label=sort(trainLabel,'ascend');
%random choose one class
%cnum=floor(rand()*10);
cnum=intersect(trainLabel,trainLabel);
rdC=cnum(ceil(size(cnum,1)*rand()));
%two samples
index1=find(trainLabel==rdC);
index2=find(trainLabel~=rdC);
szId1=size(index1);
szId2=size(index2);
if numel(index2)==0 || numel(index1)==0
    disp 'id2'
end
pd=trainData((index1(ceil(szId1(2)*rand()))),:);
nd=trainData((index2(ceil(szId2(2)*rand()))),:);
w0=(pd-nd)/sqrt(sum((pd-nd).^2));
b0=(w0*pd'+w0*nd')/2;

T=ceil(1/(e^2));
W{1}=w0;B{1}=b0;
for i=2:T+1 %out of matlab memory
    idx=rand()*dim(1);
    x=trainData(ceil(idx),:);
    if ~isempty(find(index1==ceil(idx)))
        l=1;
    else
        l=-1;
    end
    if (W{i-1}*x'+B{i-1})*l<0
        W{i}=W{i-1}+0.1/(0.1+(i-1)*e*e)*x*l;B{i}=B{i-1}+0.1/(0.1+(i-1)*e*e)*l;
    else
        W{i}=W{i-1};B{i}=B{i-1};
    end
    if mod(i-1,dim(1))==0 && sqrt(sum((W{i}-W{i-dim(1)}).^2))<=0.001
        break;
    end
end
w=W{i};b=B{i};
end

