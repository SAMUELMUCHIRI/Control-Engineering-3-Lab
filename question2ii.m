% Define state-space matrices
A = [2 1 0; 0 3 0; 0 1 5];
B = [0 1; 1 0; 0 1];
C = [1 0 0];
D = [0 0]; % Since D is not specified, assume it's zero

% Convert state-space to transfer function for both inputs
[num1, den1] = ss2tf(A, B, C, D, 1); % For input 1
[num2, den2] = ss2tf(A, B, C, D, 2); % For input 2

% Display transfer functions
tf_sys1 = tf(num1, den1); % Transfer function for input 1
tf_sys2 = tf(num2, den2); % Transfer function for input 2

disp('Transfer Function (Input 1):');
disp(tf_sys1);

disp('Transfer Function (Input 2):');
disp(tf_sys2);
