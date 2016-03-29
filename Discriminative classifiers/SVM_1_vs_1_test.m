%get main_train
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

%got main train
sum_mat = uint16(sum(main_train,2));
sum_mat2 = repmat(sum_mat,1,61188);
clear sum_mat
main_train2 = double(main_train)./double(sum_mat2);
clear sum_mat2
 main_train3 = horzcat(main_train2,double(train_label));

main_train4 = sparse(main_train3);
clear main_train2 main_train3 main_train sum_mat sum_mat2

class = {};

for i = 1:length(unique(train_label))
class{i,1} = main_train4(main_train4(:,61189)==i,1:61188);
class{i,2} = full(main_train4(main_train4(:,61189)==i,61189));
end

tic
for i = 1:20
    for j = i+1:20
       svm_struct{i,j} = svmtrain(vertcat(cell2mat(class(i,1)),cell2mat(class(j,1))),vertcat(cell2mat(class(i,2)),cell2mat(class(j,2))),'kernelcachelimit',15000,'autoscale',false,'kernel_function','rbf');
    end
end
toc
% Elapsed time is 65.519255 seconds. for rbf

test_data_nostop = uint16(test_data);

for i = 1:length(stopword_index)
    
test_data_nostop((test_data(:,2)==stopword_index(i,1)),3) = 0;

end


% create vectors

for i = 1:length(test_label)
main_test(i,test_data_nostop(test_data_nostop(:,1)==i,2)) = test_data_nostop(test_data_nostop(:,1)==i,3);
end
%got main_test

sum_mat_test = uint16(sum(main_test,2));
sum_mat2_test = repmat(sum_mat_test,1,61188);

main_test2 = double(main_test)./double(sum_mat2_test);

test_matrix = sparse(main_test2);

all_col = 1;
tic
for i = 1:20
    for j = i+1:20
        pred_all_classes(:,all_col) = svmclassify(svm_struct{i,j},test_matrix);
        all_col = all_col+1;
    end
end
prediction = mode(pred_all_classes,2);
toc

cp = classperf(test_label,int32(prediction));
cp.CorrectRate
confusionmat(test_label,int32(prediction))


%rbf
% Elapsed time is 151.739588 seconds.
% 
% ans =
% 
%     0.3141
% 
% 
% ans =
% 
%      0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
%      0    56     2     0     0     0     0     0     0     0     0     0     1     6    88     1    20   142     0     0     2
%      0     0   136     4     2     1     0     1     0     0     0     0     1   106    88     2     0    48     0     0     0
%      0     0    38   131    23     3     7     0     0     0     1     0     1    58    71     1     0    57     0     0     0
%      0     0    18     7   133     0     0     2     0     0     1     1     1   140    53     2     0    34     0     0     0
%      0     0     4     2    30    71     1     2     0     0     0     1     0   132    76     1     0    63     0     0     0
%      0     0    30    15     2     0    82     3     0     0     0     0     4   120    76     5     0    53     0     0     0
%      0     0     2     0    41     9     0   110     5     0     1     0     1   115    45     2     0    51     0     0     0
%      0     1     1     1     0     0     1     1    56     0     1     0     0    67   113     0     0   153     0     0     0
%      0     1     0     0     0     0     0     1     1   118     0     0     0    18   127     0     0   131     0     0     0
%      0     2     0     0     0     0     0     2     0     0   107    15     0    27   122     0     0   122     0     0     0
%      0     0     0     0     0     0     0     1     0     0    13   179     0    19    54     1     1   131     0     0     0
%      0     0     6     1     0     0     0     0     0     0     0     0    87    19    73     0     0   209     0     0     0
%      0     0     4     0     3     3     0     1     0     0     0     0     2   188   108     0     0    84     0     0     0
%      0     2     1     0     0     0     1     4     0     0     1     0     0    37   327     0     2    18     0     0     0
%      0     0     3     0     0     1     0     0     0     0     0     0     0    15   162    95     0   116     0     0     0
%      0    13     2     1     0     0     0     0     0     0     0     0     0    25   110     1    76   170     0     0     0
%      0     0     1     0     0     0     0     2     1     0     0     0     1     5    12     0     0   342     0     0     0
%      0     3     0     0     0     0     0     0     0     0     2     0     0     5    48     0     0   294    24     0     0
%      1     1     1     0     0     0     0     0     0     0     0     0     0     4    37     0     0   239     0    27     0
%      0    12     2     0     0     0     0     0     0     0     0     0     0     5    62     0    23   135     0     0    12
% 

