% dataset = 20 newsgroups
% assuming data is in the same folder as the script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% read all the data %%%%%%%%%%%%%%%%%%%%%%%%%
fclose('all');

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
train_data = textscan(fileID,'%f %f %f');
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% variables
class = 20;
total_words_in_class = zeros(1,20);
data_class = cell(20,1)
%format data to show ground truth on data matrix
train_data(:,4) = train_label(train_data(:,1),1);

%calculate P(y) for all 1:j classes in the training set
prob_y = arrayfun(@(x)length(find(train_label(:,1)==x)), unique(train_label(:,1))) / length(train_label(:,1));
%sum(prob_y(:,1)) % sum is one, verified


%calculate beta estimates

% total words in all classes
%find individual class
for i = 1:class
total_words_in_class(i) = sum(train_data(train_data(:,4)==i,3));
end

%split data into classes
for i = 1:class
data_class{i} = train_data((train_data(:,4)==i),:);
end

class1 = data_class{1};
class2 = data_class{2};
class3 = data_class{3}; 
class4 = data_class{4}; 
class5 = data_class{5};
class6 = data_class{6}; 
class7 = data_class{7};
class8 = data_class{8};
class9 = data_class{9}; 
class10 = data_class{10}; 
class11= data_class{11}; 
class12 = data_class{12}; 
class13 = data_class{13}; 
class14 = data_class{14};
class15 = data_class{15};
class16 = data_class{16};
class17 = data_class{17}; 
class18 = data_class{18};
class19 = data_class{19}; 
class20 = data_class{20};
%find word probability in each class 

prob_word_in_class1 = arrayfun(@(x)sum(class1((class1(:,2)==x),3)), unique(class1(:,2)));
x = unique(class1(:,2));
prob_word_in_class1 = [x,prob_word_in_class1];

prob_word_in_class1(:,3) = prob_word_in_class1(:,2)/total_words_in_class(1);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%

prob_word_in_class2 = arrayfun(@(x)sum(class2((class2(:,2)==x),3)), unique(class2(:,2)));
x = unique(class2(:,2));
prob_word_in_class2 = [x,prob_word_in_class2];

prob_word_in_class2(:,3) = prob_word_in_class2(:,2)/total_words_in_class(2);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class3 = arrayfun(@(x)sum(class3((class3(:,2)==x),3)), unique(class3(:,2)));
x = unique(class3(:,2));
prob_word_in_class3 = [x,prob_word_in_class3];

prob_word_in_class3(:,3) = prob_word_in_class3(:,2)/total_words_in_class(3);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class4 = arrayfun(@(x)sum(class4((class4(:,2)==x),3)), unique(class4(:,2)));
x = unique(class4(:,2));
prob_word_in_class4 = [x,prob_word_in_class4];

prob_word_in_class4(:,3) = prob_word_in_class4(:,2)/total_words_in_class(4);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class5 = arrayfun(@(x)sum(class5((class5(:,2)==x),3)), unique(class5(:,2)));
x = unique(class5(:,2));
prob_word_in_class5 = [x,prob_word_in_class5];

prob_word_in_class5(:,3) = prob_word_in_class5(:,2)/total_words_in_class(5);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class6 = arrayfun(@(x)sum(class6((class6(:,2)==x),3)), unique(class6(:,2)));
x = unique(class6(:,2));
prob_word_in_class6 = [x,prob_word_in_class6];

prob_word_in_class6(:,3) = prob_word_in_class6(:,2)/total_words_in_class(6);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class7 = arrayfun(@(x)sum(class7((class7(:,2)==x),3)), unique(class7(:,2)));
x = unique(class7(:,2));
prob_word_in_class7 = [x,prob_word_in_class7];

prob_word_in_class7(:,3) = prob_word_in_class7(:,2)/total_words_in_class(7);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class8 = arrayfun(@(x)sum(class8((class8(:,2)==x),3)), unique(class8(:,2)));
x = unique(class8(:,2));
prob_word_in_class8 = [x,prob_word_in_class8];

prob_word_in_class8(:,3) = prob_word_in_class8(:,2)/total_words_in_class(8);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class9 = arrayfun(@(x)sum(class9((class9(:,2)==x),3)), unique(class9(:,2)));
x = unique(class9(:,2));
prob_word_in_class9 = [x,prob_word_in_class9];

prob_word_in_class9(:,3) = prob_word_in_class9(:,2)/total_words_in_class(9);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class10 = arrayfun(@(x)sum(class10((class10(:,2)==x),3)), unique(class10(:,2)));
x = unique(class10(:,2));
prob_word_in_class10 = [x,prob_word_in_class10];

prob_word_in_class10(:,3) = prob_word_in_class10(:,2)/total_words_in_class(10);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%%
prob_word_in_class11 = arrayfun(@(x)sum(class11((class11(:,2)==x),3)), unique(class11(:,2)));
x = unique(class11(:,2));
prob_word_in_class11 = [x,prob_word_in_class11];

