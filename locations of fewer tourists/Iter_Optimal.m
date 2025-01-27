function [Emax, Imax, Smax, Vmax, V_next, C_next, P_next] = Iter_Optimal(EISV, C, V, P);
     persistent Log_Enable; 
    Log_Enable = 0; 
    
     persistent beta;
     persistent gamma;
     persistent eta;
    % Alpha
    alpha = zeros(7);
    alpha(1, 2) = 0.0207;
    alpha(1, 3 : 5) = [5.6960, 7.7395, 18.8652];
    alpha(1 : 5, 6) = [3.237e-1, 0, 70 / C, 140 / C, 90 / C]';
    alpha(1, 7) = 5.339;
    % Beta
    beta = zeros(7);
    beta(1, 2) = 2.16;
    beta(1, 3 : 5) = [1, 1, 1];
    beta(1 : 5, 6) = [3, 1, 1, 1, 1]';
    beta(1, 7) = 2.149;
    % Gamma
    gamma = zeros(7);
    gamma(6, 1) = 2.392e-4;
    gamma(1, 3 : 5) = [0.1001, 0.0715, 0.1285] / 12;
    gamma(7, 3 : 5) = [0.0952, 0.1177, 0.1120] / 240;
    % Eta
    eta = zeros(7);
    eta(6, 1) = 1;
    eta(1, 3 : 5) = [1, 1, 1];
    eta(7, 3 : 5) = [1, 1, 1];
    Policy_Constrait = 70;

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
            P_cur = P - Policy_Constrait - alpha(1, 6) * V^beta(1, 6) + alpha(3, 6) * C_E^beta(3, 6) + alpha(4, 6) * C_I^beta(4, 6) + alpha(5, 6) * C_S^beta(5, 6);
            P_cur;
            Emax_cur = EISV(1, 1) - gamma(1, 3) * V^eta(1, 3) + gamma(7, 3) * C_E^eta(7, 3) - rand(1, 1) / 10;
            Imax_cur = EISV(1, 2) - gamma(1, 4) * V^eta(1, 4) + gamma(7, 4) * C_I^eta(7, 4) - rand(1, 1) / 10;
            Smax_cur = EISV(1, 3) - gamma(1, 5) * V^eta(1, 5) + gamma(7, 5) * C_S^eta(7, 5) - rand(1, 1) / 10;
            Vmax_cur = EISV(1, 4) + gamma(6, 1) * P_cur^eta(6, 1) - rand(1, 1) / 100;
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
                P_next = P_cur;
                
                if (Log_Enable == 1)
                    fprintf('--New Allocation Detectied\n');
                    fprintf('V:%.3e\t   C:%.3e\t\tw:%d\t%d\t%d\n', V_next, C_next, round(w_E * 100), round(w_I * 100), round((1 - w_E - w_I) * 100));
                end
            end
            if (Log_Enable == 1) fprintf('Optimization Count：%d\n', Count); end
        end
    end
    end
    w = mark_w;
    fprintf('  Final allocation ratio of C ---- C_E:%.2f / C_I:%.2f / C_S:%.2f\n', w(1), w(2), w(3));
    fprintf('  expenditure ---- C_E:%.2f\tC_I:%.2f\tC_S:%.2f\n', w(1) * C / 100, w(2) * C / 100, w(3) * C / 100);
    fprintf('              ---- P:%.2f\n', P_next);
    
    if (Log_Enable == 1 || Log_Enable == 2)
        Emax = EISV(1, 1) - gamma(1, 3) * V^eta(1, 3) + gamma(7, 3) * (w(1) * C)^eta(7, 3);
        Imax = EISV(1, 2) - gamma(1, 4) * V^eta(1, 4) + gamma(7, 4) * (w(2) * C)^eta(7, 4);
        Smax = EISV(1, 3) - gamma(1, 5) * V^eta(1, 5) + gamma(7, 5) * (w(3) * C)^eta(7, 5);
        Vmax = EISV(1, 4) + gamma(6, 1) * P^eta(6, 1);
        fprintf('Emax:%.3f\tImax:%.3f\tSmax:%.3f\tVmax:%.3f\n', Emax, Imax, Smax, Vmax);
    end
end
