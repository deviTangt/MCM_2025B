%V = 1.1e+4;  
Juneau_population = 31246;

%E  Vmax 28048 -> 100
Juneau_year_CarbonFootprint = [200 : 5 : 315] * 1e+6; % kg CO2 / year
Juneau_year_GlacierMelting = [5, 5, [5 : 27]] * 1e-2;
Rate_GlacierMelting_with_Carbon = sum(Juneau_year_GlacierMelting) / sum(Juneau_year_CarbonFootprint);
Rate_GlacierMelting_with_Carbon; % k_E
Max_year_GlacierMelting = 0.10; % not max(Juneau_year_GlacierMelting);
Daily_Traveller_CarbonFootprint = 15.97; % kg CO2 / day / person
% test Max_year_GlacierMelting / Rate_GlacierMelting_with_Carbon / 365 / Daily_Traveller_CarbonFootprint;


% I_water Vmax 30973 -> 100
Juneau_DrinkWaterMax = 4542e+6; % 升 / 年
Daily_DrinkWater_Consumption = 200; % 升 / 天 / 日


% I_waste Vmax 54636 -> 100
Juneau_WasteHandle = 90718; % kg / day
Juneau_ResidentialWaste = 7985 * 1000 / 365;  % kg / day
Daily_Traveller_Waste = 1.260; % kg / dag / person

% I_carbon Vmax 28048 -> 100
Juneau_WasteHandle = 90718; % kg / day
Juneau_ResidentialWaste = 7985 * 1000 / 365;  % kg / day
Daily_Traveller_Waste = 1.260; % kg / dag / person

% I considering I_water, I_waste and I_carbon
w_I = [0.3 0.4 0.3];


% S_housing_capacity Vmax 14000 -> 100
Avaliable_housing_capacity = Juneau_population * 1 + 987 * 5 + 391 * 20 + 0.17 * 951400 / 4.2 * 120 / 365;
Comfortale_housing_avaliable = 0.7;
SenstiveRate_housing_avaliable = 0.8;
            
% S_housing_price   Vmax 16000 -> 200
%Juneau_month_housing_price = [16 16 17 18 22 25 27 24 22 18 17 16 ...
%                             17 17 18 19 23 26 28 25 23 19 18 17] * 1e+2;
                            % 22年、23年数据
%Juneau_month_traveller_num = [12 10.5 11 15 30 50 60 45 20 10 8 10.5 ...
%                             10 8.5 9 12 25 50 65 40 15 10 9 10.5] * 1e+3;
% 拟合得 Juneau_month_housing_price = 192.9 * Juneau_month_traveller_num^0.2397;
Normal_housing_price = 1561; % $ / month
Max_Acceptable_housing_price = 2342; % $ / month


% S_crowded_noised
Max_PuttingUpWith_TravellersNum_crowded_noised = 16000;

% S considering S_housing_capacity, S_housing_price and S_crowded_noised
w_S = [0.3 0.4 0.3];
 


