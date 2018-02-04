clear all   
clc
%load data
pp=xlsread('983pp255');
ss=pp(:,2:end);
label=pp(:,1);
E=983;
WEISHU=3;
%%%Two-dimensional wavelet denoising
[thr,sorh,keepapp] = ddencmp('den','wv',ss);
clean = wdencmp('gbl',ss,'db6',6,thr,'s',keepapp);
yuanshu=clean;
shu=zscore(yuanshu);
for i=2:E-1
    test_shu(i,:)=shu(i,:);
    test_label(i)=label(i);
a=shu(1:i-1,:);
b=shu(i+1:end,:);
train_shu=[a;b];
c=label(1:i-1,:);
d=label(i+1:end,:);
train_label=[c;d];
%%SVM
%  model=svmtrain(train_label,train_shu,'-t 2 ');
%  [predict_label(i),accuracy]=svmpredict( test_label(i),test_shu(i,:),model);
%%KNN
 %predict_label(i)=knnclassify(shu(i,:),train_shu,train_label,3,'euclidean');
%%DT
%  tree=fitctree(train_shu,train_label);
%  predict_label(i)=predict(tree,shu(i,:));
%%na?ve Bayes
%  Factor = NaiveBayes.fit(train_shu,train_label);
% [Scores,predict_label(i)] = posterior(Factor, shu(i,:));
%%LDA
% Factor = ClassificationDiscriminant.fit(train_shu,train_label);
% [predict_label(i), Scores(i,:)] = predict(Factor, shu(i,:));
end
%%SVM
% model=svmtrain(label(2:E),shu(2:E,:),'-t 2');
% [predict_label(1),accuracy]=svmpredict( label(1),shu(1,:),model);
% model=svmtrain(label(1:E-1),shu(1:E-1,:),'-t 2');
% [predict_label(E),accuracy]=svmpredict( label(E),shu(E,:),model);
% %knn
% predict_label(1)=knnclassify(shu(1,:),shu(2:E,:),label(2:E,:),3,'euclidean');
% predict_label(E)=knnclassify(shu(E,:),shu(1:E-1,:),label(1:E-1,:),3,'euclidean');
%%DT
%  tree=fitctree(shu(2:E,:),label(2:E,:));
%   [predict_label(1)]=predict(tree,shu(1,:));
%   tree=fitctree(shu(1:E-1,:),label(1:E-1,:));
%   [predict_label(E)]=predict(tree,shu(E,:));
%%na?ve Bayes
% Factor = NaiveBayes.fit(shu(2:E,:),label(2:E,:));
% [Scores,predict_label(1)] = posterior(Factor, shu(1,:));
% Factor = NaiveBayes.fit(shu(1:E-1,:),label(1:E-1,:));
% [Scores,predict_label(E)] = posterior(Factor, shu(E,:));
%%LDA
% Factor = ClassificationDiscriminant.fit(shu(2:E,:),label(2:E,:));
% [predict_label(1), Scores(1,:)] = predict(Factor, shu(1,:));
% Factor = ClassificationDiscriminant.fit(shu(1:E-1,:),label(1:E-1,:));
% [predict_label(E), Scores(E,:)] = predict(Factor, shu(E,:));
ACC=sum(label==predict_label')/E
ZONG=sum(label==predict_label')
[Sn,Sp,MCC]=JGCL(label,predict_label,E,WEISHU);
output=[mean(Sn),mean(Sp),mean(MCC),ACC]

