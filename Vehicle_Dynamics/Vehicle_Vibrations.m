%%% EDUARDO CORRAL %%%

%input data
m= 1000; % kg mass of the vehicle 
j0= 800; % kg-m2 mass moment of inertia
kf= 20; % kN/m stiffness of the front suspension and tires
kr= 25; % kN/m stiffness of the rear suspension and tires
l1= 1.0; % m distance of the front wheels from the center of gravity
l2= 1.5; % m distance of the rear wheels from the center of gravity
v= 15; % m/s velocity
d= 10; %m distance

yf= 0.05*sin(((2*3.1416*v)/10)*tt); %m downward ground displacement of the front wheels
yr= 0.05*sin(((2*3.1416*v/10)*tt)-((2*3.1416*(l1+l2))/d)); %m downward ground displacement of the rear wheels

dt=0.001;
nt=18000;
z1=0;z2=0;z3=0;z4=0;

for n=1:nt;
tt=n*dt;

f1=z2;
f2=-(45*z1)-(17.5*z3)+(sin(9.4248*tt)+sin((9.4248*tt)-1.5708));
f3=z4;
f4=-((17500/800)*z1)-((76250/800)*z3)+((1/800)*((1875*sin((9.4248*tt)-1.5708))-(1000*sin((9.4248*tt)))));

z1=z1+(dt*f1);
z2=z2+(dt*f2);
z3=z3+(dt*f3);
z4=z4+(dt*f4);

zt(n)=tt;
x1(n)=z1;
x2(n)=z2;
x3(n)=z3;
x4(n)=z4;

end;

%%% PLOT %%%
plot(zt,x1,zt,x2,zt,x3,zt,x4)
axis([0 20 -8 8])


