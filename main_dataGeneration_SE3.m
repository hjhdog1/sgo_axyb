%% SE3 SYNTHETIC DATA GENERATION
% this script generates a set of transformation matrices with noise in both
% rotation and translation together with outliers.
clc;
clear all;
close all;

%% Generate Synthetic Data
% parameters
N = 100;                            % num of date pairs (A,B)
noiseLevel_SO3 = 10*pi/180;         % rotation noise level in radian (std of the magnitude of angular displacement noise)
noiseLevel_trans = 0.05;            % translation noise level in user's length unit (std of translation noise)
outlierRatio = 0.1;                 % ratio of outliers out of N


% true values of X,Y
X_true = randSE3();  % ground truth of X
Y_true = randSE3();  % ground truth of Y


% generate data
[A,B,M] = generateABData_SE3(X_true, Y_true, N, noiseLevel_SO3, 1, noiseLevel_trans, outlierRatio);   % last M pairs of (A,B) are outliers.
[A,B] = randomSorting(A,B); % random-sorting data to mix outliers


%% Save synthetic data
save SE3Data.mat