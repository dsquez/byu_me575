%Optimization Project Function

function max_e = wheel_prototype(x, omega_des)



x0 = [0 0];
t = [0 0.1];

load_torque = [.2 .1 .1 .1 .1 .3];
V = x;

[xout1, yout1] = ode45(@voltage_motor1,t,x0);

%plot(xout1,yout1(:,2))

[xout2, yout2] = ode45(@voltage_motor2,t,x0);

%plot(xout2,yout2(:,2))

[xout3, yout3] = ode45(@voltage_motor3,t,x0);

%plot(xout3,yout3(:,2))

[xout4, yout4] = ode45(@voltage_motor4,t,x0);

%plot(xout4,yout4(:,2))

[xout5, yout5] = ode45(@voltage_motor5,t,x0);

%plot(xout5,yout5(:,2))

[xout6, yout6] = ode45(@voltage_motor6,t,x0);

%plot(xout6,yout6(:,2))

Yout = [yout1(end,2),yout2(end,2),yout3(end,2),yout4(end,2),yout5(end,2),yout6(end,2)];

error = abs(Yout - omega_des);

max_e = max(error);

%diff = range(Yout);

    function x_dot = voltage_motor1(t,x)
        
        R = 1; %ohms
        L = .995e-3; %henrys
        I = .25 * .2^2;
        %I = 1;
        k = 91e-3; %rad/s/V
        c = 0;
        
        Vs = V(1);
        tau = load_torque(1);
        
        w = x(2);
        i = x(1);
        
        x_dot = zeros(length(x),1);
        
        x_dot(1) = (Vs - R*i - k*w) / L;
        x_dot(2) = (k*i - tau - c*w) / I;
        
    end

    function x_dot = voltage_motor2(t,x)
        
        R = 1; %ohms
        L = .995e-3; %henrys
        I = .25 * .2^2;
        %I = 1;
        k = 91e-3; %rad/s/V
        c = 0;
        
        Vs = V(2);
        tau = load_torque(2);
        
        w = x(2);
        i = x(1);
        
        x_dot = zeros(length(x),1);
        
        x_dot(1) = (Vs - R*i - k*w) / L;
        x_dot(2) = (k*i - tau - c*w) / I;
        
    end

    function x_dot = voltage_motor3(t,x)
        
        R = 1; %ohms
        L = .995e-3; %henrys
        I = .25 * .2^2;
        %I = 1;
        k = 91e-3; %rad/s/V
        c = 0;
        
        Vs = V(3);
        tau = load_torque(3);
        
        w = x(2);
        i = x(1);
        
        x_dot = zeros(length(x),1);
        
        x_dot(1) = (Vs - R*i - k*w) / L;
        x_dot(2) = (k*i - tau - c*w) / I;
        
    end

    function x_dot = voltage_motor4(t,x)
        
        R = 1; %ohms
        L = .995e-3; %henrys
        I = .25 * .2^2;
        %I = 1;
        k = 91e-3; %rad/s/V
        c = 0;
        
        Vs = V(4);
        tau = load_torque(4);
        
        w = x(2);
        i = x(1);
        
        x_dot = zeros(length(x),1);
        
        x_dot(1) = (Vs - R*i - k*w) / L;
        x_dot(2) = (k*i - tau - c*w) / I;
        
    end

    function x_dot = voltage_motor5(t,x)
        
        R = 1; %ohms
        L = .995e-3; %henrys
        I = .25 * .2^2;
        %I = 1;
        k = 91e-3; %rad/s/V
        c = 0;
        
        Vs = V(5);
        tau = load_torque(5);
        
        w = x(2);
        i = x(1);
        
        x_dot = zeros(length(x),1);
        
        x_dot(1) = (Vs - R*i - k*w) / L;
        x_dot(2) = (k*i - tau - c*w) / I;
        
    end

    function x_dot = voltage_motor6(t,x)
        
        R = 1; %ohms
        L = .995e-3; %henrys
        I = .25 * .2^2;
        %I = 1;
        k = 91e-3;%105*.10472; %rad/s/V
        c = 0;
        
        Vs = V(6);
        tau = load_torque(6);
        
        w = x(2);
        i = x(1);
        
        x_dot = zeros(length(x),1);
        
        x_dot(1) = (Vs - R*i - k*w) / L;
        x_dot(2) = (k*i - tau - c*w) / I;
        
    end

end
