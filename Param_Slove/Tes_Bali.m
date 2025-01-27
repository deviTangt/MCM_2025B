close; clear; clc;

V = [0 : 0.001 : 4]' * 9 / 1700 * 3 * 1e+4;
E = zeros(size(V, 1), 1); 
I = zeros(size(V, 1), 1); 
S = zeros(size(V, 1), 1); 
for i = 1 : 4001
    [E(i), I(i), S(i)] = Calculate_EIS_Bali(V(i));
end
[V, E, I, S];
plot(V, E, 'r', V, I, 'b', V, S, 'g');
xlabel('V'), ylabel('EIS'), legend('E', 'I', 'S');
grid on;

alpha_VE = (E(4000) - E(1000)) / (V(4000) - V(1000)) * 10000;
alpha_VI = (I(4000) - I(1000)) / (V(4000) - V(1000)) * 10000;
alpha_VS_1 = (S(600) - S(1)) / (V(600) - V(1)) * 10000;
% 6180
alpha_VS_2 = (S(1500) - S(1000)) / (V(1500) - V(1000)) * 10000;
% 8420
alpha_VS_3 = (S(4000) - S(2000)) / (V(4000) - V(2000)) * 10000;
[alpha_VE, alpha_VI, alpha_VS_1, alpha_VS_2, alpha_VS_3]


