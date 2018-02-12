dane_ucz = load('MODI2\danedynucz22.txt');
dane_wer = load('MODI2\danedynwer22.txt');

u_ucz = dane_ucz(:,1);
y_ucz = dane_ucz(:,2);

u_wer = dane_wer(:,1);
y_wer = dane_wer(:,2);

typmodelu = 4;

kk = 2000;

if typmodelu == 1
    M_ucz = [u_ucz(2:kk-1), u_ucz(1:kk-2), y_ucz(2:kk-1), y_ucz(1:kk-2)];
    M_wer = [u_wer(2:kk-1), u_wer(1:kk-2), y_wer(2:kk-1), y_wer(1:kk-2)];
elseif typmodelu == 2
    M_ucz = [u_ucz(2:kk-1), u_ucz(2:kk-1).^2, u_ucz(1:kk-2), u_ucz(1:kk-2).^2, y_ucz(2:kk-1), y_ucz(2:kk-1).^2, y_ucz(1:kk-2), y_ucz(1:kk-2).^2];
    M_wer = [u_wer(2:kk-1), u_wer(2:kk-1).^2, u_wer(1:kk-2), u_wer(1:kk-2).^2, y_wer(2:kk-1), y_wer(2:kk-1).^2, y_wer(1:kk-2), y_wer(1:kk-2).^2];
elseif typmodelu == 3
    M_ucz = [u_ucz(2:kk-1), u_ucz(2:kk-1).^2, u_ucz(2:kk-1).^3, u_ucz(1:kk-2), u_ucz(1:kk-2).^2, u_ucz(1:kk-2).^3, y_ucz(2:kk-1), y_ucz(2:kk-1).^2, y_ucz(2:kk-1).^3, y_ucz(1:kk-2), y_ucz(1:kk-2).^2, y_ucz(1:kk-2).^3];
    M_wer = [u_wer(2:kk-1), u_wer(2:kk-1).^2, u_wer(2:kk-1).^3, u_wer(1:kk-2), u_wer(1:kk-2).^2, u_wer(1:kk-2).^3, y_wer(2:kk-1), y_wer(2:kk-1).^2, y_wer(2:kk-1).^3, y_wer(1:kk-2), y_wer(1:kk-2).^2, y_wer(1:kk-2).^3];
elseif typmodelu == 4
    M_ucz = [u_ucz(2:kk-1), u_ucz(2:kk-1).^2, u_ucz(2:kk-1).^3, u_ucz(2:kk-1).^4, u_ucz(1:kk-2), u_ucz(1:kk-2).^2, u_ucz(1:kk-2).^3, u_ucz(1:kk-2).^4, y_ucz(2:kk-1), y_ucz(2:kk-1).^2, y_ucz(2:kk-1).^3, y_ucz(2:kk-1).^4, y_ucz(1:kk-2), y_ucz(1:kk-2).^2, y_ucz(1:kk-2).^3, y_ucz(1:kk-2).^4];
    M_wer = [u_wer(2:kk-1), u_wer(2:kk-1).^2, u_wer(2:kk-1).^3, u_wer(2:kk-1).^4, u_wer(1:kk-2), u_wer(1:kk-2).^2, u_wer(1:kk-2).^3, u_wer(1:kk-2).^4, y_wer(2:kk-1), y_wer(2:kk-1).^2, y_wer(2:kk-1).^3, y_wer(2:kk-1).^4, y_wer(1:kk-2), y_wer(1:kk-2).^2, y_wer(1:kk-2).^3, y_wer(1:kk-2).^4];

end

W = M_ucz\y_ucz(3:kk);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Metoda ARX(bez rekurencji)
Y_ARX_ucz(1:2)=y_ucz(1:2);
Y_ARX_wer(1:2)=y_wer(1:2);

Y_ARX_ucz(3:kk) = M_ucz*W;
Y_ARX_wer(3:kk) = M_wer*W;

