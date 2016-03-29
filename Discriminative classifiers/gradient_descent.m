d = 41; %feature size
m = 39; %classes
step_size = 1e-05;
lambda = 1000;
sum_tot =0;

partition = size(main_vec_train,1)*0.60;
training_set = (main_vec_train(1:partition,:));
test_set = main_vec_train(partition:size(main_vec_train,1),:);

true_test_labels = category_vec(526830:878049,:);

%initialize
w(:,:) = zeros(d,m);

keySet_Category =     {'ARSON'
    'ASSAULT'
    'BAD CHECKS'
    'BRIBERY'
    'BURGLARY'
    'DISORDERLY CONDUCT'
    'DRIVING UNDER THE INFLUENCE'
    'DRUG/NARCOTIC'
    'DRUNKENNESS'
    'EMBEZZLEMENT'
    'EXTORTION'
    'FAMILY OFFENSES'
    'FORGERY/COUNTERFEITING'
    'FRAUD'
    'GAMBLING'
    'KIDNAPPING'
    'LARCENY/THEFT'
    'LIQUOR LAWS'
    'LOITERING'
    'MISSING PERSON'
    'NON-CRIMINAL'
    'OTHER OFFENSES'
    'PORNOGRAPHY/OBSCENE MAT'
    'PROSTITUTION'
    'RECOVERED VEHICLE'
    'ROBBERY'
    'RUNAWAY'
    'SECONDARY CODES'
    'SEX OFFENSES FORCIBLE'
    'SEX OFFENSES NON FORCIBLE'
    'STOLEN PROPERTY'
    'SUICIDE'
    'SUSPICIOUS OCC'
    'TREA'
    'TRESPASS'
    'VANDALISM'
    'VEHICLE THEFT'
    'WARRANTS'
    'WEAPON LAWS'};

valueSet_category = {1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39};
mapObj_categories = containers.Map(keySet_Category,valueSet_category);

category_vec = values(mapObj_categories,Category);
category_vec = cell2mat(category_vec);

Subtract = zeros(526829,39);
for i = 1: 526829
    Subtract(i,category_vec(i)) = 1;
end
add_array = zeros(39,41);

for i = 1:526829
    add_array(category_vec(i),:) = add_array(category_vec(i)) + training_set(i,:);
end

f_theta = zeros(1000,1);

for t=1:1000
    test = training_set*w;
    test = exp(test);
    divide = sum(test,2);
    divide = repmat(divide,1,39);
    new_test = test./divide;
    new_test = new_test - Subtract;
    
    del_NLL = training_set' * new_test;
    del_ftheta = del_NLL + 1000.*w;
    
    log_add = sum(test,2);
    log_add = log(log_add);
    log_add = sum(log_add,1); % term 1
    
    
    for i = 1:39
        sum_tot = sum_tot + add_array(i,:)* w(:,i);
    end

    NLL = log_add - sum_tot;
    f_theta(t,1) = NLL + lambda./2 .* sum(sum(w.^2));
    
    test2 = test_set*w;
    test2 = exp(test2);
    divide2 = sum(test2,2);
    divide2 = repmat(divide2,1,39);
    new_test2 = test2./divide2;
    [vals,prediction] = max(new_test2,[],2);
    
    cp_LR = classperf(true_test_labels,prediction);
    CCR(t) = cp_LR.CorrectRate;

    sum_vals = sum(vals);
    if sum_vals < 1e-10
        sum_vals = 1e-10;     
    end
    logloss_sum = 0;
    for i = 1:351220
    logloss_sum = logloss_sum + new_test2(i,true_test_labels(i));
    end
    logloss(t) = - (1./351220 .* logloss_sum);

    w = w - step_size.*del_ftheta;
    fprintf('loop complete\n');
end



