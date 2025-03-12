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

C2n_Weak=5*10^-15;   %Refractive index structure coefficient
C2n_Strong=7*10^-12;

P_T_dBm=25;          %Peak transmitted power (dBm)
ScaleCo_Weak=0.7;
ScaleCo_Strong=1.4;
ScaleCo_Weak_Eve=2.1;
ScaleCo_Strong_Eve=2.4;
L_BE=0:10:100;       %Threshold scale coefficient
%Weak 0.7->2.4, Strong 1.4->2.8
 
%Calculate QBER via Gamma-Gamma Channels with weak and strong turbulence
QBER_Gamma_Weak=zeros(1,length(L_BE));
P_sift_Gamma_Weak=zeros(1,length(L_BE));
QBER_Gamma_Strong=zeros(1,length(L_BE));
P_sift_Gamma_Strong=zeros(1,length(L_BE));

QBER_Gamma_Weak_Eve=zeros(1,length(L_BE));
P_sift_Gamma_Weak_Eve=zeros(1,length(L_BE));
QBER_Gamma_Strong_Eve=zeros(1,length(L_BE));
P_sift_Gamma_Strong_Eve=zeros(1,length(L_BE));


for i=1:length(L_BE)
    [QBER_Gamma_Weak(i),P_sift_Gamma_Weak(i)]=calculateQBER_QPSK_Gamma(L_BE(i),ScaleCo_Weak,P_T_dBm,C2n_Weak);
    [QBER_Gamma_Strong(i),P_sift_Gamma_Strong(i)]=calculateQBER_QPSK_Gamma(L_BE(i),ScaleCo_Strong,P_T_dBm,C2n_Strong);
    [QBER_Gamma_Weak_Eve(i),P_sift_Gamma_Weak_Eve(i)]=calculateQBER_QPSK_Gamma(L_BE(i),ScaleCo_Weak_Eve,P_T_dBm,C2n_Weak);
    [QBER_Gamma_Strong_Eve(i),P_sift_Gamma_Strong_Eve(i)]=calculateQBER_QPSK_Gamma(L_BE(i),ScaleCo_Strong_Eve,P_T_dBm,C2n_Strong);
end

%Plot funciton of Gamma-Gamma channels with weak and strong turbulence
figure(1)
subplot(1,2,1)
semilogy(L_BE,QBER_Gamma_Weak,'r-o',L_BE,P_sift_Gamma_Weak,'b-s','LineWidth',1.25);
hold on
semilogy(L_BE,QBER_Gamma_Weak_Eve,'r-o',L_BE,P_sift_Gamma_Weak_Eve,'b-s','LineWidth',1.25);
grid on
xlabel('Eve-Bob distance, D_{E-B}');
ylabel('Probability');
title('(a)','FontWeight','Normal');
legend('QBER','P_{sift}');
axis([0,100,1.e-4,1.e-0]);

subplot(1,2,2)
semilogy(L_BE,QBER_Gamma_Strong,'r-o',L_BE,P_sift_Gamma_Strong,'b-s','LineWidth',1.25);
hold on
semilogy(L_BE,QBER_Gamma_Strong_Eve,'r-o',L_BE,P_sift_Gamma_Strong_Eve,'b-s','LineWidth',1.25);
grid on
xlabel('Eve-Bob distance, D_{E-B}');
ylabel('Probability');
title('(b)','FontWeight','Normal');
legend('QBER','P_{sift}');
axis([0,100,1.e-4,1.e-0]);