E_ucz_ARX = (Y_ARX_ucz'-y_ucz)'*(Y_ARX_ucz'-y_ucz);
E_wer_ARX = (Y_ARX_wer'-y_wer)'*(Y_ARX_wer'-y_wer);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Metoda OE(z rekurencja)
Y_OE_ucz(1:2)=y_ucz(1:2);
Y_OE_wer(1:2)=y_wer(1:2);

for i=3:kk
    if (typmodelu==1)
        Y_OE_ucz(i)=M_ucz(i-2,1:2)*W(1:2)+Y_OE_ucz(i-1)*W(3)+Y_OE_ucz(i-2)*W(4);
        Y_OE_wer(i)=M_wer(i-2,1:2)*W(1:2)+Y_OE_wer(i-1)*W(3)+Y_OE_wer(i-2)*W(4);
    elseif (typmodelu==2)
        Y_OE_ucz(i)=M_ucz(i-2,1:4)*W(1:4)+Y_OE_ucz(i-1)*W(5)+((Y_OE_ucz(i-1))^2)*W(6)+Y_OE_ucz(i-2)*W(7)+((Y_OE_ucz(i-2))^2)*W(8);
        Y_OE_wer(i)=M_wer(i-2,1:4)*W(1:4)+Y_OE_wer(i-1)*W(5)+((Y_OE_wer(i-1))^2)*W(6)+Y_OE_wer(i-2)*W(7)+((Y_OE_wer(i-2))^2)*W(8);
    elseif (typmodelu==3)
        Y_OE_ucz(i)=M_ucz(i-2,1:6)*W(1:6)+Y_OE_ucz(i-1)*W(7)+((Y_OE_ucz(i-1))^2)*W(8)+((Y_OE_ucz(i-1))^3)*W(9)+Y_OE_ucz(i-2)*W(10)+((Y_OE_ucz(i-2))^2)*W(11)+((Y_OE_ucz(i-2))^3)*W(12);
        Y_OE_wer(i)=M_wer(i-2,1:6)*W(1:6)+Y_OE_wer(i-1)*W(7)+((Y_OE_wer(i-1))^2)*W(8)+((Y_OE_wer(i-1))^3)*W(9)+Y_OE_wer(i-2)*W(10)+((Y_OE_wer(i-2))^2)*W(11)+((Y_OE_wer(i-2))^3)*W(12);
    elseif (typmodelu==4)
        Y_OE_ucz(i)=M_ucz(i-2,1:8)*W(1:8)+Y_OE_ucz(i-1)*W(9)+((Y_OE_ucz(i-1))^2)*W(10)+((Y_OE_ucz(i-1))^3)*W(11)+((Y_OE_ucz(i-1))^4)*W(12)+Y_OE_ucz(i-2)*W(13)+((Y_OE_ucz(i-2))^2)*W(14)+((Y_OE_ucz(i-2))^3)*W(15)+((Y_OE_ucz(i-2))^4)*W(16);
        Y_OE_wer(i)=M_wer(i-2,1:8)*W(1:8)+Y_OE_wer(i-1)*W(9)+((Y_OE_wer(i-1))^2)*W(10)+((Y_OE_wer(i-1))^3)*W(11)+((Y_OE_wer(i-1))^4)*W(12)+Y_OE_wer(i-2)*W(13)+((Y_OE_wer(i-2))^2)*W(14)+((Y_OE_wer(i-2))^3)*W(15)+((Y_OE_wer(i-2))^4)*W(16);
    end
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
plot(Y_OE_ucz,'--b','LineWidth',2);
str = sprintf('Model uczacy OE E_u_c_z =%f',E_ucz_OE);
title(str);
xlabel('k');
ylabel('y');
grid on;
hold on;
plot(dane_ucz(:,2),'r');
legend('Y_u_c_z modelu OE','Y dane uczace')
print('-dpng','modi_2_e_ucz_4','-r400');

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
plot(Y_OE_wer,'--b','LineWidth',2);
str = sprintf('Model weryfikujacy OE E_w_e_r =%f',E_wer_OE);
title(str);
xlabel('k');
ylabel('y');
grid on;
hold on;
plot(dane_wer(:,2),'r')
legend('Y_w_e_r modelu OE','Y dane weryfikujace')
print('-dpng','modi_2_e_wer_4','-r400');






