%%% PCA Implementation
clc;
clear all;
load data_mnist_train 
load data_mnist_test
 
[coeff scores var] = pca(X_train);
[c1,sc1,var1] = pca(X_test);
 
% var holds the eigen values, as seen component 1 is most significant...
% others can be ignored, example:
numbers_train = [1:5923 54052:60000];
numbers_test = [1:980 8992:10000];
j =1;
 
for k = 300:100:700
 
a = svmtrain(X_train(numbers_train,:),Y_train(numbers_train),'kernelcachelimit',200000,'autoscale','false');
b = svmtrain(scores(numbers_train,1:k),Y_train(numbers_train),'autoscale','false');
% using only 2 features
 
test1 = svmclassify(a, X_test(numbers_test,:));
test2 = svmclassify(b, sc1(numbers_test,1:k));
 
cp_non = classperf(Y_test(numbers_test),test1);
cp_PCA = classperf(Y_test(numbers_test),test2); 
%cppp = confusionmat(Y_test(numbers_test),test2);
regular_CCR(j) = cp_non.CorrectRate;
PCA_CCR(j) = cp_PCA.CorrectRate;
j = j+1;
 
end
 
plot([400:100:700],PCA_CCR);
axis([400 700 0.70 1.000])

