clear all; close all;
% PART 1 Q1
A = [0.9 0.2 0.1 0 -0.3; 
    0 0.9 0.1 0 0;
    0.1 0 0.2 0.1 0;
    0 0 0.3 0.4 0.2;
    0 0.2 0 0 0.8];
B = [0 0; 
    0 0; 
    -1 0; 
    1 0; 
    0 1];
C = [1 0 1 0 0];
D = [0 0];

Binv = pinv(B);

%% a)
rank(ctrb(A, B));
rank(ctrb(A, B(:,1)));
rank(ctrb(A, B(:,2)));

%% b) 
x0= [-45;-5.58;-5.58;0.35;9.4];
u01 = pinv(B(:,1))*((eye(5)-A)*x0);
u02 = pinv(B(:,2))*((eye(5)-A)*x0);

x0_estim1 = A*x0+B(:,1)*u01
x0_estim2 = A*x0+B(:,2)*u02

% both u0's do a reasonable job at getting to the first 4 state variable o
% operating points, but the second actuaor does a better job at getting to
% the last state variable operating point

%% c)
% 
% syms k1 k2 k3 k4 k5 s
% K = [k1 k2 k3 k4 k5];
% ch_eq = det(s*eye(5) - (A-B(:,2)*K))
% solve(ch_eq,s,'MaxDegree', 5)

K = place(A,B(:,2),[0.7+0.1*j, 0.7-0.1*j, 0.07-0.01*j, 0.07+0.01*j, 0.01]); %literally just fudged these poles until K*x0 was close to the steady state value needed for u0
K*x0
%% d)
ts = 0.001;
sys = ss(A-B(:,2)*K,B(:,2),C,D(:,2),ts);
% sys = ss(A-B(:,2)*K,B,C,D(:,2),ts)
t = 0:ts:0.1;
u = heaviside(t);
figure
step(sys)
figure
impulse(sys)
figure
lsim(sys,u,t)

%% e
% 
% u = u02*heaviside(t);
% [y,t1,x2] = lsim(sys,u,t);
% figure
% plot(t1,x2);

x(:,1) = x0_estim2; % 
x_k = x0_estim2; % initial push
for k = 1:length(t)
    x(:,k+1) = (A-B(:,2)*K)*x_k + B(:,2).*298.6558;
    y(:,k) = C*x_k;
    x_k =  x(:,k+1);
   
end

figure
plot(t,x(:,1:end-1))
title('State Variables of Closed Loop System')
xlabel('Time (s)')
ylabel('Amplitude')
legend('x1','x2','x3','x4','x5')

figure
plot(t,y)
title('Ouput of Closed Loop System')
xlabel('Time (s)')
ylabel('Amplitude')

%% e again

x(:,1) = x0_estim2; % 
x_k = x0_estim2; % initial push
for k = 1:length(t)
    if k == 50
        x(:,k+1) = (A-B(:,2)*K)*x_k + B(:,2)*10 + B(:,2).*298.6558;
        y(:,k) = C*x_k;
        x_k =  x(:,k+1);
    
    else
        x(:,k+1) = (A-B(:,2)*K)*x_k + B(:,2).*298.6558;
        y(:,k) = C*x_k;
        x_k =  x(:,k+1);
    end
    
end

figure
plot(t,x(:,1:end-1))
title('State Variables of Closed Loop System with Disturbance at t = 0.05')
xlabel('Time (s)')
ylabel('Amplitude')
legend('x1','x2','x3','x4','x5')

figure
plot(t,y)
title('Ouput of Closed Loop System with Disturbance at t = 0.05')
xlabel('Time (s)')
ylabel('Amplitude')



