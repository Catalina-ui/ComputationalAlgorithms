function [L,D] = IC0(AD,AL,col_ind,row_ptr)
    n = length(AD);
    nz = length(AL);
    D = AD;
    L = zeros(nz,1);
    for i = 1:n
        w = zeros(i-1,1);
        for j = row_ptr(i):row_ptr(i+1) - 1
            w(col_ind(j)) = AL(j);
            for k = row_ptr(col_ind(j)):row_ptr(col_ind(j)+1)-1
                w(col_ind(j)) = w(col_ind(j)) - L(k) * w(col_ind(k));
            end
            L(j) = w(col_ind(j)) / D(col_ind(j));
        end
        for j = row_ptr(i):row_ptr(i+1) - 1
            D(i) = D(i) - L(j) * w(col_ind(j));
        end
    end
endfunction
