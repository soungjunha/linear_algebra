function invA = cofactor_inv(A, tol)
    % 행렬 크기 확인
    [n, ~] = size(A);
    
    % 행렬식 계산 및 tol 검사
    detA = det(A);
    if abs(detA) < tol
        error('Singular matrix: |det(A)| = %.2e < tol. 역행렬이 존재하지 않습니다.', detA);
    end
    
    % 여인수 행렬 초기화
    C = zeros(n);

    % 여인수 계산
    for i = 1:n
        for j = 1:n
            % 소행렬(minor) 생성
            minor = A;
            minor(i,:) = [];
            minor(:,j) = [];
            
            % 여인수 행렬 원소 계산
            C(i,j) = (-1)^(i+j) * det(minor);
        end
    end

    % 전치행렬(adjugate)과 행렬식으로 역행렬 계산
    invA = (1/detA) * C';
end
