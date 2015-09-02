function pred= TestTree(tree,x)
%TESTTREE 此处显示有关此函数的摘要
%   此处显示详细说明
dim=size(tree,2);
count=1;
while true
    if count>dim
        disp 'here';
    end
    if tree{count}.ne==0
        if ~isempty(tree{count}.c) && tree{count}.c >=0 && tree{count}.c<=9
            pred=tree{count}.c;
        else
            pred=10;
        end
        break;
    else
        w=tree{count}.w;b=tree{count}.b;
        if w*x'+b>0
            count=tree{count}.ne;
        else
            count=tree{count}.ne+1;
        end
        
    end
end
% while true
%     if count>dim
%         disp 'here'
%     end
%     if isempty(tree{count}.left)
%         if ~isempty(tree{count}.c) && tree{count}.c >=0 && tree{count}.c<=9
%             pred=tree{count}.c;
%         else
%             pred=10;
%         end
%         break;
%     else
%         w=tree{count}.w;b=tree{count}.b;
%         if w*x'+b>0
%             count=count*2;
%         else
%             count=count*2+1;
%         end
%     
%     end
% 
% end

