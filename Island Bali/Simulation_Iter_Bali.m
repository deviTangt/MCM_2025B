close; clear; clc;
% 读取参数
Param_Bali;
    
% 检验
Check = 4;

if (Check == 1 || Check == 2)
[V, C] = Tourism_Optimal(100, 100, 100, 3)
end
if (Check == 1 || Check == 3)
    EISV = [100, 100, 100, 5];
    C = 4;
    V = 1.1;
    P = 0;
    [Emax, Imax, Smax, Vmax, V_next, C_next] = Iter_Optimal(EISV, C, V, P);
    [Emax, Imax, Smax, Vmax]
end
if (Check == 4)
    EISV0 = [100, 100, 100, 150];
    %EISV0 = [106.629, 104.135, 92.644, 150];	
    C0 = 4; V0 = 0; P0 = 0;
    C = C0; V = V0; P = P0;
    Max_Iter_Num = 500;
    Iter_count = 0;
    Iter_eps_count = 0;
    EISV_array = zeros(Max_Iter_Num + 1, 4);
    EISV_array(1, :) = EISV0;
    V_array = zeros(Max_Iter_Num + 1, 1);
    C_array = zeros(Max_Iter_Num + 1, 1);
    % 精度检验
    eps = 1e-1;
    C_1 = eps; C_2 = 0;
    
    Final_GrossProfit = 0;
    
    while (Iter_count < Max_Iter_Num) 
        Iter_count = Iter_count + 1;
        [Emax, Imax, Smax, Vmax, V_next, C_next] = Iter_Optimal_Bali(EISV_array(Iter_count, :), C, V, P);
        V = V_next;
        C = C_next;
        EISV_array(Iter_count + 1, :) = [Emax, Imax, Smax, Vmax];
        V_array(Iter_count + 1, 1) = V_next;
        C_array(Iter_count + 1, 1) = C_next;
        fprintf('Iter%2d --- Emax:%.3f\tImax:%.3f\tSmax:%.3f\tVmax:%.3f k\n',...
                    Iter_count, Emax, Imax, Smax, Vmax * 10);
        [V_cur, C_cur] = C_Optimal_Bali(Emax, Imax, Smax, Vmax);
        fprintf('\t\t\t --- V:%.3f k\tC:%.3fM Dollars\t  eps%d\n',...
                    V_cur * 10, C_cur / 100, Iter_eps_count);
        C_1 = C_2; C_2 = C_next;
        if (C_2 - C_1 < eps) 
            Iter_eps_count = Iter_eps_count + 1;
        else
            Iter_eps_count = 0;
        end
        
        if (Iter_count == Max_Iter_Num || (Iter_eps_count >= 20 ...
                && Emax >= 1.1 * EISV0(1) && Imax >= 1.1 * EISV0(2) && Smax >= 1.1 * EISV0(3))) 
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
    fprintf('\nEventually:\nEmax:%.3f\tImax:%.3f\tSmax:%.3f\tVmax:%.3f thousand / month\n',...
                    Emax, Imax, Smax, Vmax * 10);
    R = k_R * V - alpha(1, 2) * V^beta(1, 2);
    Cost = k_C * V + alpha(1, 7) * V^beta(1, 7); 
    fprintf('Revenue of Tourism：%.3f million dollars / month\tManagement cost：%.3f million dollars / month\n', R / 100, Cost / 100);
    fprintf('Sustainability maintenance expenditur CE:%.3f\tCI:%.3f\tCS:%.3f million dollars / month\n',...
                    Maintance_C_E / 100, Maintance_C_I / 100, Maintance_C_S / 100);
    fprintf('Final Profit：%.3f million dollars / month\n', Final_GrossProfit / 100);
    X = [0 : Iter_count];
    
    subplot(3, 1, 1);
    plot(X, EISV_array(1 : Iter_count + 1, 1)', 'r', X, EISV_array(1 : Iter_count + 1, 2)', 'b', X, EISV_array(1 : Iter_count + 1, 3)', 'g');
    legend('Emax', 'Imax', 'Smax'), xlabel('Iterative number'), ylabel('EIS maximum');
    grid on;
    
    subplot(3, 1, 2);
    plot(X, 10 .* V_array(1 : Iter_count + 1, 1)', 'r');
    legend('X'), xlabel('Iterative number'), ylabel('Travellers Num V / (k / month)');
    grid on;
    
    subplot(3, 1, 3);
    plot(X, C_array(1 : Iter_count + 1, 1)', 'r');
    legend('C'), xlabel('Iterative number'), ylabel('Extra expenditure C / (M $ / month)');
    grid on;
end


