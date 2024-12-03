% Manually derived state-space matrices
A = [0 1 0; 0 0 1; -6 -3 -2];  % State matrix
B = [0; 0; 1];                % Input matrix
C = [2 -1 1];                 % Output matrix
D = [0];                      % Direct transmission matrix

% Display the state-space matrices
disp('State-Space Representation:');
disp('A = '); disp(A);
disp('B = '); disp(B);
disp('C = '); disp(C);
disp('D = '); disp(D);

% Create the state-space system
sys_ss = ss(A, B, C, D);

% Verify by converting the state-space system back to transfer function
[num, den] = ss2tf(A, B, C, D);

disp('Transfer Function:');
disp('Numerator:'); disp(num);
disp('Denominator:'); disp(den);

% Plot the impulse response (optional visualization)
figure;
impulse(sys_ss);
title('Impulse Response of the System');

% Plot the step response (optional visualization)
figure;
step(sys_ss);
title('Step Response of the System');