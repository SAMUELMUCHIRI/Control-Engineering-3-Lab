num = [1 -1 2]; % Numerator coefficients
den = [1 2 3 6]; % Denominator coefficients
G = tf(num, den);
[A_control, B_control, C_control, D_control] = tf2ss(num, den);
sys_observer = canon(G, 'companion'); % Observer Canonical Form
[A_observer, B_observer, C_observer, D_observer] = ssdata(sys_observer);
% Time vector
t = 0:0.01:10; % 10 seconds simulation

% Unit step input
u = ones(size(t)); 

% Simulate Control Canonical Form
x0 = [0; 0; 0]; % Initial conditions
[y_control, t_control, x_control] = lsim(ss(A_control, B_control, C_control, D_control), u, t, x0);

% Simulate Observer Canonical Form
[y_observer, t_observer, x_observer] = lsim(ss(A_observer, B_observer, C_observer, D_observer), u, t, x0);

% Plot Results
figure;
subplot(4,1,1); plot(t_control, x_control(:,1)); title('x1(t) - Control Canonical Form'); xlabel('Time (s)'); ylabel('x1');
subplot(4,1,2); plot(t_control, x_control(:,2)); title('x2(t) - Control Canonical Form'); xlabel('Time (s)'); ylabel('x2');
subplot(4,1,3); plot(t_control, x_control(:,3)); title('x3(t) - Control Canonical Form'); xlabel('Time (s)'); ylabel('x3');
subplot(4,1,4); plot(t_control, y_control); title('y(t) - Control Canonical Form'); xlabel('Time (s)'); ylabel('Output');
