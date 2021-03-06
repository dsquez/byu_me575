function kinematic_calibration(optimizer)
%% create robot model
max_height = 1.2;

% made up values
a1 = 0.5 - 0.018374523;
a2 = 0.4 + 0.01265836;
a3 = 0.1 - 0.00201927;
a4 = 0.15 + 0.00948365;
a5 = 0.2 - 0.003285676;

true_robot = threelink(max_height,a1,a2,a3,a4,a5);
%% set up variables

actual_lengths = [ a1 a2 a3 a4 a5 ];

q1 = 0;
q2 = 0.524;
q3 = -0.524;
q4 = 0;
q5 = pi/2;
q6 = 0;

q = lhsdesign(20,6);
q(:,1) = q(:,1).*max_height;
q(:,2) = q(:,2).*(2*pi/12) - pi/12;
q(:,3) = q(:,3).*(2*pi/12) - pi/12;
q(:,4) = q(:,4).*(2*pi/12) - pi/12;
q(:,5) = q(:,5).*(2*pi/12) - pi/2;
q(:,6) = q(:,6).*(2*pi/12) - pi/12;
% q = [ q1 q2 q3 q4 q5 q6 ];
% true_fkine = true_robot.fkine(q); % TODO get this from camera transforms
% true_fkine = getFkineFromCamera()


func = @(x) getfkineError(x);

    function error = getfkineError(x)
        robot = threelink(max_height,x(1),x(2),x(3),x(4),x(5));
        error_vec = zeros(length(q(:,1)),1);
        for i = 1:length(q(:,1))
            true_fkine = true_robot.fkine(q(i,:));
            fk = robot.fkine(q(i,:));
            error = max(max(abs(fk - true_fkine)));
            error_vec(i) = error;
        end
        error = prctile(error_vec,95);
    end
x0 = [ 0.5 0.4 0.1 0.15 0.2 ];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [ 0.4 0.3 0.0 0.0 0.1 ];
ub = [ 0.6 0.5 0.2 0.25 0.3 ];
con = [];

%% fmincon
if optimizer == "fmincon"
    options = optimoptions('fmincon',...
        'display', 'iter-detailed',...
        'StepTolerance', 1e-16,...
        'Algorithm', 'sqp',...
        'MaxFunctionEvaluations', 10000,...
        'PlotFcn', 'optimplotfval');
    disp("fmincon")
    [xopt, fopt] = fmincon(func,x0,A,b,Aeq,beq,lb,ub,con,options)
    
elseif optimizer == "fminsearch"
    options = optimset('Display', 'iter',...
        'TolFun', 1e-12,...
        'TolX', 1e-12,...
        'MaxFunEvals', 1e4,...
        'MaxIter', 1e7,...
        'PlotFcns', @optimplotfval);
    
    [xopt,fopt] = fminsearch(func,x0,options)
    
elseif optimizer == "ga"
    options = optimoptions('ga',...
        'display', 'iter',...
        'PlotFcn', 'gaplotbestf');
    [xopt, fopt] = ga(func,5,A,b,Aeq,beq,lb,ub,con,options)
end
% error = xopt - actual_lengths
%%
% figure(1)
% set(gca,'YScale','log')
end



                                                            