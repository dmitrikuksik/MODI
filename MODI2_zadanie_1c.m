M_ucz = [daneucz(:,1), ones(length(daneucz(:,1)),1)];
M_wer = [danewer(:,1), ones(length(danewer(:,1)),1)];

W = M_ucz\daneucz(:,2);

u_ucz = linspace(-1,1);
y_ucz = W(1)*u_ucz + W(2);

u_lin = linspace(-1,1);
y_lin = W(1)*u_lin + W(2);

figure;
plot(daneucz(:,1),M_ucz*W,'ob');
grid on;
hold on;

plot(daneucz(:,1),daneucz(:,2),'.g');
title('Dane uczace');
xlabel('u');
ylabel('y');

figure;
plot(danewer(:,1),M_wer*W,'ob');
grid on;
hold on;

plot(danewer(:,1),danewer(:,2),'.g');
title('Dane weryfikujace');
xlabel('u');
ylabel('y');

figure;
plot(u_lin,y_lin,'r');
hold on;
plot(u_ucz,y_ucz,'b');