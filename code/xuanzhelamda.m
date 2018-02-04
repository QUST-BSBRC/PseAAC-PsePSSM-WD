clear all
clc
%load data
load('data')
%Each submitochondrial dataset is 3-class
E=3;
%the number of protein sequences 
SHU=317;
yuanshu=s(:,2:end);
%normalization
shu=zscore(yuanshu);
label=s(:,1);
%jackknife test
for i=2:SHU-1
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
model=svmtrain(label(2:SHU),shu(2:SHU,:),'-t 2');
 [predict_label(1),accuracy]=svmpredict( label(1),shu(1,:),model);
 model=svmtrain(label(1:SHU-1),shu(1:SHU-1,:),'-t 2');
 [predict_label(SHU),accuracy]=svmpredict( label(SHU),shu(SHU,:),model);
 ACC=sum(label==predict_label')/SHU;
 ZONG=sum(label==predict_label')
 [Sn,Sp,MCC]=JGCL(label,predict_label,E,SHU);

