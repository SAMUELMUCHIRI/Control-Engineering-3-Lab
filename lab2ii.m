% Question 1.ii: Servo Position Control System Design

clc;
clear;
close all;

%% System Definition
% Given transfer function: G(s) = 5 / (s^2 + 1.2s + 2)
num = [5];           % Numerator
den = [1 1.2 2];     % Denominator

% Convert to State-Space
[A, B, C, D] = tf2ss(num, den);

%% Design Specifications
% 5% overshoot and 0.5s settling time
% Calculate damping ratio (zeta) and natural frequency (wn)
zeta = 0.7;                       % Damping ratio for 5% overshoot
ts = 0.5;                         % Settling time (s)
wn = 4 / ts;                      % Natural frequency
real_part = -zeta * wn;           % Real part of poles
imag_part = wn * sqrt(1 - zeta^2); % Imaginary part of poles

% Desired poles
desired_poles = [real_part + imag_part*1j, real_part - imag_part*1j];
disp('Desired closed-loop poles:');
disp(desired_poles);

%% State Feedback Gain (K)
K = place(A, B, desired_poles);  % Compute feedback gain
disp('State feedback gain (K):');
disp(K);

%% Feedforward Gain (kr)
kr = 1 / (-C * inv(A - B * K) * B);  % Ensure unit step tracking
disp('Feedforward gain (kr):');
disp(kr);

%% Closed-Loop System
% Closed-loop state-space matrices
A_cl = A - B * K;       % New A matrix
B_cl = B * kr;          % Modified B matrix

% Define Closed-Loop System
sys_cl = ss(A_cl, B_cl, C, D);

%% Simulation and Plotting
% Time vector
t = 0:0.01:2;  % Simulate for 2 seconds

% Simulate step response
[y, t, x] = step(sys_cl, t);

% Plot results
figure;
plot(t, y, 'b', 'LineWidth', 1.5);
grid on;
title('Closed-Loop Step Response');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Output y(t)');

% Plot state variables
figure;
plot(t, x(:, 1), 'r', 'LineWidth', 1.5); hold on;
plot(t, x(:, 2), 'g', 'LineWidth', 1.5);
grid on;
title('State Variables vs Time');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('x1(t)', 'x2(t)');
