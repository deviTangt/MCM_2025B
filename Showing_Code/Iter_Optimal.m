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
