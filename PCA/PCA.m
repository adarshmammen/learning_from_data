load fisheriris

[coeff scores var] = pca(meas);

% var holds the eigen values, as seen component 1 is most significant...
% others can be ignored, example:

numbers = randperm(100);


a = svmtrain(meas(numbers(1:75),:),species(numbers(1:75)));
b = svmtrain(scores(numbers(1:75),1:2),species(numbers(1:75)));
% using only 2 features

test1 = svmclassify(a, meas(numbers(76:100),:));
test2 = svmclassify(b, scores(numbers(76:100),1:2));

cp_non = classperf(species(numbers(76:100)),test1);
cp_PCA = classperf(species(numbers(76:100)),test2); 

regular_CCR = cp_non.CorrectRate
PCA_CCR = cp_PCA.CorrectRate