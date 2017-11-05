%%section one
load 'pa_num_solv.mat';
x = linspace(0, 1, 1000);
y = 1.2 .* x.^2 - 0.17 .* x - 0.005;

error = y - Y;

figure(1);
hold on;
plot(x, error);
plot([0 1], [0 0], 'r');
title(['error:', num2str(sum(error .^ 2))]);

figure(2);
plot(x, y);