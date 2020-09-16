function nonlinear_pendulum

% This function simultaneously runs two simulations of a pendulum.
% The first (describing the evolution of x_1 and x_2) is a full nonlinear
% model. The second, describing x_3 and x_4 is a model linearised around
% an angle of zero (ie. the pendulum straight down).

l = 0.25;    % Length of the pendulum [m]
g = 9.8;     % Acceleration due to gravity [m/s^2]

tspan = linspace(0,4,400);
q0 = pi/2; % The initial angle [rad]
v0 = 0;    % The intial angular velocity [rad/s]
x0 = [q0 v0 q0 v0];

% This line runs a numerical ODE solver, ode23, to find the state of the
% system at all of the times specified in tspan.
[t, x] = ode23(@f, tspan, x0);

clf;
figure(1)
subplot(2,1,1)
plot(t,x(:,1),'b', t,x(:,3),'r') % Compare positions from two models.
h=ylabel('$\theta$ [rad]', 'Interpreter', 'latex', 'Rotation', 0);
set(h, 'HorizontalAlignment', 'right')
legend('Nonlinear', 'Linearised')
title('State Variables over time of Linear and Nonlinear Pendulum System, initial angle = $\frac{\pi}{2}$','Interpreter', 'latex')

subplot(2,1,2)
plot(t,x(:,2),'b', t,x(:,4),'r') % Compare velocities from two models.
h=ylabel('$\frac{d\theta}{dt}$ [rad s$^{-1}$]', 'Interpreter', 'latex', 'Rotation', 0);
set(h, 'HorizontalAlignment', 'right')


figure(2)
hold off
plot(x(:,1), x(:,2), 'b');
hold on
plot(x(:,3), x(:,4), 'r');


legend('Nonlinear', 'Linearised')

xlabel('$\theta$ [rad]', 'Interpreter', 'latex');
h=ylabel('$\frac{d\theta}{dt}$ [rad s$^{-1}$]', 'Interpreter', 'latex', 'Rotation', 0);
set(h, 'VerticalAlignment', 'middle')
set(h, 'HorizontalAlignment', 'right')
title('State Variables of Linear and Nonlinear Pendulum System, initial angle = $\frac{\pi}{2}$','Interpreter', 'latex')


    function dxdt = f(t, x)
        dxdt = [ x(2)
               -g/l*sin(x(1))
               x(4)
               -g/l*x(3)
               ];
    end

end





