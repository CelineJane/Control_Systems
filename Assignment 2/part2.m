close all; clear all; clc;
% PART 2

A = [0.99 0;
    0 0.99];

B = [0.001 0
    0 0.001];

C = [0.5 0.5;
    1 -1];

D = [0 0;
    0 0];

ts = 0.05;
t = 0:ts:10;
u = [heaviside(t); heaviside(t)];

sys = ss(A,B,C,D,ts);
[y,tt,xx]=lsim(sys,u,t);

subplot(2,1,1)
plot(tt,y(:,1))
title('Open Loop Step Response')
ylabel('Amplitude')
subplot(2,1,2)
plot(tt,y(:,2))
xlabel('Time (s)')
ylabel('Amplitude')

K = place(A,B,[0.9 0.9]);

sys2 = ss(A-B*K,B,C,D,ts)
figure
[y,tt,xx]=lsim(sys,u,t);
subplot(2,1,1)
plot(tt,y(:,1))
subplot(2,1,2)
plot(tt,y(:,2))


x(:,1) = [0;0]; % start speeds at o
x_k = A*x(:,1)+ B*[1;1]; % initial push u = [1000,1000] 
r = [1;1]; % contant speed ref
yy(:,1) = [0;0];

for k = 1:length(t)
%     if k == 100
%         r = [2;2];
%     end
    x(:,k+1) = (A-B*K)*x_k +10*B*r;
    yy(:,k+1) = C*x_k;
    x_k =  x(:,k+1);

end

figure

subplot(2,1,1)
plot(t,yy(1,1:end-1))
title('Closed Loop Step Response')
ylabel('Amplitude')
subplot(2,1,2)
plot(t,yy(2,1:end-1))
xlabel('Time (s)')
ylabel('Amplitude')

%% b
clear x y x_k
clc; 
close all;
A_unc = A+0.1*randn(2)
t = 0:ts:50;

% s = ss(A_i-B_i*K_i,[N.*B;ones(size(B))],[C zeros(size(C)); zeros(length(C),4)], zeros(4,2),ts)
% % s = ss(A_i-B_i*K_i,[zeros(size(B));ones(size(B))],[C zeros(size(C)); zeros(length(C),4)], zeros(4,2),ts)'
% 
% % figure
% % step(s,10)
% % [y,tt,x] = step(s,10);
% 
% 
% t = 0:ts:10;
% u = [heaviside(t-1); heaviside(t-1)];
% [y,tt,x] = lsim(s,u,t);
% figure
% subplot(2,1,1)
% plot(tt,y(:,1))
% subplot(2,1,2)
% plot(tt,y(:,2))

% figure
% plot(t,x(:,1:end-1))

% w0 = 20;
% K_i = place(A,B,[w0*(-0.7071+0.7071*j) w0*(-0.7071-0.7071*j)]); %ITAE 
K_i = place(A,B,[1 0.9]);
K = place(A,B,[0.1+0.1*j 0.1-0.1*j]);

r = [heaviside(t) + 2*heaviside(t-25) ;zeros(1,length(t))- heaviside(t-25)] ;
inp = [heaviside(t); heaviside(t)];
y(:,1) = [0;0];
x(:,1) = [0;0];
x_i(:,1) = [0;0];
x_k = [0;0];

%without plant uncertainty
for k = 1:length(t)
    x(:,k+1) = (A-B*K)*x_k - (B*K_i)*x_i(:,k);% + B*inp(:,k);
    x_i(:,k+1) = -C*x_k + x_i(:,k) + r(:,k);
    y(:,k+1) = C*x_k;
    x_k =  x(:,k+1);
end

figure
subplot(2,1,1)
title('Closed Loop Integral Control without Plant Uncertainty')
hold on
ylabel('Amplitude')
plot(t,y(1,1:end-1))
plot(t,r(1,:))
subplot(2,1,2)
hold on
plot(t,y(2,1:end-1))
plot(t,r(2,:))
legend('Output','Reference')
xlabel('Time (s)')
ylabel('Amplitude')

% figure
% plot(t,x(:,1:end-1))

%with plant uncertainty
clear x y x_k
K_i = place(A_unc,B,[1 0.9]);
K = place(A_unc,B,[0.01+0.01*j 0.01-0.01*j]);

y(:,1) = [0;0];
x(:,1) = [0;0];
x_i(:,1) = [0;0];
x_k = [0;0];

for k = 1:length(t)
    x(:,k+1) = (A_unc-B*K)*x_k - (B*K_i)*x_i(:,k);% + B*inp(:,k);
    x_i(:,k+1) = -C*x_k + x_i(:,k) + r(:,k);
    y(:,k+1) = C*x_k;
    x_k =  x(:,k+1);
end

figure
subplot(2,1,1)
title('Closed Loop Integral Control without Plant Uncertainty')
hold on
ylabel('Amplitude')
plot(t,y(1,1:end-1))
plot(t,r(1,:))
subplot(2,1,2)
hold on
plot(t,y(2,1:end-1))
plot(t,r(2,:))
legend('Output','Reference')
xlabel('Time (s)')
ylabel('Amplitude')

% figure
% plot(t,x(:,1:end-1))




