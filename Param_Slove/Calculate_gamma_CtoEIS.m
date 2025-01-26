clear; clc;

% 读取数据
EIS;

Upgrade_C_E = 1500; % 万美元
Project_CarbonFootPrintUpgrade = 0.7;

Project_C_I = [2500, 1500, 1500]; % 万美元
Project_WaterSupplyUpgrade = 300 / 350; % kg / day
Project_WasteHandleUpgrade = 10000; % kg / day

Project_C_S = [1600 / 2, 1600 / 2, 1650]; % 万美元
Project_HousingCapacityUpgrade = 18 * 300; % 人数
Project_HousingPriceUpgrade = 18 * 300; % 
Project_CrowdedNoisedUpgrade = 0.9; % 

gamma_CE = (100 / Project_CarbonFootPrintUpgrade) / Upgrade_C_E;
gamma_CI = (w_I(1) * 100 / Project_WaterSupplyUpgrade) / Project_C_I(1) ...
         + (w_I(2) * 100 / (Project_WasteHandleUpgrade / Juneau_WasteHandle)) / Project_C_I(2) ...
         + (w_I(3) * 100 / Project_CarbonFootPrintUpgrade) / Project_C_I(3);
gamma_CS = (w_S(1) * 100 / (Project_HousingCapacityUpgrade / Avaliable_housing_capacity)) * (SenstiveRate_housing_avaliable - Comfortale_housing_avaliable) / Project_C_S(1) ...
         + (w_S(2) * 100 / (Project_HousingPriceUpgrade / Avaliable_housing_capacity)) * (SenstiveRate_housing_avaliable - Comfortale_housing_avaliable) / Project_C_S(2) ...
         + (w_S(3) * 100 / Project_CrowdedNoisedUpgrade) / Project_C_S(3);
[gamma_CE, gamma_CI, gamma_CS]
%     0.0952    0.1777    0.1120

eta_CE = 1;
eta_CI = 1;
eta_CS = 1;


