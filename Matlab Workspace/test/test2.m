
clc;clear;

X = linspace(0, 1, 1000);
Y = zeros(1, 1000);
y = linspace(0, 1, 1E4);
error = zeros(1, 1000);
A = 1E-3;%relaxation on delta function

for i = 1:1000
    %delta = A .*
    delta = y - exp( (y-1) ./ X(i) );
    delta = delta .^ 2;
    [error(i), I] = min(delta);
    index(i) = I;
    Y(i) = y(I);
end

figure(1);
subplot(1,2,1);
hold on;
ylim([0 1.1]);
plot(X, Y, '-k');
e1 = Y - exp( (Y-1) ./ X);
title(['Function expression']);

para = [1.3354    -0.28657    0.010471];
y1 = polyval(para, X);
plot(X, y1, '--k');
xlabel('utilization factor');
legend('Numerical solution', 'Polynomial fit');

%figure(2);
subplot(1,2,2);
hold on;
e2 = y1 - exp( (y1-1) ./ X);
plot(X, e2, 'k');
plot([0 1], [0 0], '--k');
xlabel('utilization factor');
title(['standard error:', num2str(sum(e2 .^ 2))]);
