dane_ucz = load('MODI2\danedynucz22.txt');
dane_wer = load('MODI2\danedynwer22.txt');

u_ucz = dane_ucz(:,1);
y_ucz = dane_ucz(:,2);

u_wer = dane_wer(:,1);
y_wer = dane_wer(:,2);

typmodelu = 4;

kk = 2000;

if typmodelu == 1
    M_ucz = [u_ucz(1:kk-1), y_ucz(1:kk-1)];
    M_wer = [u_wer(1:kk-1), y_wer(1:kk-1)];
elseif typmodelu == 2
    M_ucz = [u_ucz(1:kk-1), (u_ucz(1:kk-1)).^2, y_ucz(1:kk-1), (y_ucz(1:kk-1)).^2];
    M_wer = [u_wer(1:kk-1), (u_wer(1:kk-1)).^2, y_wer(1:kk-1), (y_wer(1:kk-1)).^2];
elseif typmodelu == 3
    M_ucz = [u_ucz(1:kk-1), (u_ucz(1:kk-1)).^2, (u_ucz(1:kk-1)).^3, y_ucz(1:kk-1), (y_ucz(1:kk-1)).^2, (y_ucz(1:kk-1)).^3];
    M_wer = [u_wer(1:kk-1), (u_wer(1:kk-1)).^2, (u_wer(1:kk-1)).^3, y_wer(1:kk-1), (y_wer(1:kk-1)).^2, (y_wer(1:kk-1)).^3];
elseif typmodelu == 4
    M_ucz = [u_ucz(1:kk-1), (u_ucz(1:kk-1)).^2,(u_ucz(1:kk-1)).^3, (u_ucz(1:kk-1)).^4, y_ucz(1:kk-1), (y_ucz(1:kk-1)).^2, (y_ucz(1:kk-1)).^3, (y_ucz(1:kk-1)).^4];
    M_wer = [u_wer(1:kk-1), (u_wer(1:kk-1)).^2,(u_wer(1:kk-1)).^3, (u_wer(1:kk-1)).^4, y_wer(1:kk-1), (y_wer(1:kk-1)).^2, (y_wer(1:kk-1)).^3, (y_wer(1:kk-1)).^4];
elseif typmodelu == 5
    M_ucz = [u_ucz(1:kk-1), (u_ucz(1:kk-1)).^2,(u_ucz(1:kk-1)).^3, (u_ucz(1:kk-1)).^4, (u_ucz(1:kk-1)).^5, y_ucz(1:kk-1), (y_ucz(1:kk-1)).^2, (y_ucz(1:kk-1)).^3, (y_ucz(1:kk-1)).^4, (y_ucz(1:kk-1)).^5];
    M_wer = [u_wer(1:kk-1), (u_wer(1:kk-1)).^2,(u_wer(1:kk-1)).^3, (u_wer(1:kk-1)).^4, (u_ucz(1:kk-1)).^5, y_wer(1:kk-1), (y_wer(1:kk-1)).^2, (y_wer(1:kk-1)).^3, (y_wer(1:kk-1)).^4, (y_wer(1:kk-1)).^5];
elseif typmodelu == 6    
    M_ucz = [u_ucz(1:kk-1), (u_ucz(1:kk-1)).^2, y_ucz(1:kk-1), (y_ucz(1:kk-1)).^2, u_ucz(1:kk-1).*y_ucz(1:kk-1)];
    M_wer = [u_wer(1:kk-1), (u_wer(1:kk-1)).^2, y_wer(1:kk-1), (y_wer(1:kk-1)).^2, u_wer(1:kk-1).*y_wer(1:kk-1)];

end
global W;
W = M_ucz\y_ucz(2:kk);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Metoda ARX(bez rekurencji)
Y_ARX_ucz(1:typmodelu)=y_ucz(1:typmodelu);
Y_ARX_wer(1:typmodelu)=y_wer(1:typmodelu);

Y_ARX_ucz(1:kk-1) = M_ucz*W;
Y_ARX_wer(1:kk-1) = M_wer*W;

