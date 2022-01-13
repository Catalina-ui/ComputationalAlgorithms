function y = multi(AD,AL,col_ind,row_ptr,x) //引数は疎行列をCRS形式に変換した４つの要素
    n = size(x,1) 
    y = zeros(n,1) 
    for i = 1:n 
        y(i) = 0.0; 
        for j = row_ptr(i):row_ptr(i+1)-1 
                y(i) = y(i,1) + AL(j) * x(col_ind(j)); 
        end 
    end 

    for i = 1:n 
            y(i) = y(i) + x(i) * AD(i); 
    end 
    
    for j = 1:n 
            for i = row_ptr(j):row_ptr(j+1)-1 
                k = col_ind(i); 
                y(k) = y(k) + AL(i) * x(j); 
            end 
    end
endfunction
