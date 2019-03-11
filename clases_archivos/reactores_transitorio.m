% Respuesta transitoria o dinámica de la red de 5 reactores 
% de la figura 12.3 (Chapra y Canale, 5ta Ed, 2007).
close all
clear all

% Q01 c01 =  50 mg/min
% Q03 c03 = 160 mg/min
% Volumen de los 5 tanques:
% V1= 50 m3, V2 = 20 m3, V3 = 40 m3, V4 = 80 m3 y V5 = 100 m3

% Sistema de cinco reactores acoplados como en la figura 12.3.
A=[  0.12  0.000 -0.020 0.0000  0.000;
    -0.15  0.150  0.000 0.0000  0.000;
     0.00 -0.025  0.225 0.0000  0.000; 
     0.00  0.000 -0.100 0.1375 -0.025; 
    -0.03 -0.010  0.000 0.0000  0.040];
   
b=[1;0;4;0;0];

f=@(c) (b-A*c);

t =linspace(0,200,1000);
c0=zeros(5,1);

Ct =lsode(f,c0,t);

% Gráficas de respuesta transitoria de la red de reactores 
% ver Fig. 28.3 Chapra y Canale, 5ta Ed, 2007.
% Observe que, con el tiempo, todos los reactores tienden a las 
% concentraciones en estado estacionario previamente calculadas 
% en el TP2.
figure(1);clf
plot(t,Ct,'linewidth',4)
xlabel('t (min)','fontsize',20)
ylabel('c (mg/m3)','fontsize',20)
h=legend('c_1','c_2','c_3','c_4','c_5');
set(h,'fontsize',20);
set(gca,'fontsize',20)


% ===================EJERCICIO ===========================
% El tiempo hasta el estado estacionario se caracteriza
% por el tiempo que tarda cada reactor en alcanzar el 90%
% de la concentracion en el estado estacionario: t90.
%   1) Estime t90 para cada reactor.
%   2) Calcular de forma exacta el tiempo t90

c90 = 0.90 * (A\b);

% === 1) 
