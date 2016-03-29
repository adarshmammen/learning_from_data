% 20 news group dataset
% classify class 1 and class 20 and performing a grid search of box constraint 'C' in the 5-fold cross validation
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


%%% make 5 fold for cross validation
 main_train3 = horzcat(main_train2,double(train_label));

class1_mat = main_train3(main_train3(:,61189)==1,:);
class2_mat = main_train3(main_train3(:,61189)==20,:);

CV_set1 = vertcat(class1_mat,class2_mat); 
shuffle = randperm(856);

CV_set_shuffled = CV_set1(shuffle,:);


CV_split = mat2cell(CV_set_shuffled,[171 171 171 171 172], [61188 1]);

spliter = [1:5 2:5 1 3:5 1 2 4 5 1:3 5 1:4];

C = 2^(-5);
m = 1;
while C~= 32768
z = 1;
for i = 1:5:25
length = size(CV_split{spliter(i),1},1) + size(CV_split{spliter(i+1),1}) + size(CV_split{spliter(i+2),1}) + size(CV_split{spliter(i+3),1});
box = ones(length(1,1),1).*C;
cellsplit = [CV_split{spliter(i),1}; CV_split{spliter(i+1),1} ;CV_split{spliter(i+2),1} ;CV_split{spliter(i+3),1}];
labelsplit = [CV_split{spliter(i),2}; CV_split{spliter(i+1),2} ;CV_split{spliter(i+2),2} ;CV_split{spliter(i+3),2}];
SVMStruct = svmtrain(cellsplit,labelsplit,'autoscale',false,'boxconstraint',box,'kernelcachelimit',22000);

    clear group;
    group = svmclassify(SVMStruct,CV_split{spliter(i+4),1});
    cp = classperf(CV_split{spliter(i+4),2},group);
    CCR(z) = cp.CorrectRate;
    z = z+1;
    clear length box cellsplit labelsplit SVMStruct cp
    
end
 avgCCR(m) = sum(CCR)./5;
 clear CCR;
 storedC(m) = C; 
 C = C*2;
 m = m+1;
end

plot(log(storedC),avgCCR); xlabel('box constraint'); ylabel('CVCCR');

% best boxconstraint = 2^(6)

% TESTING CCR WITH ALL TRAINING DATA TO ALL TEST DATA with best boxconst

train_svm1 = CV_set_shuffled(:,1:61188);
train_label_svm1 = CV_set_shuffled(:,61189);
C = 2^(6);
box = ones(856,1).*C;
Struct = svmtrain(train_svm1,train_label_svm1,'autoscale',false,'boxconstraint',box,'kernelcachelimit',22000);

%remove stop words from test data
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

class1_mat_test = main_test3(main_test3(:,61189)==1,:);
class2_mat_test = main_test3(main_test3(:,61189)==20,:);

CV_set1_test = vertcat(class1_mat_test,class2_mat_test); 

CV_data_test = CV_set1_test(:,1:61188);
CV_label_test = CV_set1_test(:,61189);

check = svmclassify(Struct,CV_data_test);
cp = classperf(CV_label_test,check);
cp.CorrectRate

%81.02% correct rate
% normal training 0.7135
