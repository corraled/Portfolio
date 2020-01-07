%%% Problem Info %%%
%%% Car turning at constant radius circle at constant speed. It has Ackeman
%%% steering and is turning at .9 g.
%%% Find front axle's slip angles and steering angles for R= 25 m and R = 100m 
clear all
close all
clc


Ay = 0.6; % g
g = 9.81; 
R = 25; % Evaluate at this radius 

syms delo deli alphai alphao
%%% Inputs %%%%

%%% Vehicle Info
m = 850; %kg
L = 2.1; % m
a = 1.2; %m
h = 0.38;%m
b = L-a;%m

% Front Suspension Info
tf = 1.34; %m
zf = 0.05; %m
kf = 12000; % N/m
karbf = 28000; % N/m
Cmf = 370*(180/pi); % N/deg
Wmf = 2700; % N
uf = 1.2; % coefficient of friction

% Rear Suspension Info
tr = 1.38; %m
zr = 0.3; %m
kr = 16000; % N/m
karbr = 0; % N/m
Cmr = 450*(180/pi); % N/deg
Wmr = 3600; % N
ur = 1.2; % coefficient of friction

% Calculated Values
W = m*g; %weight of vehicle 
Wf = W*(b/L); % Front weigth 
Wr = W*(a/L); % Rear weigth

% roll stiffness with arb and springs 
K_phif = 0.5*kf*(tf^2)+karbf; % F roll stiffness
K_phir = 0.5*kr*(tr^2)+karbr; % F roll stiffness

% roll radius 
r0 = h-(zf*(b/L)+zr*(a/L));

X = (Wf*Ay);

% roll angle 
phi = (Ay*r0*W)/((K_phif+K_phir)-r0*W); 

% Forces distribution of front tires
DFzf = (1/tf)*((K_phif*phi)+zf*Wf*Ay);

% Outside tire
Fzfo = (Wf/2)+DFzf; % weigth of the tire in N
Cfo = ((Cmf*Fzfo)/Wmf)*(2-(Fzfo/Wmf)); % cornering stifness N/rad
alphafomax = (2*uf*Fzfo/Cfo); % max slip angle in rad

% Inside tire
Fzfi = (Wf/2)-DFzf; % weigth of the tire in N
Cfi = ((Cmf*Fzfi)/Wmf)*(2-(Fzfi/Wmf)); % cornering stifness N/rad
alphafimax = (2*uf*Fzfi/Cfi); % max slip angle in rad

% Calculate at R = 25
thetao = acot ((R+(tf/2))/L); % outside velocity angle
thetai = acot ((R-(tf/2))/L); % outside velocity angle

eqns = [deli == acot(cot(delo)-(tf/L)),
    alphao == delo-thetao,
    alphai == deli-thetai,
    0 == (((Cfi/(2*alphafimax))*alphai^2)+((Cfo/(2*alphafomax))*alphao^2))-(Cfi*alphai+Cfo*alphao)+ X];

var = [deli, delo, alphao, alphai];

S = vpasolve(eqns, var);

R % Radius
fprintf('Front Inside Steer Angle'), S.deli*(180/pi) %Front Inside Steer Angle
fprintf('Rear Outside Steer Angle'), S.delo*(180/pi) % Rear Outside Steer Angle

fprintf('Front Inside Velocity Angle'), thetai*(180/pi) % Front inside velocity angle 
fprintf('Rear Outside Velocity Angle'), thetao*(180/pi) % Rear outside velocity angle 

fprintf('Front Inside Slip Angle'), S.alphai*(180/pi) % Front inside slip angle 
fprintf('Rear Outside Slip Angle'), S.alphao*(180/pi) % Rear outside slip angle 



