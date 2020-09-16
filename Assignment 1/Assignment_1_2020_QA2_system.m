% System for ECEN415 A1QA2 - 2020
clc; clear all; close all;
A=[10.82      108    134.1    3.984     -158   -215.5;
   49.42    147.6      193   -12.35   -244.5   -300.6;
   45.63    96.03    128.8   -14.05   -171.6   -205.9;
   24.25    133.8    171.4   -9.292   -202.4   -253.3;
  -5.276    41.41    63.45  -0.2878   -61.75   -90.67;
   61.16    125.1    153.3   -15.06   -214.5   -245.2];
 
B=[40.09  41.53;
   58.21  17.69;
   47.67  39.54;
   70.68  29.22;
      68  40.83;
   4.172  6.671];
 
C=[    72   15.96   4.136   28.21  -83.11  -84.99;
    0.8464   -36.2  -45.34   -37.6   96.07   86.09];

 
D =  [0   0;
      0   0];
  
  
sys_ss = ss(A,B,C,D);
sys_tf = tf(sys_ss);

figure
bode(sys_tf)

[sys_can T] = canon(sys_ss,'Modal');
sys_og = ss2ss(sys_can,inv(T));

t = linspace(0,10,1000);
u = [heaviside(t-1); 2*heaviside(t-6)];
% u2 = 2*heaviside(t-6);

figure
[y,t1,x] = lsim(sys_ss,u,t);
plot(t1,x)

figure
lsim(sys_ss,u,t)

figure
lsim(sys_can,u,t)

figure
[y,t1,x] = lsim(sys_can,u,t);
plot(t1,x)
e = eig(A)