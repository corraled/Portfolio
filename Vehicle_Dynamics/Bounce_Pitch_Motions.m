%%%Problem #1, Road Vehicle Dynamics %%%
           %%% Eduardo Corral %%%
% Inputs %
m = 800; % kg spring mass 
I_y = 780; % kg-m^2
k_f = 18400; % N/m Front suspension spring stiffness 
k_r = 21800; % N/m Rear suspesion spring stiffness
L = 2.2; % m wheel base of car
l_f = 1.3; % m center of gravity behinfh front wheel
l_r = 0.9; % m center of gravity behinfh rear wheel

% Sinusoidal road surface with 
lambda = 5; % m wavelength
Z0 = 0.01; % m amplitude

V = 20; %m/s

phi = (2*pi*L)/lambda ; 
i = sqrt(-1); % imaginary number
% mass array
M = [m  0; 
     0  I_y]  
%spring array
K = [k_f+k_r          l_f*k_f-l_r*k_r;
    l_f*k_f-l_r*k_r   (l_f^2)*k_f+(l_r^2)*k_r]  
% F vector
F = [(k_f*Z0)+(k_r*Z0*(cos(-phi)+i*sin(-phi)));
    (l_f*k_f*Z0)-(l_r*k_r*Z0*(cos(-phi)+i*sin(-phi)))] 

omega = (2*pi*V)/lambda;

A = K-((omega^2)*M)

Z = inv(A)*F

