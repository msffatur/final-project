function [A,B,C,D] = SystemModel(P)

%% Model Sistem

% Besaran fisis beserta konstanta yang digunakan
k    = 1000;    %kN/m
beta = 0.02;
g    = 9.8;     %m/s2
myu  = 0.002;
%m1  = m(1);        %ton
%m2  = m(2);        %ton
m1 = 34 + (P*0.06); %ton
m2 = 34 + (P*0.06); %ton

% Pemodelan sistem
A = [0 1 0 0;
    -k/m1 (-myu-(g*beta)) k/m1 0;
    0 0 0 1;
    k/m2 0 -k/m2 (-myu-(g*beta))];
B = [0; 1/m1; 0; 0];
C = [0 1 0 0];
D = [0];

SS = ss(A,B,C,D);

end