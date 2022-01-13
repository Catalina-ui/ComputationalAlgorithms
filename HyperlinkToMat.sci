function A = HyperlinkToMat(G)
    p = 0.8;
    n = size(G,1);
    c = sum(G,1);
    d = (1-p)/n;
    A = ones(n,n)/n;
    
    for i = 1:n
        for j = 1:n
            if c(j) ~= 0
                A(i,j) = p * G(i,j)/c(j) + d;
            end
        end
    end
endfunction
