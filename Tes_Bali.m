close; clear; clc;

% 检验
Check = 2;

Param;

if (Check == 1 || Check == 2)
[V, C] = C_Optimal_Bali(100, 100, 100, 1700)
end

if (Check == 1 || Check == 3)
    EISV = [100, 100, 100, 5];
    C = 4;
    V = 1.1;
    P = 0;
    [Emax, Imax, Smax, Vmax, w_alloction] = Iter_Optimal(EISV, C, V, P);
    [Emax, Imax, Smax, Vmax]
end