% Define the state-space matrices
A = [0 1 0;
     0 0 1;
    -6 -11 -6];

% Step 1: Calculate eigenvalues and eigenvectors
[eigenvectors, eigenvalues] = eig(A);

% Display eigenvalues
disp('Eigenvalues of A:');
disp(diag(eigenvalues));

% Display eigenvectors
disp('Eigenvectors of A:');
disp(eigenvectors);

% Step 2: Verify if the system is diagonalizable
% A matrix is diagonalizable if eigenvectors form a linearly independent set
% Check if the determinant of the eigenvector matrix is non-zero
if det(eigenvectors) ~= 0
    disp('The system is diagonalizable.');
else
    disp('The system is not diagonalizable.');
end

% Step 3: Calculate the diagonal matrix using similarity transformation
P = eigenvectors; % Similarity transformation matrix
P_inv = inv(P); % Inverse of P
A_diagonal = P_inv * A * P; % A in diagonal form

% Display results
disp('Similarity transformation matrix P:');
disp(P);

disp('Diagonal matrix (A_diagonal):');
disp(A_diagonal);