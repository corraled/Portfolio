R1 = ;   %inner radius of tire (inches)
R2 = ;   %outer radius of tire (inches)
L =  ;   %width of tire (inches)
F =  ;   %force exerted down on tire
E1 = ;   %Young's Modulus of tire
E2 = ;   %Young's Modulus of rail
v1 = ;   %Poisson's ratio of tire
v2 = ;   %Poisson's ratio of rail
m = 1/v1;       %inverse of Poisson's ratio used in some calculations (not sure why)
UltimateTensileStrength = ;   %Ultimate tensile strength of tire material
yieldStrength = ;    %yield strength of tire material
density = ;  %density of tire material
linearVelocity = 367;   %linear velocity of tire in ft/s
angularVelocity = linearVelocity*12/R2;   %angular velocity of tire (rad/s)

%For hollow cylinder
MaxHoopStress = (density * angularVelocity^2)/8*((3-(2/m))/(1-(1/m)))*((2*R2^2+R1^2)-((1+(2/m))/(3-(2/m)))*R1^2)
MaxRadialStress = (density * angularVelocity^2)/8*((3-(2/m))/(1-(1/m)))*(R1-R2)^2
    %Occurs at r = sqrt(r1*r2)

ElasticHoopStress = ((density*angularVelocity^2)/8)*((3+v1)*R2^2-(1+3*v1)*R1^2);
ElasticRadialStress = (3+v1)*((density*angularVelocity^2)/8)*(R2^2-R1^2);
AverageHoopStress = (density*angularVelocity^2*R2^2)/3;
ElasticSpeedLimit = angularVelocity*(UltimateTensileStrength/AverageHoopStress)^(1/2);
HyperstaticHoopStress1 = AverageHoopStress - ElasticHoopStress;
HyperstaticHoopStress2 = ((density*angularVelocity^2)/24)*(1+3*v1)*(3*r1^2+R2^2);   %should be same as HyperstaticHoopStress1
HyperstaticRadialStress = ((density*angularVelocity^2)/24)*(1+3*v1)*(r1^2-R2^2);


b = (4*F*(((1-(v1^2))/E1)+((1-(v2)^2)/E2))/(Pi*L*((1/R1)+(1/R2))))^(1/2);   %b = half of contact patch in direction of wheel travel
Pmax = 2*F/(Pi*b*L);    %Maximum contact stress
SigmaX = -2*v1*Pmax*(((z^2)/(b^2)+1)^(1/2)*abs(z/b));   %Stress in X
SigmaY = -Pmax*((2-((z^2)/(b^2)+1)^(-1))*((z^2)/(b^2)+1)^(1/2)-2*abs(z/b));     %Stress in Y
SigmaZ = -Pmax*(((z^2)/(b^2)+1)^(-1));      %Stress in Z
TauX = abs((Sigma2-Sigma3)/2);      %Strain in X
TauY = abs((Sigma1-Sigma3)/2);      %Strain in Y
TauZ= abs((Sigma1-Sigma2)/2);       %Strain in Z