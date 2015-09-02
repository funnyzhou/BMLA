function tr=BuildTree(D,m,e,d,maxd)
%bt={};
count=1;
node=struct('w',0,'b',0,'c',[],'st',count,'ne',[],'deepth',d);
queueN{1}=node;
queueD{1}=D;
times=0;
while ~isempty(queueD)
    %ГіСа
    nd=queueN{1};
    data=queueD{1};
    dim=size(data);
    trainLabel=data(:,dim(2));
    szLabel=size(trainLabel);
    w=0;b=0;
    if dim(1)<=m || sum(diff(trainLabel)==zeros(szLabel(1)-1,1))==szLabel(1)-1 || nd.deepth>=maxd
        %tree=cell(1,5);
        tr{nd.st}.w=nd.w;
        tr{nd.st}.b=nd.b;
        tr{nd.st}.c=mode(trainLabel);
        tr{nd.st}.st=nd.st;
        tr{nd.st}.ne=0;
        queueN(1)=[];
        queueD(1)=[];
        times=times+1;
%         id=id+1;
    else
        [w,b]=Linear(data,e);
        %divide data
        DL=data(find(w*data(:,1:dim(2)-1)'+b>0==1),:);
        DR=data(find(w*data(:,1:dim(2)-1)'+b<=0==1),:);
        ndL=struct('w',0,'b',0,'c',[],'st',[],'ne',[],'deepth',nd.deepth+1);
        ndR=struct('w',0,'b',0,'c',[],'st',[],'ne',[],'deepth',nd.deepth+1);
        tr{nd.st}.w=w;
        tr{nd.st}.b=b;
        tr{nd.st}.c=[];
        tr{nd.st}.st=nd.st;
        tr{nd.st}.ne=2*(nd.st-times);
        ndL.st=2*(nd.st-times);
        ndR.st=2*(nd.st-times)+1;
%         nd.w=w;
%         nd.b=b;
%         nd.c=[];
%         nd.st=count;
%         nd.ne=count+1;
        
        queueN{end+1}=ndL;queueN{end+1}=ndR;
        queueD{end+1}=DL;queueD{end+1}=DR;
        
        queueN(1)=[];
        queueD(1)=[];
        %id=id+1;
        %tree{1}=BuildTree(S,DL,m,e,d+1,maxd);tree{2}=BuildTree(S,DR,m,e,d+1,maxd);
    end
    count=count+1;
end
