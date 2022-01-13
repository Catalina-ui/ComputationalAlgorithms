function [x,e] = CG(N)
    if ( exists('multi') == 0 ) then
        exec('multi.sci');
    end
    if ( exists('GenLS') == 0 ) then
        exec('GenLS.sci');
    end
    tol = 10^-12;
    iter = 10000;
    r = zeros((N-1)*(N-1),iter);
    p = zeros((N-1)*(N-1),iter);
    x = zeros((N-1)*(N-1),iter);
    [AD,AL,col_ind,row_ptr,b] = GenLS(N);
    r(:,1) = b - multi(AD,AL,col_ind,row_ptr,x(:,1));
    p(:,1) = r(:,1);
    
    for i = 1:iter
        q(:,i) = multi(AD,AL,col_ind,row_ptr,p(:,i));
        a(i) = (r(:,i) '* r(:,i)) / (p(:,i) '* q(:,i));
        x(:,i+1) = x(:,i) + a(i) * p(:,i);
        r(:,i+1) = r(:,i) - a(i) * q(:,i);
        
        if(norm(r(:,i+1)) / norm(b) <= tol) then
            e = i;
            break;
        end
        tmpb = (r(:,i+1) '* r(:,i+1)) / (r(:,i) '* r(:,i));
        p(:,i+1) = r(:,i+1) + tmpb * p(:,i);
    end
    
endfunction
