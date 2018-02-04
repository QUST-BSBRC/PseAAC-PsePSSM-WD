clear all
clc
%load data
load('data')
%the number of protein sequences 
E=317;
yuanshu=psepssm;
%%Each submitochondrial dataset is 3-class
WEISHU=3;
%normalization
shu=zscore(yuanshu);
label=s(:,1);
%jackknife test
for i=2:E-1  
    test_shu(i,:)=shu(i,:);
    test_label(i)=label(i);
a=shu(1:i-1,:);
b=shu(i+1:end,:);
train_shu=[a;b];
c=label(1:i-1,:);
d=label(i+1:end,:); 
train_label=[c;d];
%SVM
 model=svmtrain(train_label,train_shu,'-t 2');
 [predict_label(i),accuracy]=svmpredict( test_label(i),test_shu(i,:),model);
end
model=svmtrain(label(2:E),shu(2:E,:),'-t 2');
 [predict_label(1),accuracy]=svmpredict( label(1),shu(1,:),model);
 model=svmtrain(label(1:E-1),shu(1:E-1,:),'-t 2');
 [predict_label(E),accuracy]=svmpredict( label(E),shu(E,:),model);
 ACC=sum(label==predict_label')/E
 ZONG=sum(label==predict_label')
 [Sn,Sp,MCC]=JGCL(label,predict_label,E,WEISHU);

