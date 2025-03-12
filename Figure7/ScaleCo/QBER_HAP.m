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
