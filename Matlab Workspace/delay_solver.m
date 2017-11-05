
function [X, val] = delay_solver()
    clc;
    load('opt_para.mat', 'n', 'PK', 'F', 'V', 'BW', 'para');

    X = cell(1, 9);
    f = cell(1, 9);
    val = zeros(1, 9);
    rr = rand(1, n);
    rr = rr ./ sum(rr);
    
    v1 = zeros(1, 9);
    v2 = zeros(1, 9);
    v3 = zeros(1, 9);
    v4 = zeros(1, 9);
    
    X0 = 1 ./ ones(1, n);
    ym = ones(1, n);
    zm = zeros(1, n);
    options = optimset('Display', 'none', 'TolX', 1e-8, 'TolFun', 1e-8);
    
    for i = 1:9
        V = 0.1 * i * BW;
        save ('opt_para.mat', 'n', 'PK', 'F', 'V', 'BW', 'para');
        [X{i}, f{i}, val(i)] = fminimax(@func, X0, [], [], ym, 1, zm, ym, @con, options);
        
        disp(['Final result:[', num2str(X{i}), ']']);
        disp(['Final function value:[', num2str(val(i)), ']']);
        
        Xp = BW ./ sum(BW);
        v1(i) = max(func(Xp));
        
        Xp = 1/n;
        v2(i) = max(func(Xp));
        
        Xp = rr;
        v3(i) = max(func(Xp));
        
        Xp = F ./ sum(F);
        v4(i) = max(func(Xp));
    end
    
    figure(1);
    
    hold on;
    ylim([7E-3 11E-3]);
    plot(0.1:0.1:0.9, val, '-ok');
    plot(0.1:0.1:0.9, v1, '--ok');
    plot(0.1:0.1:0.9, v2, ':ok');
    %plot(0.1:0.1:0.9, v3, '-.');
    plot(0.1:0.1:0.9, v4, '-.ok');
    legend('Optimal', 'Bandwidth Weight', 'Average Weight', 'Delay Weight');
    xlabel('Total Utilization Factor');
    ylabel('Estimated End-to-end Delay');
end

function PK = add_header(n, PK)
    PK = PK + 224;
end

function [c, ceq] = con(X)%description for ineaulity condition
    c = [];
    ceq = [];%(1) = sum(X) - 1;
end

function Y = func(X)

    load('opt_para.mat', 'n', 'PK', 'F', 'V', 'BW', 'para');
    PK = add_header(n, PK);
    rou = V .* X ./ BW;
    pa = polyval(para, rou);
    %original
    Y = F + (PK .* X) ./ (BW .* (1 - pa) );
    %fixup
    %Y = F + (PK .* X) .* ((pa-1).^2+1) ./ (BW.*(1-pa));
end