omega_des = 6.28;
fun = @(x) wheel_prototype(x,omega_des);
nvars = 6;
A = [];
B = [];
Aeq = [];
beq = [];
lb = [0];
ub = [48];
nonlcon = [];
options = optimoptions('ga',...
    'display', 'iter',...
    'PlotFcn', 'gaplotbestindiv');
ga(fun,nvars,A,B,Aeq,beq,lb,ub,nonlcon,options)