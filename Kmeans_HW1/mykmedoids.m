function [ class, centroid ] = mykmedoids( pixels, K )
%
% Your goal of this assignment is implementing your own K-medoids.
% Please refer to the instructions carefully, and we encourage you to
% consult with other resources about this algorithm on the web.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.

% 	[class, centroid] = kmeans(pixels, K);
%     clear all;
%     close all;
%     clc;
%     
%      image = imread('beach.bmp');
% 	rows = size(image, 1);
% 	cols = size(image, 2);
% 	pixels = zeros(rows*cols, 3);
%     for i=1:rows
%         for j=1:cols
% 			pixels((j-1)*rows+i, 1:3) = image(i,j,:);
%         end
% 	end
%     
%     K=3;
%     %check size of incoming image
%     [imszr,~]=size(pixels);
    
    % random initialization of the 1st cluster centroid from the data
    % points
%     Mu_k=zeros(K,3);
    Mu_k=pixels(randsample(length(pixels),K),:);
% Mu_k=ones(K,3).*255;
    Mu_knew=Mu_k;
    %check size of incoming image
    [imszr,~]=size(pixels);
    
    forcestop=1000;
    cnt=0;
    change=10;
    %k-means loop
    while change>1 && cnt<=forcestop     %continue till centroids dont move
    
        cnt=cnt+1;
        Mu_k=Mu_knew;   % store the current Mu
        pix_dist=zeros(imszr,K); % array to store distances
    
        % euclidean distance calculation corresponding to each Mu
        for iter=1:K
            repMuk=repmat(Mu_k(iter,:),imszr,1); % array of repeated Mu(K) values
            EucInside=(abs(pixels-repMuk));      
            pix_dist(:,iter)=(sum(EucInside,2));
        end
        [~,clus_idx]=min(pix_dist,[],2);  % cluster number of min distance
    
        % re-calculation of Mu
        for iter=1:K
            loc=find(clus_idx==iter);
            temp=median(pixels(loc,:),1);
            reptemp=repmat(temp,imszr,1); % array of repeated Mu(K) values
            diffTemp=sum(abs(pixels-reptemp),2);
            [~,newloc]=min(diffTemp);
            Mu_knew(iter,:)=pixels(newloc,:);
%             Mu_knew(iter,:)=median(pixels(loc,:),1);
        end    
    
        change=sum(sum(abs(Mu_k-Mu_knew)));   % centroid difference
    
        if sum(isnan(Mu_knew))>0    %exception handling
            Mu_k=pixels(randsample(length(pixels),K),:);
            Mu_knew=Mu_k;
            change=1;
        end
        
    end

        class=clus_idx;
        centroid=Mu_knew;
        if cnt>forcestop
            display('Warning: Failed to converge in 1000 iterations.');
        end
%         cnt
    
end

