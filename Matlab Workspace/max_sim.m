
function max_sim()
    load 'opt_para.mat';
    
    X1 = delay_solver();
    
    X2 = zeros(1, n);
    for i = 1:n
        rou = V ./ BW / n;
        pa = polyval(para, rou);
        t1 = (F(i) - F) .* BW .* (1 - pa);
        t2 = BW .* (1 - pa);
        
        X2(i) = (1 - sum(t1)/PK) * (BW(i) * (1 - pa(i))) / sum(t2);
    end
    disp(X1);
    disp(X2);
end