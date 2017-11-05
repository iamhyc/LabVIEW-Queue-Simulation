
function test3(n)
    close all;

    X0 = zeros(1, n);%start point
    X0 = X0';%transpose to column vector
    
    options = optimset('Display', 'none', 'TolX', 1e-12, 'TolFun', 1e-12);
    
    [x1, f1] = fminunc(@func, X0, options);%fminunc method
    disp(['Fminunc result:[', num2str(x1'), ']']);
    disp(['Fminunc function value:[', num2str(f1), ']']);
    
end

function y = func(para)
    load 'pa_num_solv.mat';
    y = polyval(para, X);
    error = y - exp( (y-1) ./ X);
    y = sum(error .^ 2);
end