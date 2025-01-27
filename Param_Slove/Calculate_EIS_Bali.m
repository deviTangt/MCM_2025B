% [E, I, S] = Calculate_EIS(1.3e+4)
function [E, I, S] = Calculate_EIS_Bali(V);
    % 读取相应数据
    EIS;
    
    % E
    E = 9.3493 / 1700 * V * Daily_Traveller_CarbonFootprint / (Max_year_GlacierMelting / Rate_GlacierMelting_with_Carbon / 365) * 100;

    % I
    I_water = 9.3881 / 1700 * V * Daily_DrinkWater_Consumption / (Juneau_DrinkWaterMax / 365 - Juneau_population * Daily_DrinkWater_Consumption) * 100;
    I_waste = 10.9287 / 1700 * V * Daily_Traveller_Waste / (Juneau_WasteHandle - Juneau_ResidentialWaste) * 100;
    I_carbon = 9.3493 / 1700 * V * Daily_Traveller_CarbonFootprint / (Max_year_GlacierMelting / Rate_GlacierMelting_with_Carbon / 365) * 100;
    [I_water I_waste I_carbon];
    I = sum(w_I .* [I_water I_waste I_carbon]);
    
    % S
    Rate_housing_Duty = (12.1019 / 1700 * V + Juneau_population) / Avaliable_housing_capacity;
    Rate_housing_Duty;
    if (Rate_housing_Duty <= Comfortale_housing_avaliable) 
        S_housing_capacity = 0;
    elseif (Rate_housing_Duty <= SenstiveRate_housing_avaliable) 
        S_housing_capacity = (Rate_housing_Duty - Comfortale_housing_avaliable) / (SenstiveRate_housing_avaliable - Comfortale_housing_avaliable) * 100;
    else
        S_housing_capacity = (Rate_housing_Duty - Comfortale_housing_avaliable) / (SenstiveRate_housing_avaliable - Comfortale_housing_avaliable) * 100;
    end
    S_housing_capacity;
    if (11.117e+4 / 1700 * V <= 24000) Month_housing_price = 0;
    else Month_housing_price = 11.117e+4 / 1700 * 144.6 * V^0.2397;  end
    Month_housing_price;
    S_housing_price = (Month_housing_price - Normal_housing_price) / (Max_Acceptable_housing_price - Normal_housing_price) * 100 ...
                         * heaviside(Month_housing_price - Normal_housing_price);
    S_crowded_noised = (9.2824 / 1700 * V - Acceptable_TravellersNum_crowded_noised) / (Max_PuttingUpWith_TravellersNum_crowded_noised - Acceptable_TravellersNum_crowded_noised) * 100 ...
                        * heaviside(V - Acceptable_TravellersNum_crowded_noised);
    [S_housing_capacity S_housing_price S_crowded_noised];
    S = sum(w_S .* [S_housing_capacity S_housing_price S_crowded_noised]);
    
end