% Program nwtraph
% THIS IS A NEWTON-RAPHSON PROGRAM
% We have to solve three nonlinear equations given by
%
%  g1=x1^2-x2^2+x3^2-11=0
%  g2=x1*x2+x2^2-3x3-3=0
%  g3=x1-x1*x3+x2*x3-6=0
%
% Let us assume the initial conditions of x1=x2=x3=1
%
% The Jacobian matrix is
%
% J=[2x1  -2x2     2x3
%    x2   x1+2x2   -3
%    1-x3   x3    -x1+x2];  

clear all

x=[1;1;1];

% The Newton-Raphson iterations starts here

del=1;
indx=0;
while del>1e-6

   g=[x(1)^2-x(2)^2+x(3)^2-11;x(1)*x(2)+x(2)^2-3*x(3)-3;x(1)-x(1)*x(3)+x(2)*x(3)-6];
   J=[2*x(1) -2*x(2) 2*x(3);x(2) x(1)+2*x(2) -3;1-x(3) x(3) -x(1)+x(2)]; 
   delx=-inv(J)*g;
   x=x+delx;

   del=max(abs(g));
   indx=indx+1;

end

'NEWTON-RAPHSON SOLUTION CONVERGES IN ITERATIONS',indx,pause

'FINAL VALUES OF x ARE',x
