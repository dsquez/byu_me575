%project surrogate

clear; close all; clc;

omega_des = 2*pi();

% Lower bound
lb = [0,0,0,0,0,0];

% Upper bound
ub = [45,45,45,45,45,45];

% Construct LHS Sample (use lhsdesign)
M = 20;  % number of samples
N = 6;  % number of design variables
xlhs = lhsdesign(M,N);
% TODO
for i = 1:M
    x(i,:) = lb + (ub-lb).*xlhs(i,:);
    f(i,:) = wheel_prototype(x(i,:),omega_des);
end

% Create PHI (in a loop)
PHI = zeros(M, 28);
% TODO
for j = 1:M
    PHI(j,:) = expandQuad(x(j,:));   
end

% Compute w from a least squares solution of Phi w = f 
% TODO
w = PHI\f;

options = optimoptions('fmincon','display','iter-detailed');
% optimization or surrogate model
J = @(x) expandQuad(x)*w;
x0 = [5, 5, 5, 5, 5, 5];  % starting point

for i = 1:20
    J = @(x) expandQuad(x)*w;
    % perform optimization using surrogate
    % TODO
    [xopt, fopt] = fmincon(J, x0, [], [], [], [], lb, ub, [], options)
    % compute the error in our surrogate prediction and decide whether or not to break
    % TODO
    error = abs((wheel_prototype(xopt,omega_des)-J(xopt))/wheel_prototype(xopt,omega_des));
    factual = wheel_prototype(xopt,omega_des);
    if error<.001
        break
    else
    % if not, add another row to sample data (add a row to PHI and a row to F)
    % be sure to use the actual function value at xopt 
    % and not not the f from fmincon which is based on the surrogate
    % TODO
    M = M + 1;
    f(M,:) = wheel_prototype(xopt,omega_des);
    PHI(M,:) = expandQuad(xopt);
    % re-estimate the surrogate parameters (w)
    w = PHI\f;
    % TODO
    end
    
end

J = @(x) wheel_prototype(x,omega_des);
[xopt, fopt, exitflag, output] = fmincon(J, x0, [], [], [], [], lb, ub);
disp(output.funcCount);