E_ucz_ARX = (Y_ARX_ucz'-y_ucz)'*(Y_ARX_ucz'-y_ucz);
E_wer_ARX = (Y_ARX_wer'-y_wer)'*(Y_ARX_wer'-y_wer);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Metoda OE(z rekurencja)
Y_OE_ucz(1:1)=y_ucz(1:1);
Y_OE_wer(1:1)=y_wer(1:1);

for i=2:kk
    if(typmodelu==1)
    Y_OE_ucz(i)=M_ucz(i-1,1:typmodelu)*W(1:typmodelu)+Y_OE_ucz(i-1)*W(typmodelu+1);
    Y_OE_wer(i)=M_wer(i-1,1:typmodelu)*W(1:typmodelu)+Y_OE_wer(i-1)*W(typmodelu+1);
    
    elseif(typmodelu==2)
    Y_OE_ucz(i)=M_ucz(i-1,1:typmodelu)*W(1:typmodelu)+Y_OE_ucz(i-1)*W(typmodelu+1)+((Y_OE_ucz(i-1))^2)*W(typmodelu+2);
    Y_OE_wer(i)=M_wer(i-1,1:typmodelu)*W(1:typmodelu)+Y_OE_wer(i-1)*W(typmodelu+1)+((Y_OE_wer(i-1))^2)*W(typmodelu+2);
    
    elseif(typmodelu==3)
    Y_OE_ucz(i)=M_ucz(i-1,1:typmodelu)*W(1:typmodelu)+Y_OE_ucz(i-1)*W(typmodelu+1)+((Y_OE_ucz(i-1))^2)*W(typmodelu+2)+((Y_OE_ucz(i-1))^3)*W(typmodelu+3);
    Y_OE_wer(i)=M_wer(i-1,1:typmodelu)*W(1:typmodelu)+Y_OE_wer(i-1)*W(typmodelu+1)+((Y_OE_wer(i-1))^2)*W(typmodelu+2)+((Y_OE_wer(i-1))^3)*W(typmodelu+3);
    
    elseif(typmodelu==4)
    Y_OE_ucz(i)=M_ucz(i-1,1:typmodelu)*W(1:typmodelu)+Y_OE_ucz(i-1)*W(typmodelu+1)+((Y_OE_ucz(i-1))^2)*W(typmodelu+2)+((Y_OE_ucz(i-1))^3)*W(typmodelu+3)+((Y_OE_ucz(i-1))^4)*W(typmodelu+4);
    Y_OE_wer(i)=M_wer(i-1,1:typmodelu)*W(1:typmodelu)+Y_OE_wer(i-1)*W(typmodelu+1)+((Y_OE_wer(i-1))^2)*W(typmodelu+2)+((Y_OE_wer(i-1))^3)*W(typmodelu+3)+((Y_OE_wer(i-1))^4)*W(typmodelu+4);
    
    elseif(typmodelu==5)
    Y_OE_ucz(i)=M_ucz(i-1,1:typmodelu)*W(1:typmodelu)+Y_OE_ucz(i-1)*W(typmodelu+1)+((Y_OE_ucz(i-1))^2)*W(typmodelu+2)+((Y_OE_ucz(i-1))^3)*W(typmodelu+3)+((Y_OE_ucz(i-1))^4)*W(typmodelu+4)+((Y_OE_ucz(i-1))^5)*W(typmodelu+5);
    Y_OE_wer(i)=M_wer(i-1,1:typmodelu)*W(1:typmodelu)+Y_OE_wer(i-1)*W(typmodelu+1)+((Y_OE_wer(i-1))^2)*W(typmodelu+2)+((Y_OE_wer(i-1))^3)*W(typmodelu+3)+((Y_OE_wer(i-1))^4)*W(typmodelu+4)+((Y_OE_ucz(i-1))^5)*W(typmodelu+5);
    
    elseif(typmodelu==6)
    Y_OE_ucz(i)=M_ucz(i-1,1:2)*W(1:2)+Y_OE_ucz(i-1)*W(3)+((Y_OE_ucz(i-1))^2)*W(4)+(u_ucz(i-1)*Y_OE_ucz(i-1))*W(5);
    Y_OE_wer(i)=M_wer(i-1,1:2)*W(1:2)+Y_OE_wer(i-1)*W(3)+((Y_OE_wer(i-1))^2)*W(4)+(u_wer(i-1)*Y_OE_wer(i-1))*W(5);
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
plot(Y_OE_ucz,'--b');
str = sprintf('Model uczacy OE E_u_c_z =%f',E_ucz_OE);
title(str);
xlabel('k');
ylabel('y');
grid on;
hold on;
plot(dane_ucz(:,2),'r');
legend('Y_u_c_z modelu OE','Y dane uczace')
% print('-dpng','modi_2_d_ucz_5','-r400');


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
%print('-dpng','modi_2_d_wer_5','-r400');







