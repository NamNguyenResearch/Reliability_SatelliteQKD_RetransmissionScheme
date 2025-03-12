%Calculate QBER of Quantum Key Distribution System Using Dual Threshold
%Direct-Detection Receiver over Free-Space Optics with QPSK scheme and
%Heterodyne Detection Reciver with atmospheric turbulence
clear;
clc;

%Simulator Parameters
global Rb;       %Bit rate  
global P_LO_dBm; %Power of Local Oscillator(dBm)
global alpha1;   %Attenuatation coefficient(dB/km)
global lamda_wavelength;
global Omega_z_G;

Rb=10*10^9;
P_LO_dBm=0;
alpha1=0.43;
lamda_wavelength=1550*10^-9;
Omega_z_G=50;

C2n_Weak=5*10^-15; %Refractive index structure coefficient
ScaleCo_Weak=0.2;

P_T_dBm=10:1:50;      
 
%Calculate QBER via Gamma-Gamma Channels with weak and strong turbulence
QBER_Gamma_Weak=zeros(1,length(P_T_dBm));
P_sift_Gamma_Weak=zeros(1,length(P_T_dBm));
QBER_SIM=zeros(1,length(P_T_dBm));
P_sift_SIM=zeros(1,length(P_T_dBm));
QBER_Direct=zeros(1,length(P_T_dBm));
P_sift_Direct=zeros(1,length(P_T_dBm)); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulation Parameters
global P_dBm;     %Peak transmitted power
global Omega_z_P; 
global Omega_z_G;
global ModDepth;  %Modulation depth
global B          %Bit rate
global G_A_dB;

P_dBm=37; 
Omega_z_P=1475;
Omega_z_G=50;
ModDepth=0.4;
B=10^9;
G_A_dB=50;

ScaleCo=0:0.1:4;

%Calculate QBER via Gamma-Gamma Channels with weak and strong turbulence
QBER=zeros(1,length(ScaleCo));
P_sift=zeros(1,length(ScaleCo));
QBER_Direct=zeros(1,length(ScaleCo));
P_sift_Direct=zeros(1,length(ScaleCo));

for i=1:length(ScaleCo)
    [QBER(i),P_sift(i)]=calculateQBER_HAP(ScaleCo(i));
    [QBER_Direct(i),P_sift_Direct(i)]=calculateQBER_Direct(ScaleCo(i));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=1:length(P_T_dBm)
    [QBER_Gamma_Weak(i),P_sift_Gamma_Weak(i)]=calculateQBER_QPSK_Gamma(ScaleCo_Weak,P_T_dBm(i),C2n_Weak);
    [QBER_SIM(i),P_sift_SIM(i)]=calculateQBER_BPSK_Gamma(ScaleCo_Weak,P_T_dBm(i),C2n_Weak);
    [QBER_Direct(i),P_sift_Direct(i)]=calculateQBER_QPSK_DD(ScaleCo_Weak,P_T_dBm(i),C2n_Weak);
end

%Plot funciton of Gamma-Gamma channels with weak and strong turbulence
figure(1)
semilogy(P_T_dBm,QBER_Gamma_Weak,'-*','color',[1, 0, 0],'LineWidth',1.25);
grid on
hold on
semilogy(P_T_dBm,P_sift_Gamma_Weak,'-s','color',[1, 0, 0],'LineWidth',1.25);
semilogy(P_T_dBm,QBER_SIM,'-+','color',[0, 0, 1],'LineWidth',1.25);
semilogy(P_T_dBm,P_sift_SIM,'-o','color',[0, 0, 1],'LineWidth',1.25);
semilogy(P_T_dBm,QBER_Direct,'-x','color',[0, 0.5, 0],'LineWidth',1.25);
semilogy(P_T_dBm,P_sift_Direct,'-d','color',[0, 0.5, 0],'LineWidth',1.25);
xlabel('Peak transmitted power, P_{T} (dBm)');
ylabel('Probability');
hold off
legend('QBER-QPSK-DT/HD','P_{sift}-QPSK-DT/HD',...
       'QBER-SIM/BPSK-DT','P_{sift}-SIM/BPSK-DT',...
       'QBER-QPSK-DT/DD','P_{sift}-QPSK-DT/DD',...
       'Location','southwest');
axis([10,50,1.e-4,1.e-0]);