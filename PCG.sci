function [z,e] = PCG(N)
    if ( exists('multi') == 0 ) then
        exec('multi.sci');
    end
    if ( exists('GenLS') == 0 ) then
        exec('GenLS.sci');
    end
    if ( exists('IC0') == 0 ) then
        exec('IC0.sci');
    end
    if ( exists('LDLTsolve') == 0 ) then
        exec('LDLTsolve.sci');
    end

    tol = 10^-12;
    iter = 10000;
    r = zeros((N-1)*(N-1),iter);
    p = zeros((N-1)*(N-1),iter);
    x = zeros((N-1)*(N-1),iter);
    z = zeros((N-1)*(N-1),iter);
    
    [AD,AL,col_ind,row_ptr,b] = GenLS(N);
    [L,D] = IC0(AD,AL,col_ind,row_ptr);
    r(:,1) = b - multi(AD,AL,col_ind,row_ptr,x(:,1));
    p(:,1) = LDLTsolve(L,D,r(:,1),col_ind,row_ptr);
    z(:,1) = p(:,1);
    
    for i = 1:iter
        q(:,i) = multi(AD,AL,col_ind,row_ptr,p(:,i));
        a(i) = (r(:,i) '* z(:,i)) / (p(:,i) '* q(:,i));
        x(:,i+1) = x(:,i) + a(i) * p(:,i);
        r(:,i+1) = r(:,i) - a(i) * q(:,i);
        
        if(norm(r(:,i+1)) / norm(b) <= tol) then
            e = i;
            break;
        end
        z(:,i+1) = LDLTsolve(L,D,r(:,i+1),col_ind,row_ptr);
        tmpb = (r(:,i+1) '* z(:,i+1)) / (r(:,i) '* z(:,i));
        p(:,i+1) = z(:,i+1) + tmpb * p(:,i);
    end
    
endfunction
