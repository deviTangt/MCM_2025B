clear; clc;
X = 2 * [39780 31657 39122 39116 39108 50488 41051 42400 43435 45092 35187 38782]' ./ 10000;
Y = [120 120 130 130 130 150 150 150 130 130 120 120]' .* X;

fo = fitoptions('Method', 'NonlinearLeastSquares', ...
                'Lower', [0 0 0],...
                'Upper', [inf inf inf],...
                'StartPoint', [0 0 0]);
% k, alpha, beta;
f = 'k * x + alpha * x.^beta';
ft = fittype(f, 'options', fo);
[curve, ~] = fit(X, Y, ft)
k = curve.k;
alpha = curve.alpha;
beta = curve.beta;
x = [3 : 0.1 : 10];
%F = k * x + alpha * x.^beta;
F = k * x + alpha * x.^beta;
plot(X', Y', 'ro', x, F, '-b');