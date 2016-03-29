% SVM trained for class 17 vs all others
% assuming data is in the same folder as the script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% read all the data %%%%%%%%%%%%%%%%%%%%%%%%%
fileID = fopen('vocabulary.txt');
vocabulary = textscan(fileID,'%s');
vocabulary = vocabulary{1};

clear fileID;
fileID = fopen('newsgrouplabels.txt');
newsgrouplabels = textscan(fileID,'%s');
newsgrouplabels = newsgrouplabels{1};

clear fileID;
fileID = fopen('stoplist.txt');
stoplist = textscan(fileID,'%s');
stoplist = stoplist{1};

clear fileID;
fileID = fopen('train.data');
train_data = textscan(fileID,'%d %d %d');
train_data = cell2mat(train_data);

clear fileID;
fileID = fopen('train.label');
train_label = textscan(fileID,'%d');
train_label = cell2mat(train_label);

clear fileID;
fileID = fopen('test.data');
test_data = textscan(fileID,'%d %d %d');
test_data = cell2mat(test_data);

clear fileID;
fileID = fopen('test.label');
test_label = textscan(fileID,'%d');
test_label = cell2mat(test_label);
clear fileID;

%%%%%%%%%%%% start SVM %%%%%%

%remove stop words
for i = 1:length(stoplist)
    try
    index(i,1) = find(strcmp(vocabulary, stoplist(i,1)));
    end
end

% get stop word index
stopword_index = unique(index);

%remove stop words from train data
train_data_nostop = uint16(train_data);

for i = 1:length(stopword_index)
    
train_data_nostop((train_data(:,2)==stopword_index(i,1)),3) = 0;

end


% create vectors

main_train = zeros(11269,61188,'uint16');


for i = 1:length(train_label)
main_train(i,train_data_nostop(train_data_nostop(:,1)==i,2)) = train_data_nostop(train_data_nostop(:,1)==i,3);
end

sum_mat = uint16(sum(main_train,2));
sum_mat2 = repmat(sum_mat,1,61188);

main_train2 = double(main_train)./double(sum_mat2);


% make 5 fold for cross validation
 main_train3 = horzcat(main_train2,double(train_label));

class1_mat = main_train3(main_train3(:,61189)==17,:);
class2_mat = main_train3(main_train3(:,61189)~=17,:);

class1_mat(:,61189)=1;
class2_mat(:,61189)=0;
clear main_train2 main_train3 main_train sum_mat sum_mat2
CV_set1 = vertcat(class1_mat,class2_mat); 
clear class1_mat class2_mat

shuffle = randperm(11269);

CV_set_shuffled = CV_set1(shuffle,:);
clear CV_set1

CV_split = mat2cell(CV_set_shuffled,[2254 2254 2254 2254 2253], [61188 1]);

clear CV_set_shuffled
spliter = [1:5 2:5 1 3:5 1 2 4 5 1:3 5 1:4];

C = 2^(-5);
m = 1;
while C~= 32768
z = 1;
for i = 1:5:25
%length = size(CV_split{spliter(i),1},1) + size(CV_split{spliter(i+1),1}) + size(CV_split{spliter(i+2),1}) + size(CV_split{spliter(i+3),1});
box = C;
cellsplit = [CV_split{spliter(i),1}; CV_split{spliter(i+1),1} ;CV_split{spliter(i+2),1} ;CV_split{spliter(i+3),1}];
labelsplit = [CV_split{spliter(i),2}; CV_split{spliter(i+1),2} ;CV_split{spliter(i+2),2} ;CV_split{spliter(i+3),2}];
SVMStruct = svmtrain(cellsplit,labelsplit,'autoscale',false,'boxconstraint',box,'kernelcachelimit',22000);

    clear group ACTUAL PREDICTED;
    PREDICTED = svmclassify(SVMStruct,CV_split{spliter(i+4),1});
    cp = classperf(CV_split{spliter(i+4),2},PREDICTED);
    CCR(z) = cp.CorrectRate;
    
    ACTUAL = CV_split{spliter(i+4),2};
    %%%%% calculate parameters
    idx = (ACTUAL()==1);
    
    p = length(ACTUAL(idx));
    n = length(ACTUAL(~idx));
    
    tp = sum(ACTUAL(idx)==PREDICTED(idx));
    tn = sum(ACTUAL(~idx)==PREDICTED(~idx));
    fp = n-tn;
    
    precision(z) = tp/(tp+fp);
    recall(z) = tp/p;
    f_measure(z) = 2*((precision(z)*recall(z))/(precision(z) + recall(z)));
    %%% end calculations

    z = z+1;
    clear box cellsplit labelsplit SVMStruct cp
    
end
 avgCCR(m) = sum(CCR)./5
 avgPrecision(m) = sum(precision)./5
 avgRecall(m) = sum(recall)./5
 avgF_score(m) = sum(f_measure)./5
 clear CCR precision recall f_measure;
 storedC(m) = C; 

 C = C*2;
 m = m+1;
end

plot(log(storedC),avgCCR); xlabel('box constraint'); ylabel('CVCCR');
% best boxconstraint =2^(7)

%%% load main_train
%TESTING CCR WITH ALL TRAINING DATA TO ALL TEST DATA with best boxconst
sum_mat = uint16(sum(main_train,2));
sum_mat2 = repmat(sum_mat,1,61188);

