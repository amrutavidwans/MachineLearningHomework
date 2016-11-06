function [ U, V ] = myRecommender( rateMatrix, lowRank )
    % Please type your name here:
    name = 'Vidwans, Amruta';
    disp(name); % Do not delete this line.

    % Parameters
    maxIter = 500; % Choose your own.
    learningRate = 0.01; % Choose your own. mu
    regularizer = 0.2; % Choose your own. lamda
    
    % Random initialization:
    [n1, n2] = size(rateMatrix);
    U = rand(n1, lowRank) / lowRank;
    V = rand(n2, lowRank) / lowRank;

    % initial error
%     TotE_past=0;
%     Mtilda=zeros(n1,n2);
    
    TotE_past=(norm((U*V' - rateMatrix) .* (rateMatrix > 0), 'fro'))^2+regularizer*sum(sum(U.^2))+regularizer*sum(sum(V.^2));

% Gradient Descent:
    TotE_present=TotE_past-1;
    diffEner=(TotE_past-TotE_present);
    cnt=0;
    while cnt<maxIter && diffEner>0.1
        cnt=cnt+1;
        TotE_past=TotE_present;
        
        % summation over U*V
%         IntermResult=0;        
        % summation for the 1st term for U update
%         IntermResult2=(U*V').*(rateMatrix>0);
        prevU=U;
        prevV=V;
        for j= 1:n2
            for i= 1:n1
                if rateMatrix(i,j)>0
                   IntermResult=dot(U(i,:),V(j,:));
                   U(i,:)=U(i,:)+2*learningRate*((rateMatrix(i,j)-IntermResult)*V(j,:))-2*learningRate*regularizer*U(i,:);
                   V(j,:)=V(j,:)+2*learningRate*((rateMatrix(i,j)-IntermResult)*U(i,:))-2*learningRate*regularizer*V(j,:);
                end
            end
        end
        
    
    % new error
%         TotE_present=0;
        TotE_present=(norm((U*V' - rateMatrix) .* (rateMatrix > 0), 'fro'))^2+regularizer*sum(sum(U.^2))+regularizer*sum(sum(V.^2));
        diffEner=TotE_past-TotE_present;
    end
%     display(cnt);
    U=prevU;
    V=prevV;
    % IMPLEMENT YOUR CODE HERE.
end