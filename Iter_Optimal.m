function [Emax, Imax, Smax, Vmax, w] = Iter_Optimal(EISV, C, V, P);
     persistent gamma;
     persistent eta;
    % Gamma
    gamma = zeros(7);
    gamma(6, 1) = 3;
    gamma(1, 3 : 5) = [0.1001, 0.0715, 0.1285];
    gamma(7, 3 : 5) = [0.0952, 0.1777, 0.1120];
    % Eta
    eta = zeros(7);
    eta(6, 1) = 1.2;
    eta(1, 3 : 5) = [1, 1, 1];
    eta(7, 3 : 5) = [1, 1, 1];

    mark_w = zeros(1, 3);
    mark_C = 0;
    if (C ~= 0)
    Count = 0;
    for w_E = 0.10 : 0.1 : 1.00
        C_E = w_E * C;
        for w_I = 0.00 : 0.1 : (1.00 - w_E)
            Count = Count + 1;
            C_I = w_I * C;
            C_S = C - C_E - C_I;
            Emax = EISV(1, 1) - gamma(1, 3) * V^eta(1, 3) + gamma(7, 3) * C_E^eta(7, 3);
            Imax = EISV(1, 2) - gamma(1, 4) * V^eta(1, 4) + gamma(7, 4) * C_I^eta(7, 4);
            Smax = EISV(1, 3) - gamma(1, 5) * V^eta(1, 5) + gamma(7, 5) * C_S^eta(7, 5);
            Vmax = EISV(1, 4) + gamma(6, 1) * P^eta(6, 1);
            [Emax, Imax, Smax];
            [V_cur, C_cur] = Tourism_Optimal(Emax, Imax, Smax, Vmax);
            if (C_cur > mark_C) 
                mark_C = C_cur;
                mark_w = [w_E, w_I, 1 - w_E - w_I];
                fprintf('--New Allocation Detectied\n');
                fprintf('V:%d\tC:%d\t\tw:%d\t%d\t%d\n', V_cur, C_cur, round(w_E * 100), round(w_I * 100), round((1 - w_E - w_I) * 100));
            end
            fprintf('优化计数：%d\n', Count);
        end
    end
    end
    w = mark_w;
    fprintf('最终C分配比例---- C_E:%f / C_I:%f / C_S:%f\n', w(1), w(2), w(3));

    if 1==1
        Emax = EISV(1, 1) - gamma(1, 3) * V^eta(1, 3) + gamma(7, 3) * (w(1) * C)^eta(7, 3)
        Imax = EISV(1, 2) - gamma(1, 4) * V^eta(1, 4) + gamma(7, 4) * (w(2) * C)^eta(7, 4)
        Smax = EISV(1, 3) - gamma(1, 5) * V^eta(1, 5) + gamma(7, 5) * (w(3) * C)^eta(7, 5)
        Vmax = EISV(1, 4) + gamma(6, 1) * P^eta(6, 1)
    end
end