prob_word_in_class11(:,3) = prob_word_in_class11(:,2)/total_words_in_class(11);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class12 = arrayfun(@(x)sum(class12((class12(:,2)==x),3)), unique(class12(:,2)));
x = unique(class12(:,2));
prob_word_in_class12 = [x,prob_word_in_class12];

prob_word_in_class12(:,3) = prob_word_in_class12(:,2)/total_words_in_class(12);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class13 = arrayfun(@(x)sum(class13((class13(:,2)==x),3)), unique(class13(:,2)));
x = unique(class13(:,2));
prob_word_in_class13 = [x,prob_word_in_class13];

prob_word_in_class13(:,3) = prob_word_in_class13(:,2)/total_words_in_class(13);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class14 = arrayfun(@(x)sum(class14((class14(:,2)==x),3)), unique(class14(:,2)));
x = unique(class14(:,2));
prob_word_in_class14 = [x,prob_word_in_class14];

prob_word_in_class14(:,3) = prob_word_in_class14(:,2)/total_words_in_class(14);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class15 = arrayfun(@(x)sum(class15((class15(:,2)==x),3)), unique(class15(:,2)));
x = unique(class15(:,2));
prob_word_in_class15 = [x,prob_word_in_class15];

prob_word_in_class15(:,3) = prob_word_in_class15(:,2)/total_words_in_class(1);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class16 = arrayfun(@(x)sum(class16((class16(:,2)==x),3)), unique(class16(:,2)));
x = unique(class16(:,2));
prob_word_in_class16 = [x,prob_word_in_class16];

prob_word_in_class16(:,3) = prob_word_in_class16(:,2)/total_words_in_class(16);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class17 = arrayfun(@(x)sum(class17((class17(:,2)==x),3)), unique(class17(:,2)));
x = unique(class17(:,2));
prob_word_in_class17 = [x,prob_word_in_class17];

prob_word_in_class17(:,3) = prob_word_in_class17(:,2)/total_words_in_class(17);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class18 = arrayfun(@(x)sum(class18((class18(:,2)==x),3)), unique(class18(:,2)));
x = unique(class18(:,2));
prob_word_in_class18 = [x,prob_word_in_class18];

prob_word_in_class18(:,3) = prob_word_in_class18(:,2)/total_words_in_class(18);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class19 = arrayfun(@(x)sum(class19((class19(:,2)==x),3)), unique(class19(:,2)));
x = unique(class19(:,2));
prob_word_in_class19 = [x,prob_word_in_class19];

prob_word_in_class19(:,3) = prob_word_in_class19(:,2)/total_words_in_class(19);
%format of above var of class : Word_ID,occurance,probability of occurance
clear x;
%%%%%

prob_word_in_class20 = arrayfun(@(x)sum(class20((class20(:,2)==x),3)), unique(class20(:,2)));
x = unique(class20(:,2));
prob_word_in_class20 = [x,prob_word_in_class20];

prob_word_in_class20(:,3) = prob_word_in_class20(:,2)/total_words_in_class(20);
%format of above var of class : Word_ID,occurance,probability of occurance

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% done training %%%%%%%%%%%%%%%%%%%

total_betas = length(vocabulary) * 20
total_betas_mine = length(prob_word_in_class1)+length(prob_word_in_class1)+ ...
    length(prob_word_in_class1)+length(prob_word_in_class1)+length(prob_word_in_class1)+ ...
    length(prob_word_in_class1)+length(prob_word_in_class1)+length(prob_word_in_class1)+ ...
    length(prob_word_in_class1)+length(prob_word_in_class1)+length(prob_word_in_class1)+ ...
    length(prob_word_in_class1)+length(prob_word_in_class1)+length(prob_word_in_class1)+ ...
    length(prob_word_in_class1)+length(prob_word_in_class1)+length(prob_word_in_class1)+ ...
    length(prob_word_in_class1)+length(prob_word_in_class1)+length(prob_word_in_class1);

non_zero_beta = total_betas-total_betas_mine % non zero betas


%%%%%%%%%%%%%%%%% training %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear main_prediction
Unique = unique(test_data(:,1));

w = [1:5,330:335,730:735,1135:1140,1700:1705,2000:2005,2500:2505,2700:2705,3100:3105,3500:3505];

