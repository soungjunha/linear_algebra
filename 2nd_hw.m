function [L, U, P] = slu(A)
% Partial Pivoting을 포함한 LU 분해 수행 함수
% 입력: A (정방행렬)
% 출력: L (단위 대각 성분을 갖는 하삼각 행렬)
%        U (상삼각 행렬)
%        P (행 교환을 기록하는 행 교환 행렬)

[n, ~] = size(A);         % A의 행 수 추출
L = eye(n);               % L을 단위 행렬로 초기화
P = eye(n);               % P도 단위 행렬로 초기화 (행 교환 기록용)

for k = 1:n
    % ------------------- pivot 검사 및 행 교환 -------------------
    [~, pivot_row] = max(abs(A(k:n, k)));     % 현재 열의 절댓값 중 최대값의 인덱스 탐색
    pivot_row = pivot_row + k - 1;            % 실제 전체 행 번호로 변환

    if abs(A(pivot_row, k)) < 1e-12           % pivot이 거의 0이면 오류 처리
        error('Zero pivot encountered, even after row swapping.');
    end

    if pivot_row ~= k
        A([k, pivot_row], :) = A([pivot_row, k], :);         % A의 행 교환
        P([k, pivot_row], :) = P([pivot_row, k], :);         % P의 행 교환 기록
        if k > 1
            L([k, pivot_row], 1:k-1) = L([pivot_row, k], 1:k-1);  % L의 일부 행도 교환
        end
    end

    % ------------------- LU 분해 본격 수행 -------------------
    for i = k+1:n
        L(i, k) = A(i, k) / A(k, k);            % L의 하삼각 원소 계산
        A(i, :) = A(i, :) - L(i, k) * A(k, :);   % 가우스 소거 수행 (행 업데이트)
    end
end

U = triu(A);  % A에서 상삼각 성분만 추출하여 U 완성
end


function x = slv(A, b)
% Partial Pivoting이 적용된 LU 분해를 이용해 Ax = b 푸는 함수
% 입력: A (계수 행렬), b (우변 벡터)
% 출력: x (해 벡터)

[L, U, P] = slu(A);     % LU 분해 수행 (행 교환 포함)
b = P * b;              % 행 교환 행렬 P를 b에 적용

n = length(b);          % 벡터 b의 길이 = 미지수 개수
y = zeros(n, 1);        % 중간 해 y 초기화 (Ly = b)
x = zeros(n, 1);        % 최종 해 x 초기화 (Ux = y)

% --------- Forward Substitution: Ly = b ---------
for i = 1:n
    s = 0;
    for j = 1:i-1
        s = s + L(i, j) * y(j);  % 누적합 계산 (이전 y 이용)
    end
    y(i) = b(i) - s;             % y(i) 계산
end

% --------- Backward Substitution: Ux = y ---------
for i = n:-1:1
    t = 0;
    for j = i+1:n
        t = t + U(i, j) * x(j);  % 이미 구한 x 값 누적
    end
    x(i) = (y(i) - t) / U(i, i); % 대각 원소로 나누어 x(i) 계산
end
end

% ---------- 사용자 입력 ----------
disp('5x5 계수 행렬 A를 입력하세요 (예: A = [1 2 3 4 5; ...; 5 4 3 2 1]):');
A = input('A = ');             % 사용자로부터 행렬 A 입력 받음

disp('우변 벡터 b를 입력하세요 (예: b = [1; 2; 3; 4; 5]):');
b = input('b = ');             % 사용자로부터 벡터 b 입력 받음

% ---------- 해 구하기 ----------
try
    x = slv(A, b);              % LU 분해를 이용해 Ax = b 해 구함
    disp('해 x = ');
    disp(x);
catch ME
    disp('오류 발생:');         % 예외 발생 시 메시지 출력
    disp(ME.message);
end
