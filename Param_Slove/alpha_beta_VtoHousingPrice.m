clear; clc;

X = [12 10.5 11 15 30 50 60 45 20 10 8 10.5 ...
                              10 8.5 9 12 25 50 65 40 15 10 9 10.5]' * 1e+3;
Y = [16 16 17 18 22 25 27 24 22 18 17 16 ...
                              17 17 18 19 23 26 28 25 23 19 18 17]' * 1e+2;

fo = fitoptions('Method', 'NonlinearLeastSquares', ...
                'Lower', [0 0],...
                'Upper', [inf inf],...
                'StartPoint', [0 0]);
% k, alpha, beta;
f = 'alpha * x.^beta';
ft = fittype(f, 'options', fo);
[curve, ~] = fit(X, Y, ft)
alpha = curve.alpha;
beta = curve.beta;
x = [7 : 70] * 1e+3;
%F = k * x + alpha * x.^beta;
F = alpha * x.^beta;
plot(X', Y', 'ro', x, F, '-b');