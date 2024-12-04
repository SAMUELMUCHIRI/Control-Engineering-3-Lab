clc;
clear;
close all;

%% Define the System Matrices
A = [0 1 0; 
     0 0 1; 
     -6 -3.5 -4.5];
B = [0; 0; 2.4];
C = [1 0 0];
D = 0;

disp('System Matrices:');
disp('A = '), disp(A);
disp('B = '), disp(B);
disp('C = '), disp(C);

%% Desired Observer Poles
desired_observer_poles = [-5, -2 + 4j, -2 - 4j];

%% Compute Observer Gain Matrix (L)
L = place(A', C', desired_observer_poles)'; % Transpose for observer
disp('Observer Gain Matrix (L):');
disp(L);

%% Augmented System Matrices for Observer
% Define the error dynamics matrix
A_obs = A - L * C;
B_obs = [B, L];
C_obs = eye(3); % Outputs are the states
D_obs = [zeros(3, 1), zeros(3, 1)];

% Observer system for simulation
sys_obs = ss(A_obs, B_obs, C_obs, D_obs);

%% Simulate the Observer
% Time vector
t = 0:0.01:3;  % Simulate for 3 seconds

% Input: Step response
u = ones(size(t)); % Unit step input
x0 = [0.1; 0.2; 0.3]; % Initial condition for observer states

% Simulate the response
[y, t, x] = lsim(sys_obs, [u', zeros(size(u'))], t, x0);

%% Plot Results
% State Variables (x1, x2, x3)
figure;
plot(t, x(:, 1), 'r', 'LineWidth', 1.5); hold on;
plot(t, x(:, 2), 'g', 'LineWidth', 1.5);
plot(t, x(:, 3), 'b', 'LineWidth', 1.5);
grid on;
title('State Variables of the Observer');
xlabel('Time (seconds)');
ylabel('State Variables');
legend('x_1(t)', 'x_2(t)', 'x_3(t)');

% Output y(t)
y_obs = C * x';
figure;
plot(t, y_obs, 'k', 'LineWidth', 1.5);
grid on;
title('Output y(t) of the Observer');
xlabel('Time (seconds)');
ylabel('Output y(t)');
legend('y(t)');
