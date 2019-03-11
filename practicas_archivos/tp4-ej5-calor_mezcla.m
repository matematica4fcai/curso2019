% Introduccion Octave - 2018 - FCAI-UNCuyo
% 
% Trabajo Practico 4 - Ejercicio 5
% El fluido A entra al mezclador a T_{A1}=400ºC y 
% el B entra a una temperatura T_{B1} entre 500ºC y 800ºC. 
% Al mezclador entra el doble de fluido A que B. 
close all
clear all

%================================================
% 1) Cree funciones anónimas de c_P para el fluido A y B. 
%    Grafique el comportamiento de los calores específicos 
%    entre 400ºC y 800ºC.
cp1=@(T) 3.381 + 1.804*1e-2*T - 4.300*1e-6*T.^2;
cp2=@(T) 8.592 + 1.290*1e-1*T - 4.078*1e-5*T.^2;

TT = 273+linspace(400,800,1000)';
TA1= 273+400;
TB1= 273+linspace(500,800,500)';


figure(1);clf
hold on
plot(TT-273,cp1(TT),'r-','linewidth',4)
plot(TT-273,cp2(TT),'b-','linewidth',4)
hold off
xlabel('T [C]','fontsize',24)
ylabel('c_P [cal/mol K]','fontsize',24)
h=legend('c_{P1}(T)','c_{P2}(T)');
set(h,'fontsize',24)
set(gca,'fontsize',24)

%================================================
% 2)¿A qué temperatura T_2 salen los dos fluidos del mezclador
%   en el rango analizado? Grafique la respuesta.

% Diferencia de entalpías de cada fluido
DHA=@(T1,T) 0*T; %== COMPLETAR
DHB=@(T1,T) 0*T; %== COMPLETAR

Teq = zeros(500,1);

for i=1:500
  DH=@(T) 0; %== COMPLETAR
  Teq(i) = 450+273; %fsolve(DH,T0); %== COMPLETAR
end

figure(2);clf
plot(TB1-273,Teq-273,'r-','linewidth',4)
xlabel('T_B[C]','fontsize',24)
ylabel('T_{eq}[C]','fontsize',24)
set(gca,'fontsize',24)

%================================================
% 3) Muestre gráfiquemente el incremento de entalpía \Delta H
%    en kcal/mol ganado o perdido en función de T_{B1} por el
%    fluido A y B, respectivamente.

% Recordamos que: 2DHA = DHB
figure(3);clf
hold on
plot(TB1-273, 2e-3*DHA(TA1,Teq),'k-','linewidth',10)
plot(TB1-273,-1e-3*DHB(TB1,Teq),'r.-','linewidth',3)
hold off
xlabel('T_B [C]','fontsize',24)
ylabel('\Delta H[kcal/mol]','fontsize',24)
h=legend('2\Delta H_A','-\Delta H_B');
set(h,'fontsize',24)
set(gca,'fontsize',24)