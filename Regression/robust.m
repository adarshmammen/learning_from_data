load linear_data

%train OLS model

XaugT = [xData ones(18,1)];
Xaug = XaugT';
Y = yData';

coeff = Y * XaugT * 1/(Xaug*XaugT);

%test

for i = 1: length(xData)
X_test = xData(i,1);
prediction(i,1) = coeff * [X_test;1];
end

MSE = sum((yData - prediction).^2)/length(yData);
MAE = sum(abs(yData - prediction))/length(yData);


%Robust fit

% cauchy
c = (robustfit(xData,yData,'cauchy', 2.385 , 'on'))';
for i = 1: length(xData)
X_test = xData(i,1);
prediction_cauchy(i,1) = c * [1;X_test];
end

MSE_cauchy = sum((yData - prediction_cauchy).^2)/length(yData);
MAE_cauchy = sum(abs(yData - prediction_cauchy))/length(yData);

% fair

f = (robustfit(xData,yData,'fair', 1.400 , 'on'))';
for i = 1: length(xData)
X_test = xData(i,1);
prediction_fair(i,1) = f *  [1;X_test];
end

MSE_fair = sum((yData - prediction_fair).^2)/length(yData);
MAE_fair = sum(abs(yData - prediction_fair))/length(yData);



% ‘huber’

h = (robustfit(xData,yData,'huber', 1.345 , 'on'))';
for i = 1: length(xData)
X_test = xData(i,1);
prediction_huber(i,1) = h * [1;X_test];
end

MSE_huber = sum((yData - prediction_huber).^2)/length(yData);
MAE_huber = sum(abs(yData - prediction_huber))/length(yData);


%talwar

t = (robustfit(xData,yData,'talwar',2.795 , 'on'))';
for i = 1: length(xData)
X_test = xData(i,1);
prediction_talwar(i,1) = t *  [1;X_test];
end

MSE_talwar = sum((yData - prediction_talwar).^2)/length(yData);
MAE_talwar = sum(abs(yData - prediction_talwar))/length(yData);


%plots
scatter(xData,yData,'filled'); hold on
plot(xData,coeff(1)*xData + coeff(2),'r'); hold on

plot(xData,c(2)*xData + c(1),'c'); hold on
plot(xData,f(2)*xData + f(1),'b'); hold on
plot(xData,h(2)*xData + h(1),'g'); hold on
plot(xData,t(2)*xData + t(1),'k'); hold on;
title('Compare Regression Methods');xlabel('X data');ylabel('Y data');
legend('Data','Ordinary Least Squares','Robust Regression - Cauchy','Robust Regression - Fair','Robust Regression - Huber','Robust Regression - Talwar','location','southeast'); hold off;
