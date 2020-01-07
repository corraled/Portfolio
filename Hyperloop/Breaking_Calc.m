% RI = static laden radius of tyre, taken as assumption from prior work: https://docs.google.com/spreadsheets/d/18sqXGNELmf9BEVKBcknFtXnGIxWJtT7rPibMKpvpjE0/edit#gid=0
% Mw = mass of wheel 
% M = mass , taken as assumption from prior work: https://docs.google.com/spreadsheets/d/18sqXGNELmf9BEVKBcknFtXnGIxWJtT7rPibMKpvpjE0/edit#gid=0
% a = desired deceleration in g
% R = static laden radius of tyre, taken as assumption from prior work: https://docs.google.com/spreadsheets/d/18sqXGNELmf9BEVKBcknFtXnGIxWJtT7rPibMKpvpjE0/edit#gid=0
%uf = cofficient of friction of lining material on disc material :http://www.wilwood.com/BrakePads/BrakePadsApp.aspx?compound=BP-10
%D = Usable outside diameter assumed to be Diameter of Rotor taken from Rotor specifications : http://www.wilwood.com/BrakeKits/BrakeKitsProdFront.aspx?itemno=140-11071&year=1968&make=Ford&model=Mustang&option=Drum+Brake+Front+Spindle
%d = usuable inside diameter assumed to be Diameter of Rotor - pad hight - .2in : http://www.wilwood.com/Images/BrakePads/600Pixel%20Pad%20Drawings/7112.jpg
%Ap = Pad Area
%Weight Transfer
%WB = wheel base
%CGH = center of gravity height
Ap = 6.36;
D = 11; %in
d = 2.38*2%in
uf = .4;
RI = .67; % ft
Mw = 40; %lb
M = 600; %lb
g = 32.2; % ft/s^2
a = .5; % %g
R = 1; %ft
WB = 8; %ft
CGH = 1; %ft

I = Mw * RI^2

%Me = effective mass
Me = M + ((4*I)/R^2)

%delts_w

delta_w = (CGH/WB)*Me*a

%WT = Weight transfer

WT = ((Me/2)+ delta_w)/Me

% BF = breaking force
BF = Me * a

% BFf = breaking force front
BFf = WT * BF

% Tb = breaking torque
Tb = BFf * R * WT

%Re = effective radius
Re = 4.6625%(D+(d-.2))/4

%Cl = Clamp load
Cl = (Tb * 12)/(Re*uf*2)

%Pb = Break Pressure
Pb = Cl / Ap

%%%%%%%
%thermal
%%%%%%%

%Bt = break time
Bt = 10 %s


%KE = Kenitic Energy

KE = .5*Me/2.2*(Bt^2)% J

%Bp = Breaking Power

Bp = KE/Bt %W

q = (4*delta_w)/((pi*11*.0254)^2 - (7.75*.0254)^2) 