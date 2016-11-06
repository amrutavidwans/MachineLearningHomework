function [ class ] = mycluster( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment.
%
%     K: the number of desired topics/clusters. 
%
% Output:
%     class: the assignment of each topic. The
%     assignment should be 1, 2, 3, etc. 
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!

[nDocs,colBOW]=size(bow);

% rowSumbow=sum(bow,2);
% RepSumbow=repmat(rowSumbow,1,colBOW);
% MujC=bow./RepSumbow;
% 
% prodMu=prod(Muj,2);

% random initialization
PiC=rand(K,1);
PiC=PiC/sum(PiC);
PiC=PiC';

MujC=rand(K,colBOW);
SumMujC=sum(MujC);
RepSumMujC=repmat(SumMujC,K,1);
MujC=MujC./RepSumMujC;

gamma=zeros(nDocs,K);
MujCnew=MujC;
PiCnew=PiC;

check=1;
while isempty(check)~=1

    MujC=MujCnew;
    PiC=PiCnew;
% Expectation
NumG=ones(nDocs,K); DenG=zeros(nDocs);
    for d=1:nDocs
        for c=1:K
            
            for w=1:colBOW
                NumG(d,c)=NumG(d,c)*(MujC(c,w)^bow(d,w));
            end
            DenG(d)=DenG(d)+(PiC(c)*NumG(d,c));
            
        end
    end
    
    for d=1:nDocs
        for c=1:K
            gamma(d,c)=(PiC(c)*NumG(d,c))/DenG(d);
        end
    end
    
    
    PiCnew=sum(gamma)/nDocs;
    
        sumMuNum=zeros(K,colBOW);
     sumMuDen=zeros(K,1);   
% Maximization
    for c=1:K
        for w=1:colBOW
            for d=1:nDocs
                sumMuDen(c)=sumMuDen(c)+gamma(d,c)*bow(d,w);
            end
        end
    end
    
    for c=1:K
        for w=1:colBOW
            for d=1:nDocs
                sumMuNum(c,w)=sumMuNum(c,w)+gamma(d,c)*bow(d,w);
            end
            MujCnew(c,w)=sumMuNum(c,w)/sumMuDen(c);
        end
             
    end

    check=(find(abs(PiC-PiCnew)>0.00001));
%     check2=(find(abs(PiC-PiCnew)>0.0001));
    
end

[~,class]=max(gamma,[],2);

end

