function [L, U] = slu(A, tol)
    n = size(A, 1);
    L = eye(n);
    U = zeros(n);

    for i = 1:n
        for j = i:n
            U(i,j) = A(i,j) - L(i,1:i-1)*U(1:i-1,j);
        end

        if abs(U(i,i)) < tol
            error('LU 분해 실패: pivot U(%d,%d) = %.2e 가 tol=%.2e 보다 작음.', i, i, abs(U(i,i)), tol);
        end

        for j = i+1:n
            L(j,i) = (A(j,i) - L(j,1:i-1)*U(1:i-1,i)) / U(i,i);
        end
    end
end
