clc
close all
clear all
%%%%%%%%%%%%%%%%%%%%%%     PROJECT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   EDUARDO CORRAL %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Define Parameters %%%%%%%%%%%%%%%%%%%%%%%%%
E1=4;
E2=1000;
E3=1200;
E4=1400;
tau1=495.7; %relaxation time at 25 C
tau2=495.4; %relaxation time at 25 C
tau3=1841; %relaxation time at 25 C
%%%%%% Step 1
tim_tot1=120;% total stress relaxation time
stretch=0.2; % constant strain for stress relaxation
%%%%%% Step 2
tim_tot2=600;
%%%%%% Step 3
tim_tot3=600;
%%%%%% Step 4
tim_tot4=3600;

%%%%%%%%%%%%%%%%%%%%%%% Step 1 at 60 C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nstep1=100; %number of steps
dt1=tim_tot1/nstep1; %time increment in each step
loading_rate=stretch/tim_tot1;

%%%%%% define the matrix for Step 1
time1=zeros(nstep1+1,1); %time
e1_1=zeros(nstep1+1,1); %strain in branch 1
sig1_1=zeros(nstep1+1,1); %stress in branch 1
e2_1=zeros(nstep1+1,1); %strain in branch 2
sig2_1=zeros(nstep1+1,1); %stress in branch 2
e3_1=zeros(nstep1+1,1); %strain in branch 3
sig3_1=zeros(nstep1+1,1); %stress in branch 3
e4_1=zeros(nstep1+1,1); %strain in branch 4
sig4_1=zeros(nstep1+1,1); %stress in branch 4
e_tot_1=zeros(nstep1+1,1); %total strain, which equals to the strain of branch 1
sig_tot_1=zeros(nstep1+1,1); %total stress

% define the initial value of the matrix
time1(1)=0;
e1_1(1)=0;
sig1_1(1)=0;
e2_1(1)=0;
sig2_1(1)=0;
e3_1(1)=0;
sig3_1(1)=0;
e4_1(1)=0;
sig4_1(1)=0;
e_tot_1(1)=0;
sig_tot_1(1)=0;

% iterations
for i=1:nstep1
   time1(i+1)=time1(i)+dt1; % update time
   de1_1=dt1*loading_rate; %  strain increment in branch 1
   e1_1(i+1)=e1_1(i)+de1_1; %  update the strain in branch 1
   sig1_1(i+1)=E1*e1_1(i+1); %  update the stress in branch 1
   de2_1=(de1_1-dt1*e2_1(i)/(tau1*0.00005))/(1+dt1/(tau1*0.00005)); %  strain increment in branch 2
   e2_1(i+1)=e2_1(i)+de2_1; %  update the strain in branch 2
   sig2_1(i+1)=E2*e2_1(i+1);  % update the stress in branch 2   
   de3_1=(de2_1-dt1*e3_1(i)/(tau2*0.00005))/(1+dt1/(tau2*0.00005)); %  strain increment in branch 3
   e3_1(i+1)=e3_1(i)+de3_1; %  update the strain in branch 3
   sig3_1(i+1)=E3*e3_1(i+1);  % update the stress in branch 3   
   de4_1=(de3_1-dt1*e4_1(i)/(tau3*0.00005))/(1+dt1/(tau3*0.00005)); %  strain increment in branch 4
   e4_1(i+1)=e4_1(i)+de4_1; %  update the strain in branch 4
   sig4_1(i+1)=E4*e4_1(i+1);  % update the stress in branch 4  
   sig_tot_1(i+1)=sig1_1(i+1)+sig2_1(i+1)+sig3_1(i+1)+sig4_1(i+1);  % update the total stress
   e_tot_1(i+1)=e1_1(i+1); % update the total strain
end

