function prob = algorithm(q)

% plot and return the probability
load sp500;
% price_move=price_move(1:10);
p0=[1-0.8 0.8];

A=[0.8 0.2;0.2 0.8]; %good bad
B=[q 1-q; 1-q q];    %+1 -1 

%forward procedure
%initialize
alpha=zeros(length(A),length(price_move));
if price_move(1)==1
    alpha(:,1)=p0.*B(1,:);
else
    alpha(:,1)=p0.*B(2,:);
end

%recursion
for i=2:length(price_move)
    if price_move(i)==+1
        alpha(:,i)=(A * alpha(:,i-1)).*B(1,:)';
    else
        alpha(:,i)=(A * alpha(:,i-1)).*B(2,:)';
    end
end

%backward procedure
%initialize
beta=zeros(length(A),length(price_move));
beta(:,end)=1;

%recursion
for i=length(price_move)-1:-1:1
    if price_move(i+1)==+1
        beta(1,i)=beta(1,i+1)*A(1,1)*B(1,1)+beta(2,i+1)*A(1,2)*B(1,2);    %(A * beta(:,i+1)).*B(1,:)';
        beta(2,i)=beta(1,i+1)*A(2,1)*B(1,1)+beta(2,i+1)*A(2,2)*B(1,2);   %(A * beta(:,i+1)).*B(1,:)';
    else
        beta(1,i)=beta(1,i+1)*A(1,1)*B(2,1)+beta(2,i+1)*A(1,2)*B(2,2);  %(A * beta(:,i+1)).*B(2,:)';
        beta(2,i)=beta(1,i+1)*A(2,1)*B(2,1)+beta(2,i+1)*A(2,2)*B(2,2);  %(A * beta(:,i+1)).*B(1,:)';
    end
end

% gamma calculation
% gamma=zeros(length(A),length(price_move));
% prob=(alpha.*beta)./sum(alpha(:,end));
for i=1:length(alpha)
    prob(:,i)=(alpha(:,i).*beta(:,i))./sum(alpha(:,end));
end
plot(prob(1,:));

end
