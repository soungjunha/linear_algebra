function main_3_1()
    A = [2 5 2; 1 3 5; 3 8 5];
    b = [6; 5; 17];
    tol = 1e-10;

    % LU Factorization
    tic;
    [L, U] = slu(A, tol);
    x1 = slv(L, U, b);
    t1 = toc;

    % Gaussian Elimination
    tic;
    x2 = gauss_elim(A, b, tol);
    t2 = toc;

    % MATLAB inv()
    tic;
    x3 = inv(A) * b;
    t3 = toc;

    % Cofactor Method
    tic;
    invA = cofactor_inv(A, tol);
    x4 = invA * b;
    t4 = toc;

    % Display Results
    disp('--- LU Factorization ---');
    disp(x1);
    disp('--- Gauss Elimination ---');
    disp(x2);
    disp('--- MATLAB inv() ---');
    disp(x3);
    disp('--- Cofactor ---');
    disp(x4);

    fprintf('=== 해 비교 요약 ===\n');
    fprintf('LU        : %0.6f s\n', t1);
    fprintf('Gauss     : %0.6f s\n', t2);
    fprintf('inv()     : %0.6f s\n', t3);
    fprintf('Cofactor  : %0.6f s\n', t4);
end
