clear all
clc
lamdashu=0;
WEISHU=317;
%Read the protein sequences pssm
for i=1:317
    nnn=num2str(i);
    name = strcat(nnn,'pssm.txt');
    fid{i}=importdata(name);
end
c=cell(WEISHU,1);
for t=1:WEISHU
    clear shu d shuju
 shu=fid{t}.data;
 [M,N]=size(shu);
 shuju=shu(1:M-5,1:20);
 d=[];
 %Normalized
 for i=1:M-5
    for j=1:20
      d(i,j)=1/(1+exp(-shuju(i,j)));
  end
end
 c{t}=d(:,:);
 end
 for i=1:WEISHU
 [MM,NN]=size(c{i});
  for  j=1:20
    x(i,j)=sum(c{i}(:,j))/MM;
 end
 end
xx=[];
sheta=[];
shetaxin=[];
lamda=1;
for lamda=1:lamdashu;
for t=1:WEISHU
  [MM,NN]=size(c{t});
  clear xx
   for  j=1:20
      for i=1:MM-lamda
       xx(i,j)=(c{t}(i,j)-c{t}(i+lamda,j))^2;
      end
      sheta(t,j)=sum(xx(1:MM-lamda,j))/(MM-lamda);
   end
end
shetaxin=[shetaxin,sheta];
end
psepssm=[x,shetaxin];
save 317psepssm0psepssm 

      