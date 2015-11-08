% Function ybus
% THIS IS THE PROGRAM FOR CREATING Ybus MATRIX.

function [yb,ych]=ybus

 % The line impedances are

 zz=[0 0.02+0.1i 0 0 0.05+0.25i
    0.02+0.1i 0 0.04+0.2i 0 0.05+0.25i
    0 0.04+0.2i 0 0.05+0.25i 0.08+0.4i
    0 0 0.05+0.25i 0 0.1+0.5i
    0.05+0.25i 0.05+0.25i 0.08+0.4i 0.1+0.5i 0];

 % The line chargings are

 ych=j*[0 0.03 0 0 0.02
    0.03 0 0.025 0 0.020
    0 0.025 0 0.02 0.01
    0  0 0.02 0 0.075
    0.02 0.02 0.01 0.075 0];

  
  % The Ybus matrix is formed here

  for i=1:5
     for j=1:5
        if zz(i,j) == 0
           yb(i,j)=0;
        else
           yb(i,j)=-1/zz(i,j);
        end
     end
  end

  for i=1:5
     ysum=0;
     csum=0;
     for j=1:5
      ysum=ysum+yb(i,j);
      csum=csum+ych(i,j);
   end
   yb(i,i)=csum-ysum;
end