for k = 1: length(Unique)
    S = double(test_data(test_data(:,1)==Unique(k,1),:));
    
    normalize = 1e5;
    for j = 1:20
        prediction(j) = prob_y(j,1);
    end
    
    for i = 1 : length(S)
        
        try prob_word_in_class1((prob_word_in_class1(:,1)==S(i,2)),3) 
            prediction(1) =  prediction(1).* normalize .*((prob_word_in_class1((prob_word_in_class1(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(1) =0; % set this param to zero if you want to test bayes with zero'ed unknown Beta(wc)
        end
        
        try prob_word_in_class2((prob_word_in_class2(:,1)==S(i,2)),3)
            prediction(2) = prediction(2).* normalize .* ((prob_word_in_class2((prob_word_in_class2(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(2) =0;
        end
        
        try prob_word_in_class3((prob_word_in_class3(:,1)==S(i,2)),3)
            prediction(3) = prediction(3).*normalize .* ((prob_word_in_class3((prob_word_in_class3(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(3) =0;
        end
        
        try prob_word_in_class4((prob_word_in_class4(:,1)==S(i,2)),3) 
            prediction(4) = prediction(4).*normalize .* ((prob_word_in_class4((prob_word_in_class4(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(4) =0;
        end
        
        try prob_word_in_class5((prob_word_in_class5(:,1)==S(i,2)),3) 
            prediction(5) = prediction(5).*normalize .* ((prob_word_in_class5((prob_word_in_class5(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(5) =0;
        end
        
        try prob_word_in_class6((prob_word_in_class6(:,1)==S(i,2)),3) 
            prediction(6) = prediction(6).*normalize .* ((prob_word_in_class6((prob_word_in_class6(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(6) =0;
        end
        
        try prob_word_in_class7((prob_word_in_class7(:,1)==S(i,2)),3)
            prediction(7) = prediction(7).*normalize .* ((prob_word_in_class7((prob_word_in_class7(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
           prediction(7) =0;
        end
        
        try prob_word_in_class8((prob_word_in_class8(:,1)==S(i,2)),3) 
            prediction(8) = prediction(8).*normalize .* ((prob_word_in_class8((prob_word_in_class8(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(8) =0;
        end
        
        try prob_word_in_class9((prob_word_in_class9(:,1)==S(i,2)),3)
            prediction(9) = prediction(9).*normalize .* ((prob_word_in_class9((prob_word_in_class9(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(9) =0;
        end
        
        try prob_word_in_class10((prob_word_in_class10(:,1)==S(i,2)),3) 
            prediction(10) = prediction(10).*normalize .* ((prob_word_in_class10((prob_word_in_class10(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(10) =0;
        end
        
        try prob_word_in_class11((prob_word_in_class11(:,1)==S(i,2)),3) 
            prediction(11) = prediction(11).*normalize .* ((prob_word_in_class11((prob_word_in_class11(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(11) =0;
        end
        
        try prob_word_in_class12((prob_word_in_class12(:,1)==S(i,2)),3) 
            prediction(12) = prediction(12).*normalize .* ((prob_word_in_class12((prob_word_in_class12(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(12) =0;
        end
        
        try prob_word_in_class13((prob_word_in_class13(:,1)==S(i,2)),3) 
            prediction(13) = prediction(13).*normalize .* ((prob_word_in_class13((prob_word_in_class13(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(13) =0;
        end
        
        try prob_word_in_class14((prob_word_in_class14(:,1)==S(i,2)),3) 
            prediction(14) = prediction(14).*normalize .* ((prob_word_in_class14((prob_word_in_class14(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(14) =0;
        end
        
        try prob_word_in_class15((prob_word_in_class15(:,1)==S(i,2)),3) 
            prediction(15) = prediction(15).*normalize .* ((prob_word_in_class15((prob_word_in_class15(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(15) =0;
        end
        
        try prob_word_in_class16((prob_word_in_class16(:,1)==S(i,2)),3) 
            prediction(16) = prediction(16).*normalize .* ((prob_word_in_class16((prob_word_in_class16(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(16) =0;
        end
        
        try prob_word_in_class17((prob_word_in_class17(:,1)==S(i,2)),3) 
            prediction(17) = prediction(17).*normalize .* ((prob_word_in_class17((prob_word_in_class17(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(17) =0;
        end
        
        try prob_word_in_class18((prob_word_in_class18(:,1)==S(i,2)),3)
            prediction(18) =prediction(18).* normalize .* ((prob_word_in_class18((prob_word_in_class18(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(18) =0;
        end
        
        try prob_word_in_class19((prob_word_in_class19(:,1)==S(i,2)),3)
            prediction(19) = prediction(19).*normalize .* ((prob_word_in_class19((prob_word_in_class19(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(19) =0;
        end
        
        try prob_word_in_class20((prob_word_in_class20(:,1)==S(i,2)),3) 
            prediction(20) = prediction(20).*normalize .* ((prob_word_in_class20((prob_word_in_class20(:,1)==S(i,2)),3)).^(S(i,3)));
        catch
            prediction(20) =0;
        end
        
    end
   
    [value,main_predict] = max(prediction);

    if value ~= 0
        main_prediction(k,1) = main_predict;
    else
        main_prediction(k,1) = 0;
    end
    
end
cp = classperf(test_label(:,1),main_prediction);
cp.CorrectRate




