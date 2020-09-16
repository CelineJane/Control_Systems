clear all; close all; clc;
%PART 1 Q2

%% a
A = [-4 16 0 0 0;
    -16 -4 0 0 0;
    0 0 -20 1 0;
    0 0 0 -20 1;
    0 0 0 0 -20];

B = [0.2 0;
    0 0;
    0 0;
    0 1;
    -1 0];

C = [2 0 8 -2 0];

D = [0 0];


sys_o = ss(A,B,C,D);

eig(A)

t = linspace(0,10,1000);
u = [heaviside(t-1); heaviside(t-3)];

[y,tt,x] = lsim(sys_o,u,t);

plot(tt,y)
title('Output of Open Loop System')
xlabel('Time (s)')
ylabel('Amplitude')
figure
plot(tt,x)
title('State Variables of Open Loop System')
xlabel('Time (s)')
ylabel('Amplitude')
legend('x1','x2','x3','x4','x5')

%% b

K = place(A,B,[-5+4*j, -5-4*j, -50+40*j, -50-40*j,  -100]);

%% c

sys_cl = ss(A-B*K,B,C,D);
[y2,tt2,x2] = lsim(sys_cl,u,t);

figure
plot(tt2,y2)
title('Output of Closed Loop System')
xlabel('Time (s)')
ylabel('Amplitude')
figure
plot(tt2,x2)
title('State Variables of Closed Loop System')
xlabel('Time (s)')
ylabel('Amplitude')
legend('x1','x2','x3','x4','x5')

%% d
C_new = [0 1 0 0 0;
        1 0 1 0 0;
        0 1 0 1 0];

rank(obsv(A,C_new(1,:)))
rank(obsv(A,C_new(2,:)))
rank(obsv(A,C_new(3,:)))

%% e 
[z,p,k] = besself(5,12);
L = place(A',C_new(2,:)',p);

%% f

sys_o2 = ss(A,B(:,1),C,D(:,1))

figure
step(sys_o2)
title('Open Loop Step Response')
xlabel('Time (s)')
ylabel('Amplitude')

K = place(A,B(:,1),[-5+4*j, -5-4*j, -50+40*j, -50-40*j,  -100]);
sys_unityg = ss(A-B(:,1)*K,B(:,1)*7.725,C,D(:,1));

figure
step(sys_unityg)
title('Closed Loop Step Response with Prefilter')
xlabel('Time (s)')
ylabel('Amplitude')

