
function para_gen(n)
    
    para = [1.3354   -0.2866    0.0105];

    PK = 3E4 * rand() + 1E4;% 10 - 40KB
    V = 5E6 * rand() + 5E6;% 5 - 10 MB/s
    
    BW = 10E6 .* rand(1, n) + 10E6;% 10 - 20 MB
    F  = 9E-3 .* rand(1, n) + 1E-3;% 1 - 10 ms

    save('opt_para.mat', 'n', 'para', 'PK', 'V', 'BW', 'F');
end