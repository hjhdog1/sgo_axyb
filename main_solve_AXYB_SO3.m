%% SO3 Single Simulation
clc;
clear all;
close all;

%% Load data
load SO3Data.mat


%% Parameter Setting
alpha = 0.0;            % translation weight - set it to be 0.0 for SO(3) case
param = defaultParam;   % get default solver parameters. see instruction for more detail


%% Solve AX = YB
% solve with geometric stochastic global optimization
param.globalOptMethod = 2;      % stochastic global optimization with geometric local search
[X_geometric,Y_geometric,dummy_geometric,methodName_geometric] = solveAXYB_SE3(A,B,alpha,param);


%% Display Result
distX_geometric_SO3 = norm(LogSO3(X_geometric * X_true'));
distY_geometric_SO3 = norm(LogSO3(Y_geometric * Y_true'));

disp('======= Geometric optimization ======');
disp(['X is ', num2str(distX_geometric_SO3*180/pi), 'deg off from the ground truth.'])
disp(['Y is ', num2str(distY_geometric_SO3*180/pi), 'deg off from the ground truth.'])
