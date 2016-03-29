%load('data_SFcrime_test.mat');
load('data_SFcrime_train.mat');
H = hour(Dates);


keySet_days =   {'Sunday','Monday', 'Tuesday', 'Wednesday', 'Thursday','Friday','Saturday'};
valueSet_days = {[1 zeros(1,6)], [0 1 zeros(1,5)] , [0 0 1 zeros(1,4)],[zeros(1,3) 1 zeros(1,3)],[zeros(1,4) 1 0 0],[zeros(1,5) 1 0],[zeros(1,6) 1]};
mapObj_days = containers.Map(keySet_days,valueSet_days);

days_vec = values(mapObj_days, DayOfWeek); % days in vector form
 
keySet_hours =   {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
valueSet_hours = {[1 zeros(1,23)], [0 1 zeros(1,22)],[0 0 1 zeros(1,21)]...
    [0 0 0 1 zeros(1,20)],[0 0 0 0 1 zeros(1,19)]...
    [0 0 0 0 0 1 zeros(1,18)]...
    [zeros(1,6) 1 zeros(1,17)], [zeros(1,7) 1 zeros(1,16)], [zeros(1,8) 1 zeros(1,15)]...
    [zeros(1,9) 1 zeros(1,14)], [zeros(1,10) 1 zeros(1,13)],[zeros(1,11) 1 zeros(1,12)]...
    [zeros(1,12) 1 zeros(1,11)],[zeros(1,13) 1 zeros(1,10)],[zeros(1,14) 1 zeros(1,9)]...
    [zeros(1,15) 1 zeros(1,8)], [zeros(1,16) 1 zeros(1,7)], [zeros(1,17) 1 zeros(1,6)]...
    [zeros(1,18) 1 zeros(1,5)], [zeros(1,19) 1 zeros(1,4)], [zeros(1,20) 1 zeros(1,3)]...
    [zeros(1,21) 1 zeros(1,2)],[zeros(1,22) 1 0],[zeros(1,23) 1]};
mapObj_hours = containers.Map(keySet_hours,valueSet_hours);
H = num2cell(H);

hours_vec = values(mapObj_hours, H); % hours in vector form



keySet_districts =  {'NORTHERN','PARK','INGLESIDE','BAYVIEW','RICHMOND','CENTRAL','TARAVAL','TENDERLOIN','MISSION','SOUTHERN'};
valueSet_districts = {[1 zeros(1,9)], [0 1 zeros(1,8)],[0 0 1 zeros(1,7)]...
     [0 0 0 1 zeros(1,6)],[0 0 0 0 1 zeros(1,5)], [0 0 0 0 0 1 zeros(1,4)]...
    [zeros(1,6) 1 zeros(1,3)], [zeros(1,7) 1 zeros(1,2)], [zeros(1,8) 1 0], [zeros(1,9) 1]};
mapObj_districts = containers.Map(keySet_districts,valueSet_districts);
 
districts_vec = values(mapObj_districts,PdDistrict);
 
%%%%%%%%%%% this is the main train vector
main_vec_train = cat(2,logical(cell2mat(hours_vec)),logical(cell2mat(days_vec)),logical(cell2mat(districts_vec)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% for testing data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H_test = hour(Dates_test);

days_vec_test = values(mapObj_days, DayOfWeek_test); % days in vector form
H_test = num2cell(H_test);
hours_vec_test = values(mapObj_hours, H_test); % hours in vector form
districts_vec_test = values(mapObj_districts,PdDistrict_test);

%%%%%%%%%%%this is the test vector
main_vec_test = cat(2,logical(cell2mat(hours_vec_test)),logical(cell2mat(days_vec_test)),logical(cell2mat(districts_vec_test)));

