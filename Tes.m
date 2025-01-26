close; clear; clc;

Param;

%[V, C] = Tourism_Optimal(100, 100, 100, 3)

EISV = [100, 100, 100, 5];
C = 4;
V = 1.1;
P = 0;
[Emax, Imax, Smax, Vmax, w_alloction] = Iter_Optimal(EISV, C, V, P);
[Emax, Imax, Smax, Vmax]
