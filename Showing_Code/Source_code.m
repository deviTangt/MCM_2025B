%/***********************************************%
%   Filename: Simulation_Iter.m                  %
%   Author:   Devi Tang                          %
%   Function: TestBanch                          %
%***********************************************/%
close; clear; clc;

EISV0 = [100, 100, 100, 16];
C0 = 4; V0 = 0; P0 = 0;
C = C0; V = V0; P = P0;
Max_Iter_Num = 300;
Iter_count = 0;
Iter_eps_count = 0;
EISV_array = zeros(Max_Iter_Num + 1, 4);
EISV_array(1, :) = EISV0;
V_array = zeros(Max_Iter_Num + 1, 1);
C_array = zeros(Max_Iter_Num + 1, 1);
eps = 1e-3;
C_1 = eps; C_2 = 0;

Final_GrossProfit = 0;

while (Iter_count < Max_Iter_Num) 
    Iter_count = Iter_count + 1;
    [Emax, Imax, Smax, Vmax, V_next, C_next] = Iter_Optimal(EISV_array(Iter_count, :), C, V, P);
    V = V_next;
    C = C_next;
    EISV_array(Iter_count + 1, :) = [Emax, Imax, Smax, Vmax];
    V_array(Iter_count + 1, 1) = V_next;
    C_array(Iter_count + 1, 1) = C_next;
    [V_cur, C_cur] = C_Optimal(Emax, Imax, Smax, Vmax);
                V_cur * 10, C_cur / 100, Iter_eps_count);
    C_1 = C_2; C_2 = C_next;
    if (C_2 - C_1 < eps) 
        Iter_eps_count = Iter_eps_count + 1;
    else
        Iter_eps_count = 0;
    end

    if ((Iter_eps_count >= 20 || Iter_count == Max_Iter_Num) ...
            && Emax >= 1.1 * EISV0(1) && Imax >= 1.1 * EISV0(2) && Smax >= 1.1 * EISV0(3)) 
         syms C_E C_I C_S;
        equ_CE = - gamma(1, 3) * V^eta(1, 3) + gamma(7, 3) * C_E^eta(7, 3);
        equ_CI = - gamma(1, 4) * V^eta(1, 4) + gamma(7, 4) * C_I^eta(7, 4);
        equ_CS = - gamma(1, 5) * V^eta(1, 5) + gamma(7, 5) * C_S^eta(7, 5);
        Maintance_C_E = solve(equ_CE);
        Maintance_C_I = solve(equ_CI);
        Maintance_C_S = solve(equ_CS);
        Final_GrossProfit = C_next - Maintance_C_E - Maintance_C_I - Maintance_C_S;
        break;
    end
end
R = k_R * V - alpha(1, 2) * V^beta(1, 2);
Cost = k_C * V + alpha(1, 7) * V^beta(1, 7); 

%/***********************************************************%
%   Filename: Iter_Optimal.m                                 %
%   Author:   Devi Tang                                      %
%   Function: Optimaize Allocation of C using equation (4)   %
%***********************************************************/%

function [Emax, Imax, Smax, Vmax, V_next, C_next] = Iter_Optimal(EISV, C, V, P);
    Param; % Get k_R, k_C, alpha, beta, gamma, eta parameter from Param.m

    mark_w = zeros(1, 3);
    mark_C = 0;
    if (C ~= 0)
    Count = 0;
    for w_E = 0.00 : 0.1 : 1.00
        C_E = w_E * C;
        for w_I = 0.00 : 0.1 : (1.00 - w_E)
            Count = Count + 1;
            C_I = w_I * C;
            C_S = C - C_E - C_I;
            Emax_cur = EISV(1, 1) - gamma(1, 3) * V^eta(1, 3) + gamma(7, 3) * C_E^eta(7, 3);
            Imax_cur = EISV(1, 2) - gamma(1, 4) * V^eta(1, 4) + gamma(7, 4) * C_I^eta(7, 4);
            Smax_cur = EISV(1, 3) - gamma(1, 5) * V^eta(1, 5) + gamma(7, 5) * C_S^eta(7, 5);
            Vmax_cur = EISV(1, 4) + gamma(6, 1) * P^eta(6, 1);
            [Emax_cur, Imax_cur, Smax_cur];
            [V_cur, C_cur] = C_Optimal(Emax_cur, Imax_cur, Smax_cur, Vmax_cur);
            
            if (C_cur > mark_C) 
                mark_C = C_cur;
                mark_w = [w_E, w_I, 1 - w_E - w_I];
                Emax = Emax_cur; 
                Imax = Imax_cur; 
                Smax = Smax_cur; 
                Vmax = Vmax_cur;
                V_next = V_cur;
                C_next = C_cur;           
            end
        end
    end
    end
    w = mark_w;
end

%/*******************************************************************%
%   Filename: C_Optimal.m                                            %
%   Author:   Devi Tang                                              %
%   Function: Optimaize Num of V to maximize C using equation (3)    %
%*******************************************************************/%

function [V, C] = C_Optimal(Emax, Imax, Smax, Vmax);
    Param; % Get k_R, k_C, alpha, beta, gamma, eta parameter from Param.m
    
    % R = @(V)k_R * V - alpha(1, 2) * V^beta(1, 2);
    % Cost = @(V)k_C * V + alpha(1, 7) * V^beta(1, 7); 
    % C = R - Cost

    cal_C = @(V)-(k_R * V - alpha(1, 2) * V^beta(1, 2) ...
                - k_C * V - alpha(1, 7) * V^beta(1, 7));
    A = [alpha(1, 3), alpha(1, 4)]';
    b = [Emax, Imax]';
    Aeq = [];
    beq = [];
    lb = 0;   ub = Vmax;
    options = optimoptions('fmincon','Display','notify'); 
    [V, C] = fmincon(cal_C, 9, A, b, Aeq, beq, lb, ub, @(V)nonlcon(V, Smax), options);
    C = -C;
end

function [g, h] = nonlcon(V, Smax);
     persistent alpha_VS;
    alpha_VS = [0    4.4759   18.8652];
     persistent EdgePoint;
    EdgePoint = [24150, 53520] * 1e-4;
    g =  alpha_VS(1) * V + (alpha_VS(2) - alpha_VS(1)) * (V - EdgePoint(1)) * heaviside(V - EdgePoint(1)) ...
          + (alpha_VS(3) - alpha_VS(2) - alpha_VS(1)) * (V - EdgePoint(2)) * heaviside(V - EdgePoint(2)) ...
          - Smax;
    h = [];
end
