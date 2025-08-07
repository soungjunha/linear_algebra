function x = gauss_elim(A, b, tol)
    n = length(b);
    Aug = [A b];
    
    for i = 1:n-1
        if abs(Aug(i,i)) < tol
            error('Pivot too small at row %d (|%.2e| < tol)', i, abs(Aug(i,i)));
        end
        for j = i+1:n
            factor = Aug(j,i) / Aug(i,i);
            Aug(j,:) = Aug(j,:) - factor * Aug(i,:);
        end
    end

    x = zeros(n,1);
    for i = n:-1:1
        if abs(Aug(i,i)) < tol
            error('Zero pivot at back substitution (row %d)', i);
        end
        x(i) = (Aug(i,end) - Aug(i,1:n)*x) / Aug(i,i);
    end
end
