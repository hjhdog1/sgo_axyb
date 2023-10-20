function [A,B,M] = generateABData_SE3(X,Y, N, noiseLevel_SO3, position_scaler, noiseLevel_position, outlierRatio, noiseType)
% N : number of data
% noiseLevel_SO3 : standard deviation for SO3 (radian)
% noiseLevel_position : standard deviation for position
% outlierRation : Ratio of outliers in Data
% M : number of outliers

if nargin < 8
    noiseType = 'G';    % Gaussian noise
end

M = round(N*outlierRatio);
A = zeros(4,4,N);
B = zeros(4,4,N);
A(4,4,:) = 1;
B(4,4,:) = 1;


isSO3Problem = 0;
if norm(X(1:3,4)) == 0 & norm(Y(1:3,4)) == 0
    isSO3Problem = 0;
end

invX = invSE3(X);
invY = invSE3(Y);

%% Generate noisy data

for i = 1:N-M
%     % generate exact A,B
%     A(1:3,1:3,i) = randSO3();
%     if ~isSO3Problem
%         A(1:3,4,i) = position_scaler*randn(3,1);
%     end
%     B(:,:,i) = invY*A(:,:,i)*X;
    % generate exact A,B
    B(1:3,1:3,i) = randSO3();
    if ~isSO3Problem
        B(1:3,4,i) = position_scaler*randn(3,1);
    end
    A(:,:,i) = Y*B(:,:,i)*invX;
    
    % add noise    
    A(1:3,1:3,i) = addNoise(A(1:3,1:3,i) ,noiseLevel_SO3,'right',noiseType);
    B(1:3,1:3,i) = addNoise(B(1:3,1:3,i) ,noiseLevel_SO3,'right',noiseType);
    if ~isSO3Problem
        invYAX = invY*A(:,:,i)*X;
        B(1:3,4,i) = invYAX(1:3,4) + noiseLevel_position*randn(3,1);
        A(1:3,4,i) = A(1:3,4,i) + noiseLevel_position*randn(3,1);
%         B(1:3,4,i) = B(1:3,4,i) + noiseLevel_position*randn(3,1);
    end
end


%% Generate outliers
for i = N-M+1:N
    A(:,:,i) = [randSO3() position_scaler*randn(3,1); zeros(1,3) 1];
    B(:,:,i) = [randSO3() position_scaler*randn(3,1); zeros(1,3) 1];
end


end