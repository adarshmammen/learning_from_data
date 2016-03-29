clear Test P Prediction_mat the_min index_of_min
Test = S_test(:,1:features);

for y = 1: class % calculate class probability
 P(y) = count(1,y)/ sum(count);
end

clear j i;
for j = 1:size(Test) % all test samples

for i = 1: class 
LDA(1,i) = mean_main(i,:) * inv(LDA_cov) * (Test(j,:))' - 0.5 * mean_main(i,:) * inv(LDA_cov) * mean_main(i,:)' + log(P(i));
end

[the_max1, index_of_max1] = max(LDA);
Prediction_mat2(j,1) = index_of_max1; %%%%%%%% The prediction %%%%%%%%%

end

%% analytics
cp_LDA = classperf(S_test(:,id),Prediction_mat2);
cp_LDA.CorrectRate;
cp_LDA.CountingMatrix;