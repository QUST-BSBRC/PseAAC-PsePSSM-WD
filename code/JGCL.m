function [Sn,Sp ,MCC] =JGCL( test_label,predict_label,E,WEISHU)
tp=zeros(WEISHU,1);
tn=zeros(WEISHU,1);
fn=zeros(WEISHU,1);
fp=zeros(WEISHU,1);
for j=1:WEISHU
    for i=1:E
        if  test_label(i)==j
            if  predict_label(i)==j
            tp(j)=tp(j)+1;
        else
            fn(j)=fn(j)+1;
        end
        else  if predict_label(i)==j
                fp(j)=fp(j)+1;
            end
    end
end
end
for i=1:WEISHU
    tn(i)=sum(tp)-tp(i);

end
Sn=zeros(WEISHU,1);
Sp=zeros(WEISHU,1);
MCC=zeros(WEISHU,1);
for i=1:WEISHU
     Sn(i)=tp(i)/(tp(i)+fn(i));
    Sp(i)=tn(i)/(tn(i)+fp(i));
    MCC(i)=(tp(i)*tn(i)-fp(i)*fn(i))/sqrt((tp(i)+fp(i))*(tp(i)+fn(i))*(tn(i)+fp(i))*(tn(i)+fn(i)));
end
end

