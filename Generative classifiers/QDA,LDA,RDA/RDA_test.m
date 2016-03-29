for y = 1: class % calculate class probability
 P(y) = count(1,y)/ sum(count);
end

clear j i;
for j = 1:size(Test) % all test samples

for i = 1: class 
RDA(1,i) = mean_main(i,:) /(covar_reg) * (Test(j,:))' - 0.5 * mean_main(i,:) /(covar_reg) * mean_main(i,:)' + log(P(i));
end

[the_max1, index_of_max1] = max(RDA);
Prediction_mat2(j,1,no) = index_of_max1; %%%%%%%% The prediction %%%%%%%%%

end

