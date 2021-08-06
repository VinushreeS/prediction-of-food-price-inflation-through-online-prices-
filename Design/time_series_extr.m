%%  Date: 10.02.2019

%%  To extract time series data from the given categrial variables
function [fdata] = time_series_extr
src_path = 'G:\Client Info. and Progress Report\Institutes\2. Effent Technologies\1. Development\Projects 2018-2019\finalized projects\prj1\dataset\';
cd(src_path)
data = readtable('wfp_food_prices_bassas-da-india - Copy.csv');

%   To extract the time series for categorical variable
data.mktname = categorical(data.mktname);
data_beng = data(data.mktname == 'Mumbai',:); % Chennai, Delhi, Hyderabad, Mumbai, Bengaluru
data_cat = data.category;
[fnames] = unique(data_beng.cmname);

for cnt_cat = 1:size(fnames,1)
    %%   To extract timeseries for category - Rice-Retail

    data_beng.cmname = categorical(data_beng.cmname);
    [data_rice] = data_beng(data_beng.cmname == char(fnames{cnt_cat,1}),:); % 'Rice - Retail'
    date_rice_temp = data_rice.date;
    date_rice = struct;
    for cnt_rice = 1:size(data_rice,1)
        year_temp1 = cell2mat(date_rice_temp(cnt_rice,1));
        date_rice.year(cnt_rice) = str2num(year_temp1(end-1:end));
        date_rice.month(cnt_rice) = str2num(year_temp1(end-4:end-3));
    end
    fdata{cnt_cat,1} = char(unique(data_rice.cmname));    
    fdata{cnt_cat,2} = data_rice.price;
    fdata{cnt_cat,3} = char(unique(data_rice.category));
    fig_data = figure;
    plot(data_rice.price);
    title(char(fnames{cnt_cat,1}))
    ylabel('price')
    grid on; grid minor;
    saveas(fig_data,strcat('fig_',num2str(cnt_cat),'.jpg'));
%     legend(fnames)
%     hold on;
end
save fdata_signals fdata
% %%  To group food items as per categories
% fdata = cell2table(fdata);
% fdata.Properties.VariableNames = {'food_item','time_price','category'};
% fdata.category = categorical(fdata.category);
% fdata_fnames = unique(fdata.category);
% fdata.category = categorical(fdata.category);
% fdata_cat = struct;
% for cnt_cat1 = 1:size(fdata_fnames,1)
%     fdata_cat.(char(fdata_fnames(cnt_cat1,1))) = fdata(fdata.category == char(fdata_fnames{cnt_cat1,1}),:);
% end

    