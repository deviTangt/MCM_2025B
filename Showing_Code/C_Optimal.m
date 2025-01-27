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