%%% Problem X5-1, Road Vehicle Dynamics %%%
        %%% Eduardo Corral %%%

% Inputs %
m_c = 200; % kg corner mass
m_us = 16; % kg unsprung mass 
k_s = 13000; % suspension spring stiffness
k_t = 150000; % tire spring stiffness
c = 900; % damping coefficient

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
    Z_mag = abs(Z);
    Z_1(inter) = Z_mag(1);
    Z_2(inter) = Z_mag(2);
end

plot(V,Z_1,'k-',V,Z_2,'K--')
axis([0 40 0 0.025]);
title('Problem X5-1 c=900 N-s/m')
xlabel('Speed in m/s')
ylabel('Amplitude of Vibration in m')
grid
legend('Car','Tire')
output = [V' Z_1' Z_2']



