%%  Date: 17.03.2019

%%  To add missing data by taking average

[fdata] = time_series_extr;
%   To find maximum range
for cnt_range = 1:size(fdata,1)
    fdata_range(cnt_range,1) = size(fdata{cnt_range,2},1);
end
fdata_range_max = max(fdata_range);
    
    
for cnt = 1:size(fdata,1)
    fdata{cnt,4} = mean(fdata{cnt,2});
    %   create zero padding and add mean values to it
    fdata_maxran = fdata_range_max - size(fdata{cnt,2},1);
    fdata_temp = ones(fdata_maxran,1)*fdata{cnt,4};
    fdata{cnt,5} = [fdata{cnt,2};fdata_temp];
    clear fdata_temp;
end
%%  To prepare data
fdata_DATA = fdata(:,5);
fdata_num = cell2mat(fdata_DATA');
fdata_num = fdata_num';
save ('DATA_num.txt','fdata_num','-ascii');
fdata_DATA(:,end+1) = fdata(:,3);
DATA = cell2table(fdata_DATA);
writetable(DATA,'Data_mumbai.csv')
save results_mat fdata fdata_DATA 

