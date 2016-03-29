mean_main; %same mean as QDA

LDA_cov = zeros(features,features);% covariance for LDA

for y = 1: class % calculate class probability
 P(y) = count(1,y)/ sum(count);
end

% assuming QDA was run first we can compute the weighted average of the cov
% matrixes to find the pooled cov matrix

for h = 1:class
LDA_cov = LDA_cov +  (P(h) .* covar_main(:,:,class));
end

