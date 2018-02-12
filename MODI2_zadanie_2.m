dane_ucz = load('MODI2\danedynucz22.txt');
dane_wer = load('MODI2\danedynwer22.txt');


figure
plot(dane_ucz(:,1),'r');
grid on 
hold on
plot(dane_ucz(:,2),'b')
title('Zbior uczacy');
xlabel('k');
legend('u(k)','y(k)');
%print('-dpng','modi_2_dane_dyn_ucz','-r400');

figure
plot(dane_wer(:,1),'r');
grid on 
hold on
plot(dane_wer(:,2),'b')
title('Zbior weryfikujacy');
xlabel('k');
legend('u(k)','y(k)');
%print('-dpng','modi_2_dane_dyn_wer','-r400');

