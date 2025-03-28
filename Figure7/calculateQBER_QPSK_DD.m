function [QBER_DD,P_sift_DD]=calculateQBER_QPSK_DD(ScaleCo,P_T_dBm,C2n) 
    P_sift_DD=jointProbabilite_QPSK_DD(0,0,ScaleCo,P_T_dBm,C2n)+jointProbabilite_QPSK_DD(0,1,ScaleCo,P_T_dBm,C2n)...
             +jointProbabilite_QPSK_DD(1,0,ScaleCo,P_T_dBm,C2n)+jointProbabilite_QPSK_DD(1,1,ScaleCo,P_T_dBm,C2n);
    P_error_DD=jointProbabilite_QPSK_DD(0,1,ScaleCo,P_T_dBm,C2n)+jointProbabilite_QPSK_DD(1,0,ScaleCo,P_T_dBm,C2n);
    QBER_DD=P_error_DD/P_sift_DD;
end