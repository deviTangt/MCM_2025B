
% Gamma
gamma = zeros(7);
gamma(6, 1) = 3;
gamma(1, 3 : 5) = [1, 1.5, 1];
gamma(7, 3 : 5) = [2, 2.5, 2];
% Eta
eta = zeros(7);
eta(6, 1) = 1.2;
eta(1, 3 : 5) = [1.2, 1.3, 1.1];
eta(7, 3 : 5) = [1.1, 1.2, 1.1];

Emax_0 = 100; Imax_0 = 100; Smax_0 = 100;


Max_Iteration_Num = 20;
Iter_Count = 0;
while (Iter_Count < Max_Iteration_Num) 
    Iter_Count = Iter_Count + 1;
    Emax = Emax - gamma(1, 3) * V^eta(1, 3) + gamma(7, 3) * C_E^eta(7, 3);
    Imax = Imax - gamma(1, 4) * V^eta(1, 4) + gamma(7, 4) * C_I^eta(7, 4);
    Smax = Smax - gamma(1, 5) * V^eta(1, 5) + gamma(7, 5) * C_S^eta(7, 5);
    Vmax = Vmax + gamma(6, 1) * P^eta(6, 1);
end


