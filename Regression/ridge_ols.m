load quad_data
k = 0;
b = ridge(ytrain,xtrain,k,0);

for i = 1:14
xtrain_fit(:,i) = (xtrain).^i;
end

for i = 1:14
xtest_fit(:,i) = (xtest).^i;
end

for i = 1:14
b_fit{i} = ridge(ytrain,xtrain_fit(:,1:i),k,0);
end

xtrain_fit2 = [ones(21,1) xtrain_fit];
xtest_fit2 = [ones(201,1) xtest_fit];
figure
scatter(xtrain,ytrain); hold on

%order 2
plot(xtrain,b_fit{2}(3,1)*xtrain_fit2(:,3) + b_fit{2}(2,1)*xtrain_fit2(:,2) + b_fit{2}(1,1)*xtrain_fit2(:,1), 'y');  hold on

plot(xtrain,b_fit{6}(7,1)*xtrain_fit2(:,7) + b_fit{6}(6,1)*xtrain_fit2(:,6) + ...
    b_fit{6}(5,1)*xtrain_fit2(:,5) + b_fit{6}(4,1)*xtrain_fit2(:,4) + b_fit{6}(3,1)*xtrain_fit2(:,3)...
    + b_fit{6}(2,1)*xtrain_fit2(:,2) + b_fit{6}(1,1)*xtrain_fit2(:,1), 'b');  hold on

plot(xtrain,b_fit{10}(11,1)*xtrain_fit2(:,11) + b_fit{10}(10,1)*xtrain_fit2(:,10) + ...
    b_fit{10}(9,1)*xtrain_fit2(:,9) + b_fit{10}(8,1)*xtrain_fit2(:,8) + b_fit{10}(7,1)*xtrain_fit2(:,7)...
    + b_fit{10}(6,1)*xtrain_fit2(:,6) + b_fit{10}(5,1)*xtrain_fit2(:,5) + b_fit{10}(4,1)*xtrain_fit2(:,4)...
    + b_fit{10}(3,1)*xtrain_fit2(:,3)+ b_fit{10}(2,1)*xtrain_fit2(:,2)+ b_fit{10}(1,1)*xtrain_fit2(:,1), 'g');  hold on

plot(xtrain,b_fit{14}(15,1)*xtrain_fit2(:,15) + b_fit{14}(14,1)*xtrain_fit2(:,14) + ...
    b_fit{14}(13,1)*xtrain_fit2(:,13) + b_fit{14}(12,1)*xtrain_fit2(:,12) + b_fit{14}(11,1)*xtrain_fit2(:,11)...
    + b_fit{14}(10,1)*xtrain_fit2(:,10) + b_fit{14}(9,1)*xtrain_fit2(:,9) + b_fit{14}(8,1)*xtrain_fit2(:,8)...
    + b_fit{14}(7,1)*xtrain_fit2(:,7)+ b_fit{14}(6,1)*xtrain_fit2(:,6)+ b_fit{14}(5,1)*xtrain_fit2(:,5)... 
    + b_fit{14}(4,1)*xtrain_fit2(:,4)+ b_fit{14}(3,1)*xtrain_fit2(:,3)+ b_fit{14}(2,1)*xtrain_fit2(:,2)+ b_fit{14}(1,1)*xtrain_fit2(:,1), 'm'); hold on
hold on

title('OLS to fit polynomials'); xlabel('xData'); ylabel('OLS polynomial fit'); 
legend('Data','Order 2', 'Order 6', 'Order 10', 'Order 14', 'location', 'southeast'); hold off;


for i = 1:14
    
   if 13-i > -1
    b_fit_with_zeros(:,i) = [b_fit{i};zeros(13-i,1)];
   end
end


%find MSE for training

for i = 1:21
x = xtrain(i,1);
    for j = 1:13
        predicted_train(i,j) = b_fit_with_zeros(14,j)* x.^13 +b_fit_with_zeros(13,j)*...
            x.^12 +b_fit_with_zeros(12,j)* x.^11 +b_fit_with_zeros(11,j)* x.^10 +b_fit_with_zeros(10,j)* ...
            x.^9 +b_fit_with_zeros(9,j)* x.^8 +b_fit_with_zeros(8,j)* x.^7 +b_fit_with_zeros(7,j)* ...
            x.^6 +b_fit_with_zeros(6,j)* x.^5 +b_fit_with_zeros(5,j)* x.^4 +b_fit_with_zeros(4,j)* ...
            x.^3 +b_fit_with_zeros(3,j)* x.^2 + b_fit_with_zeros(2,j) * x + b_fit_with_zeros(1,j);
    end
end

for i = 1:13
MSE(i,1) = sum((ytrain - predicted_train(:,i)).^2)/length(ytrain);
end

%for testing

for i = 1:201
x = xtest(i,1);
    for j = 1:13
        predicted_test(i,j) = b_fit_with_zeros(14,j)* x.^13 +b_fit_with_zeros(13,j)*...
            x.^12 +b_fit_with_zeros(12,j)* x.^11 +b_fit_with_zeros(11,j)* x.^10 +b_fit_with_zeros(10,j)* ...
            x.^9 +b_fit_with_zeros(9,j)* x.^8 +b_fit_with_zeros(8,j)* x.^7 +b_fit_with_zeros(7,j)* ...
            x.^6 +b_fit_with_zeros(6,j)* x.^5 +b_fit_with_zeros(5,j)* x.^4 +b_fit_with_zeros(4,j)* ...
            x.^3 +b_fit_with_zeros(3,j)* x.^2 + b_fit_with_zeros(2,j) * x + b_fit_with_zeros(1,j);
    end