main_train2 = double(main_train)./double(sum_mat2);
clear sum_mat sum_mat2 main_train

main_train3 = horzcat(main_train2,double(train_label));
clear main_train2
class1_mat = main_train3(main_train3(:,61189)==17,:);
class2_mat = main_train3(main_train3(:,61189)~=17,:);

class1_mat(:,61189)=1;
class2_mat(:,61189)=0;
clear main_train2 main_train3 main_train sum_mat sum_mat2
CV_set1 = vertcat(class1_mat,class2_mat); 
clear class1_mat class2_mat

box = 2^(7);
Struct = svmtrain(sparse(CV_set1(:,1:61188)),sparse(CV_set1(:,61189)),'autoscale',false,'boxconstraint',box,'kernelcachelimit',22000);

remove stop words from test data
test_data_nostop = uint16(test_data);

for i = 1:length(stopword_index)
    
test_data_nostop((test_data(:,2)==stopword_index(i,1)),3) = 0;

end


% create vectors

for i = 1:length(test_label)
main_test(i,test_data_nostop(test_data_nostop(:,1)==i,2)) = test_data_nostop(test_data_nostop(:,1)==i,3);
end

sum_mat_test = uint16(sum(main_test,2));
sum_mat2_test = repmat(sum_mat_test,1,61188);

main_test2 = double(main_test)./double(sum_mat2_test);

main_test3 = horzcat(main_test2,double(test_label));

class1_mat_test = main_test3(main_test3(:,61189)==17,:);
class2_mat_test = main_test3(main_test3(:,61189)~=17,:);

class1_mat_test(:,61189)=1;
class2_mat_test(:,61189)=0;
 clear main_test2 main_test3 main_test sum_mat_test sum_mat2_test


CV_set1_test = vertcat(sparse(class1_mat_test),sparse(class2_mat_test)); 

CV_data_test = CV_set1_test(:,1:61188);
CV_label_test = CV_set1_test(:,61189);

check = svmclassify(Struct,sparse(CV_set1_test(:,1:61188)));
cp = classperf(CV_label_test,check);
cp.CorrectRate
confusionmat(CV_label_test,check)

% test CCR OVA = 0.9704 with best C

% confusion matrix with best C
%  7029         111
%   111         253



%%%%%%%%% Testing %%%%%%%%

%run script matlab2_2c before this, helps to run in parts to avoid running out of memory
plot(log(storedC),avgPrecision)
hold on
plot(log(storedC),avgRecall)
hold on 
plot(log(storedC),avgF_score)
legend('Precision','Recall','F-score','Location','southeast')
xlabel('log(C)')
ylabel('percentage')
hold off

best C for precision = 2^(9)
best C for recall = 2^(3)
best C for F-score = 2^(7)

%TESTING CCR WITH ALL TRAINING DATA TO ALL TEST DATA with best boxconst
sum_mat = uint16(sum(main_train,2));
sum_mat2 = repmat(sum_mat,1,61188);

main_train2 = double(main_train)./double(sum_mat2);
clear sum_mat sum_mat2 main_train

main_train3 = horzcat(main_train2,double(train_label));
clear main_train2
class1_mat = sparse(main_train3(main_train3(:,61189)==17,:));
class2_mat = sparse(main_train3(main_train3(:,61189)~=17,:));

class1_mat(:,61189)=1;
class2_mat(:,61189)=0;
clear main_train2 main_train3 main_train sum_mat sum_mat2
CV_set1 = vertcat(class1_mat,class2_mat); 
clear class1_mat class2_mat

box = 2^(7); %put C here

Struct = svmtrain(CV_set1(:,1:61188),CV_set1(:,61189),'autoscale',false,'boxconstraint',box,'kernelcachelimit',22000);



remove stop words from test data
test_data_nostop = uint16(test_data);

for i = 1:length(stopword_index)
    
test_data_nostop((test_data(:,2)==stopword_index(i,1)),3) = 0;

end


% create vectors

for i = 1:length(test_label)
main_test(i,test_data_nostop(test_data_nostop(:,1)==i,2)) = test_data_nostop(test_data_nostop(:,1)==i,3);
end

sum_mat_test = uint16(sum(main_test,2));
sum_mat2_test = repmat(sum_mat_test,1,61188);

main_test2 = double(main_test)./double(sum_mat2_test);

main_test3 = horzcat(main_test2,double(test_label));

class1_mat_test = main_test3(main_test3(:,61189)==17,:);
class2_mat_test = main_test3(main_test3(:,61189)~=17,:);

class1_mat_test(:,61189)=1;
class2_mat_test(:,61189)=0;
clear main_test2 main_test3 main_test sum_mat_test sum_mat2_test

 
CV_set1_test = vertcat(sparse(class1_mat_test),sparse(class2_mat_test)); 

CV_data_test = CV_set1_test(:,1:61188);
CV_label_test = CV_set1_test(:,61189);

check = svmclassify(Struct,sparse(CV_set1_test(:,1:61188)));
cp = classperf(CV_label_test,check);
cp.CorrectRate
confusionmat(CV_label_test,check)

% for best precision C CCR =  0.9713
%confusionmat
%  7044          96
%   119         245

%for best recall C CCR =  0.9671
%confusionmat
%         6959        181
%         66          298

% for best F-score 
%     ans =
% 
%     0.9704
% 
% 
% ans =
% 
%         7029         111
%          111         253


