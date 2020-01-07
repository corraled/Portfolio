%%% Problem X5-2, Road Vehicle Dynamics%%%
         %%% Eduardo Corral %%%
% Inputs %
m_c = 200; % kg corner mass
m_us = 16; % kg unsprung mass 
k_s = 13000; % suspension spring stiffness
k_t = 150000; % tire spring stiffness
c = 2400; % damping coefficient

% Sinusoidal road surface with 
lambda = 5; % m wavelength
Zr = 0.01; % m amplitude

V = linspace(0,40,500); % speed vector 

M = [m_c 0 ; 0 m_us];   % mass array
C = [c -c ; -c c];  %damping array
K = [k_s -k_s ; -k_s k_s+k_t];  %spring array
F = [0 ; k_t*Zr]; % F vector
i = sqrt(-1); % amplitude

for inter = 1:length(V)
    omega = (2*pi*V(inter))/lambda;
    A = (-omega^2*M)+(i*omega*C)+K;
    Z = inv(A)*F;
    Z_1(inter) = abs(Z(1));
    Z_2(inter) = abs(Z(2));
    ampF(inter)=k_t*abs(Zr-Z(2));
end

plot(V,ampF,'k-')
axis([0 40 0 1400]);
grid
title('Problem X5-2 c=2400 N-s/m')
xlabel('Speed in m/s')
ylabel('Fluctuation Amplitude in Tire in N')
output = [V' Z_1' Z_2' ampF']

