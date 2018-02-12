danestat = load('MODI2\danestat22.txt'); %dane statyczne

u =  danestat(:,1);
y = danestat(:,2);

daneucz=zeros(100,2); 
danewer=zeros(100,2);

%dzielenie danych statycznych na dane uczace i weryfikujace
j = 1;
for i=1:2:length(danestat)
    daneucz(j,:) = danestat(i,:); 
    j = j + 1;
end

j = 1;
for i=2:2:length(danestat)
    danewer(j,:) = danestat(i,:);
    j = j + 1;
end;

figure 
plot(u,y,'.');
title('Dane statyczne');
xlabel('u');
ylabel('y');
grid on;
% print('-dpng','modi_2_dane_stat','-r400');

figure 
plot(daneucz(:,1),daneucz(:,2),'.g');
title('Dane uczace');
xlabel('u');
ylabel('y');
grid on;
% print('-dpng','modi_2_dane_stat_ucz','-r400');

figure 
plot(danewer(:,1),danewer(:,2),'.r');
title('Dane weryfikujace');
xlabel('u');
ylabel('y');
grid on;
% print('-dpng','modi_2_dane_stat_wer','-r400');

