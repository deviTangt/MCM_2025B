clear; close; clc;
X = [129 160]' / 12;
Y = [3.3746 3.8028]' .* 10000 / 12;

fo = fitoptions('Method', 'NonlinearLeastSquares', ...
                'Lower', [0],...
                'Upper', [inf],...
                'StartPoint', [0]);
% k, alpha, beta;
f = 'k * x';
ft = fittype(f, 'options', fo);
[curve, ~] = fit(X, Y, ft)
k = curve.k;

x = [120 : 270] / 12;
F = 297.1 * x  - 0.1507 * x.^2.16;
plot(X', Y', 'ro', x, F, '-b');

%general
%以下是美国纽约市（New York City）在2023年的每月游客数量和当地因旅游业获得的总收入数据，以及边际效应分析。
clear; close; clc;
X = [450 420 500 550 600 700 800 850 750 650 580 500]';
Y = [4 3.8 4.5 5 5.5 6.2 7 7.5 7 6 5.2 4.5]' .* 10000;

fo = fitoptions('Method', 'NonlinearLeastSquares', ...
                'Lower', [0 0 0 ],...
                'Upper', [inf inf inf],...
                'StartPoint', [0 0 0]);
% k, alpha, beta;
f = 'k * x - alpha * x.^beta';
ft = fittype(f, 'options', fo);
[curve, ~] = fit(X, Y, ft)
k = curve.k;
alpha = curve.alpha;
beta = curve.beta;
x = [400 : 2000];
F = 106.98 * x - 8.97e-3 * x.^2.16;
plot(X', Y', 'ro', x, F, '-b');