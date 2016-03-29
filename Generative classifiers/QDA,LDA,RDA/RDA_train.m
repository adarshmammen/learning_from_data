
%%%%%%%%%%%%%%%%%%%%%%%%%%% Mean %%%%%%%%%%%%%%%%%%%%%%%
for i = 1:train_samples
   mean_1(S_train(i,id),:) = mean_1(S_train(i,id),:) + S_train(i,1:features);
   count(1,S_train(i,id))= count(1,S_train(i,id)) + 1;
end

% find class mean
for i = 1:class
   mean_main(i,:) = mean_1(i,:)./count(1,i);
end

%%%%%%%%%%%%%%%%%%%%%% Covariance %%%%%%%%%%%%%%%%%%%%%%%

for i = 1:train_samples
    covar(:,:,S_train(i,id)) = covar(:,:,S_train(i,id)) +(((S_train(i,1:features) - mean_main(S_train(i,id),:))'*(S_train(i,1:features) -  mean_main(S_train(i,id),:))));
end

for m = 1:class
  covar_main(:,:,m) = covar(:,:,m)./count(1,m);
end


LDA_cov = zeros(features,features);% covariance for LDA

for y = 1: class % calculate class probability
 P(y) = count(1,y)/ sum(count);
end

% assuming QDA was run first we can compute the weighted average of the cov
% matrixes to find the pooled cov matrix

for h = 1:class
LDA_cov = LDA_cov +  (P(h) .* covar_main(:,:,class));
end

%%%%%%%%%%%%%%%%%%%%%%%%%% RDA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cov_diag_elements =  diag(LDA_cov);
cov_diag = diag(cov_diag_elements);
%regularize the covariance matrix
covar_reg = (lambda * cov_diag) + ((1 - lambda)* LDA_cov);
