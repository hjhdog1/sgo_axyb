%% SE3 SYNTHETIC DATA GENERATION
% this script generates a set of rotation matrices with noise and outliers.
clc;
clear all;
close all;

%% Generate Synthetic Data
% parameters
N = 100;                        % num of date pairs (A,B)
noiseLevel_SO3 = 10*pi/180;     % noise level in radian (std of the magnitude of angular displacement noise)
outlierRatio = 0.1;             % ratio of outliers out of N

% true values of X,Y
X_true = randSO3();  % ground truth of X
Y_true = randSO3();  % ground truth of Y


% generate data
[A,B,M] = generateABData_SO3(X_true, Y_true, N, noiseLevel_SO3, outlierRatio);  % last M pairs of (A,B) are outliers.
[A,B] = randomSorting(A,B); % random-sorting data to mix outliers


%% Save synthetic data
save SO3Data.mat