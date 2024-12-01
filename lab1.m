% Import symbolic math capabilities
syms y(t) u(t) s Y U

% Define initial conditions
y0 = 0;             % y(0)
dy0 = 0;            % dy/dt(0)
d2y0 = 0;           % d2y/dt2(0)
u0 = 0;             % u(0)
du0 = 0;            % du/dt(0)
d2u0 = 0;           % d2u/dt2(0)

% Define the differential equation
diff_eq = diff(y, t, 3) + 2*diff(y, t, 2) + 3*diff(y, t) + 6*y == diff(u, t, 2) - diff(u, t) + 2*u;

% Take the Laplace Transform of the equation (set initial conditions to zero)
laplace_eq = laplace(diff_eq, t, s);
laplace_eq = subs(laplace_eq, {y(0), diff(y(t), t, 1), diff(y(t), t, 2), u(0), diff(u(t), t, 1), diff(u(t), t, 2)}, ...
    {y0, dy0, d2y0, u0, du0, d2u0});

% Replace Laplace transforms of y(t) and u(t) with Y(s) and U(s)
laplace_eq = subs(laplace_eq, [laplace(y, t, s), laplace(u, t, s)], [Y, U]);

% Solve for Y in terms of U
TF_equation = solve(laplace_eq, Y);

% Express transfer function explicitly as TF = Y/U
TF = TF_equation / U;

% Simplify TF
TF = simplifyFraction(TF);  % Ensure TF is in fraction form

% Extract numerator and denominator
[num, den] = numden(TF); % Get numerator and denominator

% Display the results
disp('The Transfer Function is:');
disp('Numerator:');
disp(simplify(num));
disp('Denominator:');
disp(simplify(den));
