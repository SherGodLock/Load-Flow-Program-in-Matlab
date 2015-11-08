% Program loadflow_gs
% THIS IS A GAUSS-SEIDEL POWER FLOW PROGRAM

clear all

d2r=pi/180;w=100*pi;

% The Y_bus matrix is

[ybus,ych]=ybus;
g=real(ybus);b=imag(ybus);

% The given parameters and initial conditions are

p=[0;-0.96;-0.35;-0.16;0.24];
q=[0;-0.62;-0.14;-0.08;-0.35];
mv=[1.05;1;1;1;1.02];
th=[0;0;0;0;0];
v=[mv(1);mv(2);mv(3);mv(4);mv(5)];

acc=input('Enter the acceleration constant: ');
del=1;indx=0;

% The Gauss-Seidel iterations starts here

while del>1e-6

% P-Q buses  

   for i=2:4

     tmp1=(p(i)-j*q(i))/conj(v(i));
     tmp2=0;
     for k=1:5
        if (i==k)
           tmp2=tmp2+0;
        else
           tmp2=tmp2+ybus(i,k)*v(k);
        end
     end     

     vt=(tmp1-tmp2)/ybus(i,i);
     v(i)=v(i)+acc*(vt-v(i));

 end

% P-V bus

     q5=0;
     for i=1:5
        q5=q5+ybus(5,i)*v(i);
     end
     q5=-imag(conj(v(5))*q5);
     tmp1=(p(5)-j*q5)/conj(v(5));
     tmp2=0;
     for k=1:4
        tmp2=tmp2+ybus(5,k)*v(k);
     end

     vt=(tmp1-tmp2)/ybus(5,5);
     v(5)=abs(v(5))*vt/abs(vt);

  % Calculate P and Q

     for i=1:5
        sm=0;
        for k=1:5
           sm=sm+ybus(i,k)*v(k);
        end
        s(i)=conj(v(i))*sm;
     end

  % The mismatch

     delp=p-real(s)';
     delq=q+imag(s)';

     delpq=[delp(2:5);delq(2:4)];
     del=max(abs(delpq));
     indx=indx+1;
     if indx==1
        pause
     end

 end

 'GS LOAD FLOW CONVERGES IN ITERATIONS',indx,pause
 'FINAL VOLTAGE MAGNITUDES ARE',abs(v)',pause

 'FINAL ANGLES IN DEGREE ARE',angle(v)'/d2r,pause
'THE REAL POWERS IN EACH BUS IN MW ARE',(real(s)+[0 0 0 0 0.24])*100,pause  

'THE REACTIVE POWERS IN EACH BUS IN MVar ARE',(-imag(s)+[0 0 0 0 0.11])*100
