function [V, C] = C_Optimal(Emax, Imax, Smax, Vmax);
     persistent Check_EISRC; Check_EISRC = 0;
     
     persistent k_R;
     persistent k_C;
     persistent alpha;
     persistent beta;
    % K
    k_R = 247.11;
    k_C = 72.67;
    % Alpha
    alpha = zeros(7);
    alpha(1, 2) = 0.0207;
    alpha(1, 3 : 5) = [10.6960, 7.7395, 18.8652];
    alpha(1 : 5, 6) = [10, 5, 20, 15, 10]';
    alpha(1, 7) = 5.339;
    % Beta
    beta = zeros(7);
    beta(1, 2) = 2.16;
    beta(1, 3 : 5) = [1, 1, 1];
    beta(1 : 5, 6) = [1.2, 1.1, 1.3, 1.2, 1.1]';
    beta(1, 7) = 2.149;
    
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
    
    if (Check_EISRC == 1)
        V_ = V;
         persistent alpha_VS;
        alpha_VS = [0    4.4759   18.8652];
         persistent EdgePoint;
        EdgePoint = [24150, 53520] * 1e-4;
        % E，I，S验证
        EIS = [alpha(1, 3), alpha(1, 4), 0] * V_;
        EIS(3) = alpha_VS(1) * V_ + (alpha_VS(2) - alpha_VS(1)) * (V_ - EdgePoint(1)) * heaviside(V_ - EdgePoint(1)) ...
                     + (alpha_VS(3) - alpha_VS(2) - alpha_VS(1)) * (V_ - EdgePoint(2)) * heaviside(V_ - EdgePoint(2));
        % R, Cost
        R = k_R * V_ - alpha(1, 2) * V_^beta(1, 2);
        Cost = k_C * V_ + alpha(1, 7) * V_^beta(1, 7); 
        % C = R - Cost
        EIS
        R
        Cost
    end
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