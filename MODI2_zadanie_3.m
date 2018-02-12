wektor_u = linspace(-1,1,50);
global u;
for i=1:length(wektor_u)
    u = wektor_u(i);
    x0=[0];
    y(i)=fsolve(@char_stat,x0,0);
    e=char_stat(y(i));
end

figure 
plot(wektor_u,y);
grid on;
title('Chrakterystyka statyczna y(u)');
xlabel('u');
ylabel('y');
print('-dpng','modi_2_dodatkowe','-r400');