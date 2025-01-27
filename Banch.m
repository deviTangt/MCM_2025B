close; clear; clc;

% Gamma
    gamma = zeros(7);
    gamma(6, 1) = 3;
    gamma(1, 3 : 5) = [0.1001, 0.0715, 0.1285] / 12;
    gamma(7, 3 : 5) = [0.0952, 0.1777, 0.1120];
% Eta
    eta = zeros(7);
    eta(6, 1) = 1.2;
    eta(1, 3 : 5) = [1, 1, 1];
    eta(7, 3 : 5) = [1, 1, 1];
V = 9;
C_next = 90;

syms C_E C_I C_S;
equ_CE = - gamma(1, 3) * V^eta(1, 3) + gamma(7, 3) * C_E^eta(7, 3);
equ_CI = - gamma(1, 4) * V^eta(1, 4) + gamma(7, 4) * C_I^eta(7, 4);
equ_CS = - gamma(1, 5) * V^eta(1, 5) + gamma(7, 5) * C_S^eta(7, 5);
Maintance_C_E = solve(equ_CE);
Maintance_C_I = solve(equ_CI);
Maintance_C_S = solve(equ_CS);
Final_GrossProfit = C_next - Maintance_C_E - Maintance_C_I - Maintance_C_S;
Final_GrossProfit
    
    