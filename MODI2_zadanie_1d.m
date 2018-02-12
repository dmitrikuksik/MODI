danestat = load('MODI2\danestat22.txt'); %dane statyczne

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

%wybieramy rzad naszego modelu
typmodelu = 6;
u = linspace(-1,1,100)';
 
if typmodelu == 1
    M_ucz = [daneucz(:,1), ones(length(daneucz(:,1)),1)];
    M_wer = [danewer(:,1), ones(length(danewer(:,1)),1)];
    M_stat = [u, ones(100,1)];
elseif typmodelu == 2
    M_ucz = [daneucz(:,1).^2, daneucz(:,1), ones(length(daneucz(:,1)),1)];
    M_wer = [danewer(:,1).^2, danewer(:,1), ones(length(danewer(:,1)),1)];
    M_stat = [u.^2, u, ones(100,1)];
elseif typmodelu == 3
    M_ucz = [daneucz(:,1).^3, daneucz(:,1).^2, daneucz(:,1), ones(length(daneucz(:,1)),1)];
    M_wer = [danewer(:,1).^3, danewer(:,1).^2, danewer(:,1), ones(length(danewer(:,1)),1)];
    M_stat = [u.^3, u.^2, u, ones(100,1)];
elseif typmodelu == 4      
    M_ucz = [daneucz(:,1).^4, daneucz(:,1).^3, daneucz(:,1).^2, daneucz(:,1), ones(length(daneucz(:,1)),1)];
    M_wer = [danewer(:,1).^4, danewer(:,1).^3, danewer(:,1).^2, danewer(:,1), ones(length(danewer(:,1)),1)];
    M_stat = [u.^4, u.^3, u.^2, u, ones(100,1)];
elseif typmodelu == 5
    M_ucz = [daneucz(:,1).^5, daneucz(:,1).^4, daneucz(:,1).^3, daneucz(:,1).^2, daneucz(:,1), ones(length(daneucz(:,1)),1)];
    M_wer = [danewer(:,1).^5, danewer(:,1).^4, danewer(:,1).^3, danewer(:,1).^2, danewer(:,1), ones(length(danewer(:,1)),1)];
    M_stat = [u.^5, u.^4, u.^3, u.^2, u, ones(100,1)];
elseif typmodelu == 6 
    M_ucz = [daneucz(:,1).^6, daneucz(:,1).^5, daneucz(:,1).^4, daneucz(:,1).^3, daneucz(:,1).^2, daneucz(:,1), ones(length(daneucz(:,1)),1)];
    M_wer = [danewer(:,1).^6, danewer(:,1).^5, danewer(:,1).^4, danewer(:,1).^3, danewer(:,1).^2, danewer(:,1), ones(length(danewer(:,1)),1)];
    M_stat = [u.^6, u.^5, u.^4, u.^3, u.^2, u, ones(100,1)];
end

%Metoda Najmniejszych kwadratow
W = M_ucz\daneucz(:,2);

%Macierz wyjcsia modelu
Y_ucz = M_ucz*W;
Y_wer = M_wer*W;

Y_stat = M_stat*W;

%Blad modelu dla zbioru uczacego oraz weryfikujacego
E_ucz = (Y_ucz-daneucz(:,2))'*(Y_ucz-daneucz(:,2));
E_wer = (Y_wer-danewer(:,2))'*(Y_wer-danewer(:,2));


%Wykresy
figure
plot(daneucz(:,1),daneucz(:,2),'.b',daneucz(:,1),Y_ucz,'or');
grid on;
xlabel('u');
ylabel('y');
legend('Model uczacy','Metoda NMK');
str = sprintf('E uczenia=%f',E_ucz);
title(str);
print('-dpng','modi_2_dane_ucz_6','-r400');

figure
plot(danewer(:,1),danewer(:,2),'.b',danewer(:,1),Y_wer,'or');
grid on;
xlabel('u');
ylabel('y');
legend('Model weryfikujacy','Metoda NMK');
str = sprintf('E wer=%f',E_wer);
title(str);
%print('-dpng','modi_2_dane_wer_6','-r400');


figure
plot(u,Y_stat,'b');
grid on;
title('Charakterystyka statyczna y(u)');
xlabel('u');
ylabel('y');
%print('-dpng','modi_2_dane_stat_char_stat_6','-r400');



