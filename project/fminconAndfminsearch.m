%homework5

start = 30*ones(1,6);

omega_des = 2*pi();

%options = optimset('Display','iter','TolX',1e-12,'MaxFunEvals',1e4,'TolFun',1e-8,'MaxIter',500,'PlotFcns',@optimplotfval);

options = optimoptions('fmincon','display','iter-detailed', 'PlotFcn',@myplotfun)

%[xopt, fopt] = fminsearch(@(x) wheel_prototype(x,omega_des), start, options)

[xopt, fopt] = fmincon(@(x) wheel_prototype(x,omega_des), start, [], [], [], [], lb, ub, [], options)

function stop = myplotfun(x, optimValues, state)
   
      persistent data
   if ~nargin % example reset mechanism
     data=[];
   end
   if strcmp(state,'iter')
   figure(1)
   hold on
   iteration = optimValues.iteration;
   fval = optimValues.fval;
   plot(iteration,fval, 'ok')
   end
   stop=0;
 end
