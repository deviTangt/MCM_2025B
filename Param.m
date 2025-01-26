% 参数存放文件
%Initialization
Emax_0 = 100;
Imax_0 = 100;
Smax_0 = 100;

% K
k_R = 247.11;
k_C = 72.67;
% Alpha
alpha = zeros(7);
alpha(1, 2) = 0.0207;
alpha(1, 3 : 5) = [35.65, 27.70, 83.55];
alpha(1 : 5, 6) = [10, 5, 20, 15, 10]';
alpha(1, 7) = 11.84;
% Beta
beta = zeros(7);
beta(1, 2) = 2.16;
beta(1, 3 : 5) = [1, 1, 1];
beta(1 : 5, 6) = [1.2, 1.1, 1.3, 1.2, 1.1]';
beta(1, 7) = 2.149;
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




