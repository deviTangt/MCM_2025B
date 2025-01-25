% [E, I, S] = Calculate_EIS(1.3e+4)
function [E, I, S] = Calculate_EIS(V);
    % 读取相应数据
    EIS;
    
    % E
    E = V * Daily_Traveller_CarbonFootprint / (Max_year_GlacierMelting / Rate_GlacierMelting_with_Carbon / 365) * 100;

    % I
    I_water = V * Daily_DrinkWater_Consumption / (Juneau_DrinkWaterMax / 365 - Juneau_population * Daily_DrinkWater_Consumption) * 100;
    I_waste = V * Daily_Traveller_Waste / (Juneau_WasteHandle - Juneau_ResidentialWaste) * 100;
    I_carbon = V * Daily_Traveller_CarbonFootprint / (Max_year_GlacierMelting / Rate_GlacierMelting_with_Carbon / 365) * 100;
    [I_water I_waste I_carbon];
    I = sum(w_I .* [I_water I_waste I_carbon]);
    
    % S
    Rate_housing_Duty = (V + Juneau_population) / Avaliable_housing_capacity;
    Rate_housing_Duty;
    if (Rate_housing_Duty <= Comfortale_housing_avaliable) 
        S_housing_capacity = 0;
    elseif (Rate_housing_Duty <= SenstiveRate_housing_avaliable) 
        S_housing_capacity = (Rate_housing_Duty - Comfortale_housing_avaliable) / (SenstiveRate_housing_avaliable - Comfortale_housing_avaliable) * 100;
    else
        S_housing_capacity = (Rate_housing_Duty - Comfortale_housing_avaliable) / (SenstiveRate_housing_avaliable - Comfortale_housing_avaliable) * 100;
    end
    S_housing_capacity;
    if (V <= 6000) Month_housing_price = 0;
    else Month_housing_price = 192.9 * V^0.2397;  end
    Month_housing_price;
    if (Month_housing_price <= Normal_housing_price)
        S_housing_price = 0;
    else
        S_housing_price = (Month_housing_price - Normal_housing_price) / (Max_Acceptable_housing_price - Normal_housing_price) * 100;
    end
    S_crowded_noised = V / Max_PuttingUpWith_TravellersNum_crowded_noised * 100;
    [S_housing_capacity S_housing_price S_crowded_noised];
    S = sum(w_S .* [S_housing_capacity S_housing_price S_crowded_noised]);
    
end