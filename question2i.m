% Define state-space matrices
A = [0 1 0; -4 -3 0; 1 0 0];
B = [0; 1; 0];
C = [0 0 1];
D = 0;

% Convert state-space to transfer function
[num, den]  = ss2tf(A, B, C, D);

% Display transfer function
tf_sys = tf(num, den);
disp('Transfer Function:');
disp(tf_sys);