figure
title('60 C')
subplot(5,2,1)
plot(time1, sig_tot_1, 'r' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Stress (MPa)')
title('Step 1 Stress')
subplot(5,2,2)
plot(time1, e_tot_1, 'k' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Strain')
title('Step 1 Strain')

%%%%%%%%%%%%%%%%%%%%%%%% Step 2 at 60 C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nstep2=100; %number of steps
dt2=tim_tot2/nstep2; %time increment in each step

%%%%%% define the matrix for Step 2
time2=zeros(nstep2+1,1); %time
e1_2=zeros(nstep2+1,1); %strain in branch 1
sig1_2=zeros(nstep2+1,1); %stress in branch 1
e2_2=zeros(nstep2+1,1); %strain in branch 2
sig2_2=zeros(nstep2+1,1); %stress in branch 2
e3_2=zeros(nstep2+1,1); %strain in branch 3
sig3_2=zeros(nstep2+1,1); %stress in branch 3
e4_2=zeros(nstep2+1,1); %strain in branch 4
sig4_2=zeros(nstep2+1,1); %stress in branch 4
e_tot_2=zeros(nstep2+1,1); %total strain, which equals to the strain of branch 1
sig_tot_2=zeros(nstep2+1,1); %total stress

% define the initial values of the matrix for Step 2
time2(1)=time1(end);
e1_2(1)=e1_1(end);
sig1_2(1)=sig1_1(end);
e2_2(1)=e2_1(end);
sig2_2(1)=sig2_1(end);
e3_2(1)=e3_1(end);
sig3_2(1)=sig3_1(end);
e4_2(1)=e4_1(end);
sig4_2(1)=sig4_1(end);
e_tot_2(1)=e_tot_1(end);
sig_tot_2(1)=sig_tot_1(end);

% iterations
for i=1:nstep2
   time2(i+1)=time2(i)+dt2; % update time
   de1_2=0; %  strain increment in branch 1
   e1_2(i+1)=e1_2(i)+de1_2; %  update the strain in branch 1
   sig1_2(i+1)=E1*e1_2(i+1); %  update the stress in branch 1   
   de2_2=(de1_2-dt2*e2_2(i)/(tau1*0.00005))/(1+dt2/(tau1*0.00005)); %  strain increment in branch 2
   e2_2(i+1)=e2_2(i)+de2_2; %  update the strain in branch 2
   sig2_2(i+1)=E2*e2_2(i+1);  % update the stress in branch 2 
   de3_2=(de2_2-dt2*e3_2(i)/(tau2*0.00005))/(1+dt2/(tau2*0.00005)); %  strain increment in branch 3
   e3_2(i+1)=e3_2(i)+de3_2; %  update the strain in branch 3
   sig3_2(i+1)=E3*e3_2(i+1);  % update the stress in branch 3 
   de4_2=(de3_2-dt2*e4_2(i)/(tau3*0.00005))/(1+dt2/(tau3*0.00005)); %  strain increment in branch 4
   e4_2(i+1)=e4_2(i)+de4_2; %  update the strain in branch 4
   sig4_2(i+1)=E4*e4_2(i+1);  % update the stress in branch 4  
   sig_tot_2(i+1)=sig1_2(i+1)+sig2_2(i+1)+sig3_2(i+1)+sig4_2(i+1);  % update the total stress
   e_tot_2(i+1)=e1_2(i+1); % update the total strain
end

subplot(5,2,3)
plot(time2, sig_tot_2, 'r' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Stress (MPa)')
title('Step 2 Stress')
subplot(5,2,4)
plot(time2, e_tot_2, 'k' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Strain')
title('Step 2 Strain')

%%%%%%%%%%%%%%%%%%%%%%%% Step 3 at 25 C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nstep3=100; %number of steps
dt3=tim_tot3/nstep3; %time increment in each step

%%%%%% define the matrix for Step 3
time3=zeros(nstep3+1,1); %time
e1_3=zeros(nstep3+1,1); %strain in branch 1
sig1_3=zeros(nstep3+1,1); %stress in branch 1
e2_3=zeros(nstep3+1,1); %strain in branch 2
sig2_3=zeros(nstep3+1,1); %stress in branch 2
e3_3=zeros(nstep3+1,1); %strain in branch 3
sig3_3=zeros(nstep3+1,1); %stress in branch 3
e4_3=zeros(nstep3+1,1); %strain in branch 4
sig4_3=zeros(nstep3+1,1); %stress in branch 4
e_tot_3=zeros(nstep3+1,1); %total strain, which equals to the strain of branch 1
sig_tot_3=zeros(nstep3+1,1); %total stress

% define the initial values of the matrix for Step 3
time3(1)=time2(end);
e1_3(1)=e1_2(end);
sig1_3(1)=sig1_2(end);
e2_3(1)=e2_2(end);
sig2_3(1)=sig2_2(end);
e3_3(1)=e3_2(end);
sig3_3(1)=sig3_2(end);
e4_3(1)=e4_2(end);
sig4_3(1)=sig4_2(end);
e_tot_3(1)=e_tot_2(end);
sig_tot_3(1)=sig_tot_2(end);

% iterations
for i=1:nstep3
   time3(i+1)=time3(i)+dt3; % update time
   de1_3=0; %  strain increment in branch 1
   e1_3(i+1)=e1_3(i)+de1_3; %  update the strain in branch 1
   sig1_3(i+1)=E1*e1_3(i+1); %  update the stress in branch 1 
   de2_3=(de1_3-dt3*e2_3(i)/tau1)/(1+dt3/tau1); %  strain increment in branch 2
   e2_3(i+1)=e2_3(i)+de2_3; %  update the strain in branch 2
   sig2_3(i+1)=E2*e2_3(i+1);  % update the stress in branch 2   
   de3_3=(de2_3-dt3*e3_3(i)/tau2)/(1+dt3/tau2); %  strain increment in branch 3
   e3_3(i+1)=e3_3(i)+de3_3; %  update the strain in branch 3
   sig3_3(i+1)=E3*e3_3(i+1);  % update the stress in branch 3   
   de4_3=(de3_3-dt3*e4_3(i)/tau3)/(1+dt3/tau3); %  strain increment in branch 4
   e4_3(i+1)=e4_3(i)+de4_3; %  update the strain in branch 4
   sig4_3(i+1)=E4*e4_3(i+1);  % update the stress in branch 4   
   sig_tot_3(i+1)=sig1_3(i+1)+sig2_3(i+1)+sig3_3(i+1)+sig4_3(i+1);  % update the total stress
   e_tot_3(i+1)=e1_3(i+1); % update the total strain
end

subplot(5,2,5)
plot(time3, sig_tot_3, 'r' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Stress (MPa)')
title('Step 3 Stress')
subplot(5,2,6)
plot(time3, e_tot_3, 'k' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Strain')
title('Step 3 Strain')

%%%%%%%%%%%%%%%%%%%%%%%%% Step 4 at 60 C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nstep4=100; %number of steps
dt3=tim_tot4/nstep4; %time increment in each step

%%%%%% define the matrix for Step 4
time4=zeros(nstep4+1,1); %time
e1_4=zeros(nstep4+1,1); %strain in branch 1
sig1_4=zeros(nstep4+1,1); %stress in branch 1
e2_4=zeros(nstep4+1,1); %strain in branch 2
sig2_4=zeros(nstep4+1,1); %stress in branch 2
e3_4=zeros(nstep4+1,1); %strain in branch 3
sig3_4=zeros(nstep4+1,1); %stress in branch 3
e4_4=zeros(nstep4+1,1); %strain in branch 4
sig4_4=zeros(nstep4+1,1); %stress in branch 4
e_tot_4=zeros(nstep4+1,1); %total strain, which equals to the strain of branch 1
sig_tot_4=zeros(nstep4+1,1); %total stress

% define the initial values of the matrix for Step 4 
time4(1)=time3(end);
e1_4(1)=e1_3(end);
sig1_4(1)=sig1_3(end);
e2_4(1)=e2_3(end);
sig2_4(1)=sig2_3(end);
e3_4(1)=e3_3(end);
sig3_4(1)=sig3_3(end);
e4_4(1)=e4_3(end);
sig4_4(1)=sig4_3(end);
e_tot_4(1)=e_tot_3(end);
sig_tot_4(1)=sig_tot_3(end);

tau0=((tau1+tau2+tau3)/3)*0.00005

% iterations
for i=1:nstep4
   time4(i+1)=time4(i)+dt3; % update time
   de1_4=-(E4*e4_4(i)+E3*e3_4(i)+E2*e2_4(i)+E1*e1_4(i)*(1+dt3/tau0))/(E4+E3+E2+E1*(1+dt3/tau0)); %  strain increment in branch 1
   e1_4(i+1)=e1_4(i)+de1_4; %  update the strain in branch 1
   sig1_4(i+1)=E1*e1_4(i+1); %  update the stress in branch 1   
   de2_4=(de1_4-dt3*e2_4(i)/(tau1*0.00005))/(1+dt3/(tau1*0.00005)); %  strain increment in branch 2
   e2_4(i+1)=e2_4(i)+de2_4; %  update the strain in branch 2
   sig2_4(i+1)=E2*e2_4(i+1);  % update the stress in branch 2  
   de3_4=(de2_4-dt3*e3_4(i)/(tau2*0.00005))/(1+dt3/(tau2*0.00005)); %  strain increment in branch 3
   e3_4(i+1)=e3_4(i)+de3_4; %  update the strain in branch 3
   sig3_4(i+1)=E3*e3_4(i+1);  % update the stress in branch 3   
   de4_4=(de3_4-dt3*e4_4(i)/(tau3*0.00005))/(1+dt3/(tau3*0.00005)); %  strain increment in branch 4
   e4_4(i+1)=e4_4(i)+de4_4; %  update the strain in branch 4
   sig4_4(i+1)=E4*e4_4(i+1);  % update the stress in branch 4  
   sig_tot_4(i+1)=sig1_4(i+1)+sig2_4(i+1)+sig3_4(i+1)+sig4_4(i+1);  % update the total stress
   e_tot_4(i+1)=e1_4(i+1); % update the total strain
end

subplot(5,2,7)
plot(time4, sig_tot_4, 'r' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Stress (MPa)')
title('Step 4 Stress')
subplot(5,2,8)
plot(time4, e_tot_4, 'k' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Strain')
title('Step 4 Strain')

%%%%%%%%%%%%%%%%%%%%% Gather all the variables %%%%%%%%%%%%%%%%%%%%%%%
total_time=[time1;time2;time3;time4];
total_stress=[sig_tot_1;sig_tot_2;sig_tot_3;sig_tot_4];
total_strain=[e_tot_1;e_tot_2;e_tot_3;e_tot_4];

subplot(5,2,9)
plot(total_time,total_stress','r' , 'linewidth', 2);
%ylim([-10 600])
xlabel('Time (s)')
ylabel('Stress (MPa)')
subplot(5,2,10)
plot(total_time,total_strain,'k' , 'linewidth', 2);
%ylim([0 0.4])
xlabel('Time (s)')
ylabel('Strain')

%%%%% Step 1 plot %%%%
figure
title('60 C')
subplot(1,2,1)
plot(time1, sig_tot_1, 'r' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Stress (MPa)')
title('Step 1 Stress')
subplot(1,2,2)
plot(time1, e_tot_1, 'k' , 'linewidth', 2)
xlabel('time (s)')
ylabel('strain')
title('Step 1 Strain')

%%%%% Step 2 plot %%%%
figure
title('60 C')
subplot(1,2,1)
plot(time2, sig_tot_2, 'r' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Stress (MPa)')
title('Step 2 Stress')
subplot(1,2,2)
plot(time2, e_tot_2, 'k' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Strain')
title('Step 2 Strain')

%%%%% Step 3 plot %%%%
figure
title('60 C')
subplot(1,2,1)
plot(time3, sig_tot_3, 'r' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Stress (MPa)')
title('Step 3 Stress')
subplot(1,2,2)
plot(time3, e_tot_3, 'k' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Strain')
title('Step 3 Strain')

%%%%% Step 4 plot %%%%
figure
title('60 C')
subplot(1,2,1)
plot(time4, sig_tot_4, 'r' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Stress (MPa)')
title('Step 4 Stress')
subplot(1,2,2)
plot(time4, e_tot_4, 'k' , 'linewidth', 2)
xlabel('Time (s)')
ylabel('Strain')
title('Step 4 Strain')

%%%%% Total plot for 60 C %%%%
figure
subplot(1,2,1)
plot(total_time,total_stress','r' , 'linewidth', 2);
%ylim([-1 6])
xlabel('Time (s)')
ylabel('Stress (MPa)')
title('Total Stress 2.2')
subplot(1,2,2)
plot(total_time,total_strain,'k' , 'linewidth', 2);
%ylim([0 0.22])
xlabel('Time (s)')
ylabel('Strain')
title('Total Strain 2.2')

%%%%% Total plot for 60 C joined %%%%
figure
plot(total_time,total_stress','r' , 'linewidth', 2);
xlabel('Time (s)')
ylabel('Stress (MPa) and Strain')
%title('Stress and Strain')
hold on 
plot(total_time,total_strain,'k' , 'linewidth', 2);
legend({'Stress','Strain'},'Location','northeast')
hold off


%%% Strain plot for 2.3 at 60 45 and 35 C %%%
figure
plot(total_time,total_strain,'k' , 'linewidth', 2);
xlabel('Time (s)')
ylabel('Strain')
ylim([0 .225])
%title('Strain at different Shape Recovery Temperatures')
hold on 

%%%%%%%%%%%%%%%%%%%%%%%%%% Step 4 at 45 C %%%%%%%%%%%%%%%%%%%%%%%%%%%%
nstep4=100; %number of steps
dt3=tim_tot4/nstep4; %time increment in each step

%%%%%% define the matrix for Step 4
time4=zeros(nstep4+1,1); %time
e1_4=zeros(nstep4+1,1); %strain in branch 1
sig1_4=zeros(nstep4+1,1); %stress in branch 1
e2_4=zeros(nstep4+1,1); %strain in branch 2
sig2_4=zeros(nstep4+1,1); %stress in branch 2
e3_4=zeros(nstep4+1,1); %strain in branch 3
sig3_4=zeros(nstep4+1,1); %stress in branch 3
e4_4=zeros(nstep4+1,1); %strain in branch 4
sig4_4=zeros(nstep4+1,1); %stress in branch 4
e_tot_4=zeros(nstep4+1,1); %total strain, which equals to the strain of branch 1
sig_tot_4=zeros(nstep4+1,1); %total stress

% define the initial values of the matrix for Step 4 
time4(1)=time3(end);
e1_4(1)=e1_3(end);
sig1_4(1)=sig1_3(end);
e2_4(1)=e2_3(end);
sig2_4(1)=sig2_3(end);
e3_4(1)=e3_3(end);
sig3_4(1)=sig3_3(end);
e4_4(1)=e4_3(end);
sig4_4(1)=sig4_3(end);
e_tot_4(1)=e_tot_3(end);
sig_tot_4(1)=sig_tot_3(end);

tau0=((tau1+tau2+tau3)/3)*0.0005;

% iterations
for i=1:nstep4
   time4(i+1)=time4(i)+dt3; % update time
   de1_4=-(E4*e4_4(i)+E3*e3_4(i)+E2*e2_4(i)+E1*e1_4(i)*(1+dt3/tau0))/(E4+E3+E2+E1*(1+dt3/tau0)); %  strain increment in branch 1
   e1_4(i+1)=e1_4(i)+de1_4; %  update the strain in branch 1
   sig1_4(i+1)=E1*e1_4(i+1); %  update the stress in branch 1   
   de2_4=(de1_4-dt3*e2_4(i)/(tau1*0.0005))/(1+dt3/(tau1*0.0005)); %  strain increment in branch 2
   e2_4(i+1)=e2_4(i)+de2_4; %  update the strain in branch 2
   sig2_4(i+1)=E2*e2_4(i+1);  % update the stress in branch 2   
   de3_4=(de2_4-dt3*e3_4(i)/(tau2*0.0005))/(1+dt3/(tau2*0.0005)); %  strain increment in branch 3
   e3_4(i+1)=e3_4(i)+de3_4; %  update the strain in branch 3
   sig3_4(i+1)=E3*e3_4(i+1);  % update the stress in branch 3   
   de4_4=(de3_4-dt3*e4_4(i)/(tau3*0.0005))/(1+dt3/(tau3*0.0005)); %  strain increment in branch 4
   e4_4(i+1)=e4_4(i)+de4_4; %  update the strain in branch 4
   sig4_4(i+1)=E4*e4_4(i+1);  % update the stress in branch 4  
   sig_tot_4(i+1)=sig1_4(i+1)+sig2_4(i+1)+sig3_4(i+1)+sig4_4(i+1);  % update the total stress
   e_tot_4(i+1)=e1_4(i+1); % update the total strain
end

total_strain=[e_tot_1;e_tot_2;e_tot_3;e_tot_4];
plot(total_time,total_strain,'r--' , 'linewidth', 2);

%%%%%%%%%%%%%%%%%%%%%%%%%% Step 4 at 35 C %%%%%%%%%%%%%%%%%%%%%%%%%%%%
nstep4=100; %number of steps
dt3=tim_tot4/nstep4; %time increment in each step

%%%%%% define the matrix for Step 4
time4=zeros(nstep4+1,1); %time
e1_4=zeros(nstep4+1,1); %strain in branch 1
sig1_4=zeros(nstep4+1,1); %stress in branch 1
e2_4=zeros(nstep4+1,1); %strain in branch 2
sig2_4=zeros(nstep4+1,1); %stress in branch 2
e3_4=zeros(nstep4+1,1); %strain in branch 3
sig3_4=zeros(nstep4+1,1); %stress in branch 3
e4_4=zeros(nstep4+1,1); %strain in branch 4
sig4_4=zeros(nstep4+1,1); %stress in branch 4
e_tot_4=zeros(nstep4+1,1); %total strain, which equals to the strain of branch 1
sig_tot_4=zeros(nstep4+1,1); %total stress

% define the initial values of the matrix for Step 4 
time4(1)=time3(end);
e1_4(1)=e1_3(end);
sig1_4(1)=sig1_3(end);
e2_4(1)=e2_3(end);
sig2_4(1)=sig2_3(end);
e3_4(1)=e3_3(end);
sig3_4(1)=sig3_3(end);
e4_4(1)=e4_3(end);
sig4_4(1)=sig4_3(end);
e_tot_4(1)=e_tot_3(end);
sig_tot_4(1)=sig_tot_3(end);

tau0=((tau1+tau2+tau3)/3)*0.005;

% iterations
for i=1:nstep4
   time4(i+1)=time4(i)+dt3; % update time
   de1_4=-(E4*e4_4(i)+E3*e3_4(i)+E2*e2_4(i)+E1*e1_4(i)*(1+dt3/tau0))/(E4+E3+E2+E1*(1+dt3/tau0)); %  strain increment in branch 1
   e1_4(i+1)=e1_4(i)+de1_4; %  update the strain in branch 1
   sig1_4(i+1)=E1*e1_4(i+1); %  update the stress in branch 1   
   de2_4=(de1_4-dt3*e2_4(i)/(tau1*0.005))/(1+dt3/(tau1*0.005)); %  strain increment in branch 2
   e2_4(i+1)=e2_4(i)+de2_4; %  update the strain in branch 2
   sig2_4(i+1)=E2*e2_4(i+1);  % update the stress in branch 2  
   de3_4=(de2_4-dt3*e3_4(i)/(tau2*0.005))/(1+dt3/(tau2*0.005)); %  strain increment in branch 3
   e3_4(i+1)=e3_4(i)+de3_4; %  update the strain in branch 3
   sig3_4(i+1)=E3*e3_4(i+1);  % update the stress in branch 3   
   de4_4=(de3_4-dt3*e4_4(i)/(tau3*0.005))/(1+dt3/(tau3*0.005)); %  strain increment in branch 4
   e4_4(i+1)=e4_4(i)+de4_4; %  update the strain in branch 4
   sig4_4(i+1)=E4*e4_4(i+1);  % update the stress in branch 4   
   sig_tot_4(i+1)=sig1_4(i+1)+sig2_4(i+1)+sig3_4(i+1)+sig4_4(i+1);  % update the total stress
   e_tot_4(i+1)=e1_4(i+1); % update the total strain
end

total_strain=[e_tot_1;e_tot_2;e_tot_3;e_tot_4];
plot(total_time,total_strain,'b:' , 'linewidth', 2);
legend({'60 C','45 C','35 C'},'Location','northeast')
hold off

