dane_ucz = load('MODI2\danedynucz22.txt');
dane_wer = load('MODI2\danedynwer22.txt');

u_ucz = dane_ucz(:,1);
y_ucz = dane_ucz(:,2);

u_wer = dane_wer(:,1);
y_wer = dane_wer(:,2);

typmodelu = 3;

kk = 2000;

if typmodelu == 1
    M_ucz = [u_ucz(1:kk-1), y_ucz(1:kk-1)];
    M_wer = [u_wer(1:kk-1), y_wer(1:kk-1)];
elseif typmodelu == 2
    M_ucz = [u_ucz(2:kk-1), u_ucz(1:kk-2), y_ucz(2:kk-1), y_ucz(1:kk-2)];
    M_wer = [u_wer(2:kk-1), u_wer(1:kk-2), y_wer(2:kk-1), y_wer(1:kk-2)];
elseif typmodelu == 3
    M_ucz = [u_ucz(3:kk-1), u_ucz(2:kk-2), u_ucz(1:kk-3), y_ucz(3:kk-1), y_ucz(2:kk-2), y_ucz(1:kk-3)];
    M_wer = [u_wer(3:kk-1), u_wer(2:kk-2), u_wer(1:kk-3), y_wer(3:kk-1), y_wer(2:kk-2), y_wer(1:kk-3)];
end

W = M_ucz\y_ucz(typmodelu+1:kk);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Metoda ARX(bez rekurencji)
Y_ARX_ucz(1:typmodelu)=y_ucz(1:typmodelu);
Y_ARX_wer(1:typmodelu)=y_wer(1:typmodelu);

Y_ARX_ucz(typmodelu+1:kk) = M_ucz*W;
Y_ARX_wer(typmodelu+1:kk) = M_wer*W;

E_ucz_ARX = (Y_ARX_ucz'-y_ucz)'*(Y_ARX_ucz'-y_ucz);
E_wer_ARX = (Y_ARX_wer'-y_wer)'*(Y_ARX_wer'-y_wer);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Metoda OE(z rekurencja)
Y_OE_ucz(1:typmodelu)=y_ucz(1:typmodelu);
Y_OE_wer(1:typmodelu)=y_wer(1:typmodelu);

for i=typmodelu+1:kk

Y_OE_ucz(i)=M_ucz(i-typmodelu,1:typmodelu)*W(1:typmodelu)+Y_OE_ucz(i-typmodelu:i-1)*W(end:-1:typmodelu+1);
Y_OE_wer(i)=M_wer(i-typmodelu,1:typmodelu)*W(1:typmodelu)+Y_OE_wer(i-typmodelu:i-1)*W(end:-1:typmodelu+1);

end

E_ucz_OE = (Y_OE_ucz'-y_ucz)'*(Y_OE_ucz'-y_ucz);
E_wer_OE = (Y_OE_wer'-y_wer)'*(Y_OE_wer'-y_wer);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure
subplot(2,1,1)
plot(Y_ARX_ucz,'b','LineWidth',2);
str = sprintf('Model uczacy ARX E_u_c_z =%f',E_ucz_ARX);
title(str);
grid on;
hold on;
xlabel('k');
ylabel('y');
plot(dane_ucz(:,2),'r');
legend('Y_u_c_z modelu ARX','Y dane uczace');

subplot(2,1,2)
plot(Y_OE_ucz,'--b');
str = sprintf('Model uczacy OE E_u_c_z =%f',E_ucz_OE);
title(str);
xlabel('k');
ylabel('y');
grid on;
hold on;
plot(dane_ucz(:,2),'r');
legend('Y_u_c_z modelu OE','Y dane uczace')
%print('-dpng','modi_2_dane_dyn_ucz_3','-r400');

figure
subplot(2,1,1)
plot(Y_ARX_wer,'b','LineWidth',2);
str = sprintf('Model weryfikujacy ARX E_w_e_r =%f',E_wer_ARX);
title(str);
grid on;
hold on;
xlabel('k');
ylabel('y');
plot(dane_wer(:,2),'r')
legend('Y_w_e_r modelu ARX','Y dane weryfikujace')

subplot(2,1,2)
plot(Y_OE_wer,'--b');
str = sprintf('Model weryfikujacy OE E_w_e_r =%f',E_wer_OE);
title(str);
xlabel('k');
ylabel('y');
grid on;
hold on;
plot(dane_wer(:,2),'r')
legend('Y_w_e_r modelu OE','Y dane weryfikujace')
%print('-dpng','modi_2_dane_dyn_wer_3','-r400');






