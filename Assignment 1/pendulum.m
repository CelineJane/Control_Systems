clear all; close all;

l = 0.25;    % Length of the pendulum [m]
g = 9.8;

t = linspace(0,4,400);
q0 = pi/14; % The initial angle [rad]
v0 = 0;    % The intial angular velocity [rad/s]
x0 = [q0 v0];

A = [0 1; -g/l 0] ;

for k = 1:length(t)
    phi = expm(t(k).*A);
    x(k,:) = phi*x0';
end

figure(1)
subplot(2,1,1)
plot(t,x(:,1))
ylabel('$\theta$ [rad s$^{-1}$]', 'Interpreter', 'latex', 'Rotation', 90);
title('Continous Linear Pendulum System over Time using State Space Model')

subplot(2,1,2)
plot(t,x(:,2))
xlabel('Time  (s)', 'Interpreter', 'latex');
ylabel('$\frac{d\theta}{dt}$ [rad s$^{-1}$]', 'Interpreter', 'latex', 'Rotation', 90);

figure(2)
plot(x(:,1),x(:,2))
xlabel('$\theta$ [rad]', 'Interpreter', 'latex');
ylabel('$\frac{d\theta}{dt}$ [rad s$^{-1}$]', 'Interpreter', 'latex', 'Rotation', 90);
title('Continuous Linear Pendulum System State Variables using State Space Model')
% xlim([-0.25 0.25])


%discrete, part 2, q2c
ts = [0.02, 0.06, 0.2, 0.6];
samples = 4./ts;

for s = 1:length(samples)
    t_d = linspace(0,4,samples(s));

    A_d = expm(ts(s).*A);
    x_k = x0;
    x_d(1,:) = x0;

    for k = 1:samples(s)
        x_d(k+1,:) = A_d*x_k';
        x_k = x_d(k+1,:);
    end
    figure(3)
    
    subplot(2,1,1)
    hold on
    plot(t_d,x_d(2:end,1))
    subplot(2,1,2)
    hold on
    plot(t_d,x_d(2:end,2))

    figure(4)
    hold on
    plot(x_d(:,1),x_d(:,2))
    
    clear x_d
end

figure(3) 
subplot(2,1,1)
title('Discrete Linear Pendulum System over Time')
legend('ts = 0.02','0.06','0.2','0.6')
ylabel('$\theta$ [rad]', 'Interpreter', 'latex');
subplot(2,1,2)
xlabel('Time (s)', 'Interpreter', 'latex');
ylabel('$\frac{d\theta}{dt}$ [rad s$^{-1}$]', 'Interpreter', 'latex', 'Rotation', 90);


figure(4) 
legend('ts = 0.02','0.06','0.2','0.6')
xlabel('$\theta$ [rad]', 'Interpreter', 'latex');
title('Discrete Linear Pendulum System State Variables')
ylabel('$\frac{d\theta}{dt}$ [rad s$^{-1}$]', 'Interpreter', 'latex', 'Rotation', 90);