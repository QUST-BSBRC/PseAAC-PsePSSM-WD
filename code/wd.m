clear all
clc
%load data
load('317psepssm5psepssm.mat')
pseaac=xlsread('125M317data');
ss=[pseaac,psepssm];
label=xlsread('M317labels');
E=317;
WEISHU=3;
%%%%Two-dimensional wavelet denoising 
%%Use default threshold noise reduction
[thr,sorh,keepapp] = ddencmp('den','wv',ss);
clean = wdencmp('gbl',ss,'sym2',3,thr,'s',keepapp);
db=clean;
yuanshu=db;

%%Use the Birge-Massart strategy to reduce noise
%  wname='sym2';
% lev=3; 
% [c,l]=wavedec2(ss,lev,wname); 
% sigma=wnoisest(c,l,1); 
% alpha=3;
% [thr,nkeep]=wdcbm2(c,l,alpha);
% [clean,cxd,lxd,perf0,perfl2]=wdencmp('lvd',ss,wname,lev,thr,'s'); 
% db=clean;
% yuanshu=db;

%normalization
shu=zscore(yuanshu);
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
%svm
 model=svmtrain(train_label,train_shu,'-t 2');
 [predict_label(i),accuracy]=svmpredict( test_label(i),test_shu(i,:),model);
end

model=svmtrain(label(2:E),shu(2:E,:),'-t 2');
 [predict_label(1),accuracy]=svmpredict( label(1),shu(1,:),model);
 model=svmtrain(label(1:E-1),shu(1:E-1,:),'-t 2');
 [predict_label(E),accuracy]=svmpredict( label(E),shu(E,:),model);
 ACC=sum(label==predict_label')/E;
 ZONG=sum(label==predict_label')
 [Sn,Sp,MCC]=JGCL(label,predict_label,E,WEISHU);
