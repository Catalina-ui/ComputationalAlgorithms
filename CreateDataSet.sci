function A = CreateDataSet(n)
    t = rand(n,2);
    A = zeros(n,2);
    A(:,1) = 150 + round(t(:,1) * 30);
    A(:,2) = A(:,1) / 3 + round(t(:,2) * 10);
endfunction
