function [x, y, radius] = find_param(A,n)
r= mean(A);
Rg = repmat(r, n,1);

U = A - Rg;

syms u v; %% center of the circle

Suu = U(:,1)'*U(:,1);
Suv = U(:,1)'*U(:,2);
Svv = U(:,2)'*U(:,2);
Suuu = sum(U(:,1).^3);
Svvv = sum(U(:,2).^3);
Suvv = sum(U(:,1).*U(:,2).^2);
Svuu = sum(U(:,2).*U(:,1).^2);

eqn1 = u*Suu + v*Suv - 1/2 *(Suuu+Suvv) == 0;
eqn2 = u*Suv + v*Svv - 1/2 *(Svvv+Svuu) == 0;

[A,B] = equationsToMatrix([eqn1, eqn2], [u,v]);
sol = linsolve(A,B);

xysol = sol + r';
x = xysol(1);
y = xysol(2); 

radius = sqrt(sol(1)^2 + sol(2)^2 + (Suu + Svv)/n); %3 ammount of pts

% BETTER PLOT IN MAIN
%angle = linspace (0, 2*pi, 360);
%xx = radius*cos(angle)+x;
%yy = radius*sin(angle)+y;
%plot (xx,yy);
%axis('equal');


end 