% Define the transfer function
num = [5]; % Numerator coefficients
den = [1 4 3 0]; % Denominator coefficients (s(s + 1)(s + 3))
G = tf(num, den);

% Convert to state-space
[A, B, C, D] = tf2ss(num, den);
% Controllability matrix
Controllability = ctrb(A, B);

% Check rank
if rank(Controllability) == size(A, 1)
    disp('The system is controllable.');
else
    disp('The system is not controllable.');
end
