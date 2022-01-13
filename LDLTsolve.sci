function z = LDLTsolve(L,D,r,col_ind,row_ptr)
    n = length(D);
    z = r;
    for i = 1:n
        for j = row_ptr(i):row_ptr(i+1) - 1
            z(i) = z(i) - L(j) * z(col_ind(j));
        end
    end
    for i = 1:n
        z(i) = z(i) / D(i);
    end
    
    for i = n:-1:1
        for j = row_ptr(i+1) - 1:-1:row_ptr(i)
            z(col_ind(j)) = z(col_ind(j)) - L(j) * z(i);
        end
    end
endfunction
