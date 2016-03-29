% data = fisheriris

mean_1 = zeros(class, features);
mean_main = zeros(class, features);
count = zeros(1,class);

%covar variables
covar = zeros(features,features,class);
covar_main = zeros(features,features,class);
S = datasample(M,total_samples,'Replace',false); % randomize the dataset

S_train = S(1:train_samples,:);
S_test = S((train_samples+1):(train_samples+test_samples),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%% Mean %%%%%%%%%%%%%%%%%%%%%%%
for i = 1:train_samples
   mean_1(S_train(i,id),:) = mean_1(S_train(i,id),:) + S_train(i,1:features);
   count(1,S_train(i,id))= count(1,S_train(i,id)) + 1;
end

% find class mean
for i = 1:class
   mean_main(i,:) = mean_1(i,:)./count(1,i);
end
clear mean_1;

%%%%%%%%%%%%%%%%%%%%%% Covariance %%%%%%%%%%%%%%%%%%%%%%%

for i = 1:train_samples
    covar(:,:,S_train(i,id)) = covar(:,:,S_train(i,id)) +(((S_train(i,1:features) - mean_main(S_train(i,id),:))'*(S_train(i,1:features) -  mean_main(S_train(i,id),:))));
end

for m = 1:class
  covar_main(:,:,m) = covar(:,:,m)./count(1,m);
end

clear i covar m 

% :)
