%1
while true
    i = input("row size of matrix(4<=i<=20):"); % 행의 크기 입력
    j = input("column size of matrix(4<=j<=20):"); % 열의 크기 입력
    % 입력한 행과 열 크기가 모두 소수이고 4~20 사이일 경우 조건 충족
    if isprime(i) && isprime(j) && (i >= 4 && i <= 20) && (j >= 4 && j <= 20)
        fprintf('valid values enterd: i = %d, j = %d\n', i, j);
        break;
    end
end

%2
while any(sum(A) < -0.5) || any(sum(A) > 0.5) || any(sum(A') < -0.5) || any(sum(A') > 0.5)
    A = -1 + (1+1)*rand(i,j); % 범위가 -1에서 1 사이의 난수 행렬 A 생성
end

sum(A)   % 열 합 출력
sum(A')  % 행 합 출력

%3
for index = 1:i % 각 행을 순차적으로 반복
    if mod(index,2) == 0 % 행 번호가 짝수일 때
        for m = 1:j-1 % 열 끝까지 반복하여 오름차순 정렬
            for n = 1:j-m % 인접한 두 원소를 비교하여 정렬
                if A(index, n) > A(index, n+1) % 현재 원소가 다음 원소보다 크면
                    temp = A(index, n); % 임시 변수에 저장
                    A(index, n) = A(index, n+1); % 원소 위치 교환
                    A(index, n+1) = temp; % 임시 변수의 값 복원
                end
            end
        end
    else % 행 번호가 홀수일 때
        for m = 1:j-1 % 열 끝까지 반복하여 내림차순 정렬
            for n = 1:j-m % 인접한 두 원소를 비교하여 정렬
                if A(index, n) < A(index, n+1) % 현재 원소가 다음 원소보다 작으면
                    temp = A(index, n); % 임시 변수에 저장
                    A(index, n) = A(index, n+1); % 원소 위치 교환
                    A(index, n+1) = temp; % 임시 변수의 값 복원
                end
            end
        end
    end
end

A % 정렬된 행렬 A 출력

%4 
B = randn(i,j);%가우시안분포(평균 0, 분산 1)를 따르는 난수 행렬 B 생성
B % 생성된 행렬 B 출력

%5
X = zeros(i,j); % 행렬 X를 0으로 초기화

for row = 1:i % 모든 행을 순회
    for col = 1:j % 모든 열을 순회
        if A(row, col) > B(row, col) && A(row, col) > 0 % A의 값이 B보다 크고 양수이면
            X(row, col) = 1; % 해당 요소를 1로 설정
        elseif A(row, col) == B(row, col) % A와 B의 값이 같으면
            X(row, col) = 0; % 해당 요소를 0으로 설정
        else % 위 조건을 모두 만족하지 않으면
            X(row, col) = -1; % 해당 요소를 -1로 설정
        end
    end
end

X % 조건에 따라 구성된 행렬 X 출력

%6
[maxVal_A, linearIndMax_A] = max(A(:)); % 행렬 A의 최대값과 위치
[rowMax_A, ~] = ind2sub(size(A), linearIndMax_A); % 최대값이 있는 행 확인
[minVal_A, linearIndMin_A] = min(A(:)); % 행렬 A의 최소값과 위치
[~, colMin_A] = ind2sub(size(A), linearIndMin_A); % 최소값이 있는 열 확인

A(rowMax_A, :) = []; % 최대값이 있는 행 제거
A(:, colMin_A) = []; % 최소값이 있는 열 제거

[maxVal_B, linearIndMax_B] = max(B(:)); % 행렬 B의 최대값과 위치
[rowMax_B, ~] = ind2sub(size(B), linearIndMax_B); % 최대값이 있는 행 확인
[minVal_B, linearIndMin_B] = min(B(:)); % 행렬 B의 최소값과 위치
[~, colMin_B] = ind2sub(size(B), linearIndMin_B); % 최소값이 있는 열 확인

B(rowMax_B, :) = []; % 최대값이 있는 행 제거
B(:, colMin_B) = []; % 최소값이 있는 열 제거

A % 수정된 행렬 A 출력
B % 수정된 행렬 B 출력

%7
C = A * B'; % 행렬 곱 수행

C = C'; % 결과 행렬 C 전치
C % 최종 행렬 C 출력

%8 행렬 C의 행의 합(k)과 열의 합(m)을 계산
k = sum(C'); % 행의 합
m = sum(C);  % 열의 합

k % 행의 합 출력
m % 열의 합 출력

%9 
r = [k'; m']; % 두 개의 벡터를 수직 결합

r % 결합된 행렬 r 출력

%10
n = length(r); % 배열 r의 원소 개수를 구함

sum_r = 0; % 원소 합계를 저장할 변수 초기화
for i = 1:n % 배열의 모든 원소를 반복하여 합을 계산
    sum_r = sum_r + r(i); % 각 원소를 sum_r에 누적하여 더함
end
mean_r = sum_r / n; % 원소들의 평균을 계산함

sorted_r = r; % 원본 배열 r을 sorted_r로 복사하여 정렬할 준비
for i = 1:n-1 % 버블 정렬을 위한 반복
    for j = 1:n-i % 인접 원소 비교
        if sorted_r(j) > sorted_r(j+1) % 인접한 두 원소를 비교하여 정렬
            temp = sorted_r(j); % 두 원소를 교환하기 위한 임시 변수
            sorted_r(j) = sorted_r(j+1);
            sorted_r(j+1) = temp;
        end
    end
end

% 배열 길이가 홀수인지 짝수인지 판별하여 중간값 계산
if mod(n, 2) == 1 % 원소 개수가 홀수라면
    median_r = sorted_r((n+1)/2); % 가운데 원소가 중간값
else % 원소 개수가 짝수라면
    median_r = (sorted_r(n/2) + sorted_r(n/2 + 1)) / 2; % 가운데 두 원소의 평균이 중간값
end

sum_sq_diff = 0; % 편차 제곱의 합을 저장할 변수 초기화
for i = 1:n % 각 원소에 대해 반복하여 분산 계산
    sum_sq_diff = sum_sq_diff + (r(i) - mean_r)^2; % 평균에서 각 원소의 차이를 제곱하여 누적
end
var_r = sum_sq_diff / (n - 1); % 분산 계산 (표본 분산)

std_r = sqrt(var_r); % 표준편차 계산 (분산의 제곱근)

mean_r%편균 출력
median_r%중앙값 출력
var_r%분산 출력
std_r%표준편차 출력
