% Question 1.ii: State Feedback Control for Servo Position System

clc;
clear;
close all;

%% Define the system
% Transfer function: G(s) = 5 / (s^2 + 1.2s + 2)
num = [5];           % Numerator
den = [1 1.2 2];     % Denominator

% Convert to state-space representation
[A, B, C, D] = tf2ss(num, den);

% Display state-space matrices
disp('State-space representation:');
disp('A = '), disp(A);
disp('B = '), disp(B);
disp('C = '), disp(C);
disp('D = '), disp(D);

%% Design specifications
% Damping ratio and settling time
zeta = 0.7;           % 5% overshoot
ts = 0.5;             % Settling time (seconds)
wn = 4 / ts;          % Natural frequency

% Desired poles
real_part = -zeta * wn;                      % Real part
imag_part = wn * sqrt(1 - zeta^2);           % Imaginary part
desired_poles = [real_part + 1j*imag_part, real_part - 1j*imag_part];

disp('Desired closed-loop poles:');
disp(desired_poles);

%% State Feedback Gain (K)
K = place(A, B, desired_poles);  % Calculate feedback gain
disp('State feedback gain (K):');
disp(K);

%% Feedforward Gain (kr)
kr = 1 / (-C * inv(A - B * K) * B);  % Ensure unit step tracking
disp('Feedforward gain (kr):');
disp(kr);

%% Define the closed-loop system
% Closed-loop state-space matrices
A_cl = A - B * K;       % Modified A matrix
B_cl = B * kr;          % Adjusted B matrix

% Define closed-loop system
sys_cl = ss(A_cl, B_cl, C, D);

%% Simulation
% Time vector
t = 0:0.01:2;  % Simulate for 2 seconds

% Step response
[y, t, x] = step(sys_cl, t);

% Plot output y(t)
figure;
plot(t, y, 'b', 'LineWidth', 1.5);
grid on;
title('Closed-Loop Step Response');
xlabel('Time (seconds)');
ylabel('Output y(t)');
legend('y(t)');

% Plot state variables x1(t) and x2(t)
figure;
plot(t, x(:, 1), 'r', 'LineWidth', 1.5); hold on;
plot(t, x(:, 2), 'g', 'LineWidth', 1.5);
grid on;
title('State Variables');
xlabel('Time (seconds)');
ylabel('State Variables');
legend('x1(t)', 'x2(t)');
