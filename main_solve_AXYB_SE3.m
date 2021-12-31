%% SE3 Single Simulation
clc;
clear all;
close all;

%% Load data
load SE3Data.mat


%% Parameter Setting
alpha = 0.1;            % translation weight
param = defaultParam;   % get default solver parameters. see instruction for more detail


%% Solve AX = YB
% solve with geometric stochastic global optimization
param.globalOptMethod = 2;      % stochastic global optimization with geometric local search
[X_geometric,Y_geometric,dummy_geometric,methodName_geometric] = solveAXYB_SE3(A,B,alpha,param);


%% Display Result
distX_geometric_SO3 = norm(so3(X_geometric(1:3,1:3) * X_true(1:3,1:3)'));
distY_geometric_SO3 = norm(so3(Y_geometric(1:3,1:3) * Y_true(1:3,1:3)'));
distX_geometric_trans = norm(X_geometric(1:3,4) - X_true(1:3,4));
distY_geometric_trans = norm(Y_geometric(1:3,4) - Y_true(1:3,4));

disp('======= Geometric optimization ======');
disp(['X is ', num2str(distX_geometric_SO3*180/pi), 'deg/', num2str(distX_geometric_trans),'mm off from the ground truth.'])
disp(['Y is ', num2str(distY_geometric_SO3*180/pi), 'deg/', num2str(distY_geometric_trans),'mm off from the ground truth.'])
