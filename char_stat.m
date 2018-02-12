function F=char_stat(y)

global u W;
F=W(1)*u+W(2)*u^2+W(3)*u^3+W(4)*u^4+W(5)*y+W(6)*y^2+W(7)*y^3+W(8)*y^4;