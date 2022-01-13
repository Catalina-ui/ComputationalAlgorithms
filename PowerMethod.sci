function v = PowerMethod(A)
    n = size(A,1);
    v = rand(n,1);
    
    for k = 1:100
        w = A * v;
        lambda = v' * w;
        v = w / norm(w);
    end
endfunction
