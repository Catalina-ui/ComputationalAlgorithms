function P = PCAbyPM(A);
    m1 = mean(A(:,1));
    m2 = mean(A(:,2));
    A(:,1) = A(:,1) - m1;
    A(:,2) = A(:,2) - m2;
    C = A' * A;
    v = PowerMethod(C);
    v = v /norm(v);
    u = A*v;
    u = u / norm(u);
    lambda = v'*(C*v) / (v'*v);
    s = sqrt(lambda);
    
    P = s * u * v';
    P(:,1) = P(:,1) + m1;
    P(:,2) = P(:,2) + m2;
endfunction
