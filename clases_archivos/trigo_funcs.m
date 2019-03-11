% Archivo de órdenes

t=linspace(0,2*pi,180)';

figure(1);clf
hold on
plot(t,cos(t),'r- ','linewidth',3)
plot(t,sin(t),'b--','linewidth',3)
hold off
axis tight
xlabel('t','fontsize',20)
h=legend('cos(t)','sin(t)','location','north')
legend boxoff
set(gca,'fontsize',20)
set(h,'fontsize',20,'fontweight','b')



figure(2);clf
plot(cos(t),2*sin(t),'k-','linewidth',3)
xlabel('x(t)','fontsize',20)
ylabel('y(t)','fontsize',20)
set(gca,'fontsize',20)
axis equal
