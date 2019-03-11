% Introduccion Octave - 2018 - FCAI-UNCuyo
% 
% Trabajo Practico 4 - Ejercicio 2
%
% Respuesta transitoria o dinamica de la red de 5 reactores 
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
   
b =[1;0;4;0;0];

f =@(c) (b-A*c);

N = 10000;
tt=linspace(0,100,N);
c0=zeros(5,1);

Ct =lsode(f,c0,tt);

% Graficas de respuesta transitoria de la red de reactores 
% ver Fig. 28.3 Chapra y Canale, 5ta Ed, 2007.
% Observe que, con el tiempo, todos los reactores tienden a las 
% concentraciones en estado estacionario previamente calculadas 
% en el TP2.
figure(1);clf
plot(tt,Ct,'linewidth',4)
xlabel('t (min)','fontsize',24)
ylabel('c (mg/m3)','fontsize',24)
h=legend('c_1','c_2','c_3','c_4','c_5');
set(h,'fontsize',24);
set(gca,'fontsize',24)


% ===================EJERCICIO ===========================
% El tiempo hasta el estado estacionario se caracteriza
% por el tiempo que tarda cada reactor en alcanzar el 90%
% de la concentracion en el estado estacionario: t90.
%   1) Estime t90 para cada reactor.
%   2) Se produce una variacion de la concentracion en t=10min en la
%      entrada del reactor 1 el cual se aproxima por:
%           b(1) = 1+exp(-(t-10)^2).
%       2.a) grafique el la entrada b(1) en funcion del tiempo t.
%       2.b) determine las respuestas transitorias y grafique estas 
%   3) La carga en el reactor 3 decrece en un 25% de forma abrupta en t=10min.
%      Luego de media hora se restablece subitamente el valor de entrada.
%       3.1) Cree una funcion carga3_escalon.m que modele el valor 
%            en la entrada b(t) en funcion del tiempo. Grafique b3(t).
%       3.2) determine las respuestas transitorias y grafique estas 

c90 = 0.90 * (A\b);

% === 1) 

% Estimamos el tiempo t90 empleando los valores calculados de C(t)
% Esto lo determinamos como el minimo entre C90 y C(t) para cada columna Ci
DC=Ct-c90';

[dmin,imin]=min(DC.*DC);

%mostramos los valores de t90 y comparamos C90aprox con C90 exacto
R90=[tt(imin(1)) Ct(imin(1),1) c90(1);
     tt(imin(2)) Ct(imin(2),2) c90(2);
     tt(imin(3)) Ct(imin(3),3) c90(3);
     tt(imin(4)) Ct(imin(4),4) c90(4);
     tt(imin(5)) Ct(imin(5),5) c90(5)];
disp(R90)


% === 2)

qc1=@(t) 1+0.5*sin(t/2).*exp(-t/10); % =%= COMPLETAR
b2 =@(t) [qc1(t);0;4;0;0];

f2 =@(c,t) (b2(t)-A*c);

Ct2= lsode(f2,c0,tt);


figure(2);clf
plot(tt,qc1(tt),'linewidth',4)
xlabel('t (min)','fontsize',24)
ylabel('b_1 (mg/(s m3))','fontsize',24)
h=legend('b_1(t)');
set(h,'fontsize',24);
set(gca,'fontsize',24)

figure(3);clf
plot(tt,Ct2,'linewidth',4)
xlabel('t (min)','fontsize',24)
ylabel('c (mg/m3)','fontsize',24)
h=legend('c_1','c_2','c_3','c_4','c_5');
set(h,'fontsize',24);
set(gca,'fontsize',24)



% === 3)

bEsc3 = zeros(N,1);

% =%= COMPLETAR - REVISAR FUNCION CARGA3_ESCALON
for i=1:N
  QCentr   = carga3_escalon(tt(i));
  bEsc3(i) = QCentr(3);
end

figure(4);clf
plot(tt,bEsc3,'linewidth',4)
xlabel('t (min)','fontsize',24)
ylabel('b_3 (mg/(s m3))','fontsize',24)
h=legend('b_3(t)');
set(h,'fontsize',24);
set(gca,'fontsize',24)

f3=@(c,t) (carga3_escalon(t) - A*c);

Ct3= lsode(f3,c0,tt);

figure(5);clf
plot(tt,Ct3,'linewidth',4)
xlabel('t (min)','fontsize',24)
ylabel('c (mg/m3)','fontsize',24)
h=legend('c_1','c_2','c_3','c_4','c_5');
set(h,'fontsize',24);
set(gca,'fontsize',24)