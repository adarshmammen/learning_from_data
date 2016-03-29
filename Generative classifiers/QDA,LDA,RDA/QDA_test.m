% Data set = fisher iris
clear Test P Prediction_mat the_min index_of_min
Test = S_test(:,1:features);

for y = 1: class % calculate class probability
 P(y) = count(1,y)/ sum(count);
end

for j = 1:size(Test) % all test samples

for i = 1: class 
QDA(1,i) = 0.5 * ((Test(j,:) - mean_main(i,:)) * inv(covar_main(:,:,i)) * (Test(j,:) - mean_main(i,:))') + 0.5 * log(det(covar_main(:,:,i))) - log(P(i));
end

[the_min, index_of_min] = min(QDA);
Prediction_mat(j,1) = index_of_min; %%%%%%%% The prediction %%%%%%%%%

end

%% analytics
cp = classperf(S_test(:,id),Prediction_mat);
cp.CorrectRate;
cp.CountingMatrix;