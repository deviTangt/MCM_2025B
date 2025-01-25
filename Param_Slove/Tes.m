close; clear; clc;

V = [0 : 0.01 : 4]' * 1e+4;
E = zeros(size(V, 1), 1); 
I = zeros(size(V, 1), 1); 
S = zeros(size(V, 1), 1); 
for i = 1 : 401
    [E(i), I(i), S(i)] = Calculate_EIS(V(i));
end
[V, E, I, S];
plot(V, E, 'r', V, I, 'b', V, S, 'g');
xlabel('V'), ylabel('EIS'), legend('E', 'I', 'S');
grid on;