end

for i = 1:13
MSE_test(i,1) = sum((ytest - predicted_test(:,i)).^2)/length(ytest);
end
figure
plot(1:13,MSE); hold on
plot(1:13,MSE_test); hold off
xlabel('polynomial degree'); ylabel('MSE'); legend('training data', 'testing data','location','northeast');
title('MSE of OLS')



% 3.3 b
num = 1;
% find ridge regression coeffs for L and store as one matrix
for t = -25:1:5
L = exp(t);
b_reg(:,num) = ridge(ytrain,xtrain_fit(:,1:10),L,0);
num = num+1;
end

% test all data points train (21) with ridge coeff with different L

for j = 1:31
for i = 1:21
  x = xtrain(i,1);
  predicted_train_ridge(i,j) = b_reg(11,j)* x.^10 +b_reg(10,j)* ...
  x.^9 +b_reg(9,j)* x.^8 +b_reg(8,j)* x.^7 +b_reg(7,j)* ...
  x.^6 +b_reg(6,j)* x.^5 +b_reg(5,j)* x.^4 +b_reg(4,j)* ...
  x.^3 +b_reg(3,j)* x.^2 + b_reg(2,j) * x + b_reg(1,j);
end
end

%find MSE

for i = 1:31
MSE_train_ridge(i,1) = sum((ytrain - predicted_train_ridge(:,i)).^2)/length(ytrain);
end

% test all data points test (201) with ridge coeff with different L

for j = 1:31
for i = 1:201
  x = xtest(i,1);
  predicted_test_ridge(i,j) = b_reg(11,j)* x.^10 +b_reg(10,j)* ...
  x.^9 +b_reg(9,j)* x.^8 +b_reg(8,j)* x.^7 +b_reg(7,j)* ...
  x.^6 +b_reg(6,j)* x.^5 +b_reg(5,j)* x.^4 +b_reg(4,j)* ...
  x.^3 +b_reg(3,j)* x.^2 + b_reg(2,j) * x + b_reg(1,j);
end
end

%find MSE

for i = 1:31
MSE_test_ridge(i,1) = sum((ytest - predicted_test_ridge(:,i)).^2)/length(ytest);
end
figure
plot(-25:5,MSE_train_ridge); hold on
plot(-25:5,MSE_test_ridge); hold on
title('MSE of ridge regression varying k, polynomial deg = 10');
xlabel('lambda in log(lambda)'); ylabel('MSE'); hold off;
legend('training data', 'testing data','location','southwest');



% 3.3 b cont

 j = 28;


figure
scatter(xtest,ytest); hold on

plot(xtest,b_fit{10}(11,1)*xtest_fit2(:,11) + b_fit{10}(10,1)*xtest_fit2(:,10) + ...
    b_fit{10}(9,1)*xtest_fit2(:,9) + b_fit{10}(8,1)*xtest_fit2(:,8) + b_fit{10}(7,1)*xtest_fit2(:,7)...
    + b_fit{10}(6,1)*xtest_fit2(:,6) + b_fit{10}(5,1)*xtest_fit2(:,5) + b_fit{10}(4,1)*xtest_fit2(:,4)...
    + b_fit{10}(3,1)*xtest_fit2(:,3)+ b_fit{10}(2,1)*xtest_fit2(:,2)+ b_fit{10}(1,1)*xtest_fit2(:,1), 'g');  hold on

plot(xtest, b_reg(11,28)* xtest_fit2(:,11) +b_reg(10,28)* ...
  xtest_fit2(:,10) +b_reg(9,28)* xtest_fit2(:,9) +b_reg(8,28)* xtest_fit2(:,8) +b_reg(7,28)* ...
  xtest_fit2(:,7) +b_reg(6,28)* xtest_fit2(:,6) +b_reg(5,28)* xtest_fit2(:,5) +b_reg(4,28)* ...
  xtest_fit2(:,4) +b_reg(3,28)* xtest_fit2(:,3) + b_reg(2,28) * xtest_fit2(:,2) + b_reg(1,28)* xtest_fit2(:,1), 'b');  hold on

xlabel('xTest'); ylabel('OLS and ridge fit'); title('Test Data, OLS 10th degree and ridge');
legend('Test points','OLS 10th degree','Ridge best 10th degree','location','northwest');


% 3.3 c
num = 1;
% find ridge regression coeffs for L and store as one matrix
for t = -25:1:5
L = exp(t);
b_rig_4(:,num) = ridge(ytrain,xtrain_fit(:,1:4),L,0);
num = num+1;
end

figure
plot(-25:5,b_rig_4(1,:)); hold on;
plot(-25:5,b_rig_4(2,:)); hold on;
plot(-25:5,b_rig_4(3,:)); hold on;
plot(-25:5,b_rig_4(4,:)); hold on;
xlabel('lambda of ln(lambda)'); ylabel('coeff value curves'); title('Values of the ridge coeff vs log(lambda)');
legend('w0','w1','w2','w3','location','northwest');
