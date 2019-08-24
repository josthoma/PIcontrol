
function [sys,x0,str,ts] = asmcn(t,x,u,flag,Rs,Rr,Ls,Lr,Lm,p)


C=1-Lm^2/(Ls*Lr);   % sigma - leakage factor
D=C*Lr*Ls;          % note that these notations have no relation to state model matrices


A=[-Rs/(C*Ls) Lm^2/D Lm*Rr/D Lm/(C*Ls); Lm^2/D -Rs/(C*Ls) Lm/(C*Ls) Lm*Rr/D; Lm*Rs/D Lm/(C*Lr) -Rr/(C*Lr) 1/C; Lm/(C*Lr) Lm*Rs/D 1/C -Rr/(C*Lr)];


B=[1/(C*Ls) 0 -Lm/D 0; 0 1/(C*Ls) 0 -Lm/D; -Lm/D 0 1/(C*Lr) 0;0 -Lm/D 0 1/(C*Lr)]; 


%       << sfunc >>
% main body
switch flag,
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
  case 1,
    sys=mdlDerivatives(t,x,u,A,B);
  case { 2, 4, 9 },
    sys = [];
  case 3,
    sys=mdlOutputs(t,x,u,p,Lm);
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
% end sfunc body


%       << associated functions >>
% mdlInitializeSizes - Returning the sizes, initial conditions, and sample times for the sfunc
function [sys,x0,str,ts]=mdlInitializeSizes()

sizes = simsizes;

sizes.NumContStates  = 4;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 5;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);
x0  = zeros(4,1);
str = [];
ts  = [0 0];
%=======================
% end mdlInitializeSizes


% mdlDerivatives - returning the derivatives for the continuous states.
function sys=mdlDerivatives(t,x,u,A,B)

% completing the state matrix with  omg_electric & omgs (u(5) & u(6))
A(1,2)=u(4)+A(1,2)*u(3);
A(1,4)=A(1,4)*u(3);
A(2,1)=-u(3)*A(2,1)-u(4);
A(2,3)=-u(3)*A(2,3);
A(3,2)=-u(3)*A(3,2);
A(3,4)=u(4)-u(3)*A(3,4);
A(4,1)=u(3)*A(4,1);
A(4,3)=u(3)*A(4,3)-u(4);

% states derivatives
sys(1:4)=A*x(1:4)+B*[u(1:2)' 0 0]'; 
%===================
% end mdlDerivatives


% mdlUpdate - handle discrete state updates, sample time hits, and major time step requirements.
function sys=mdlUpdate(t,x,u)

sys = [];
%==============
% end mdlUpdate



% mdlOutputs - returning the block outputs.
function sys=mdlOutputs(t,x,u,p,Lm)

% outputs are the 4 states (isd isq ird irq)... 
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);
sys(4)=x(4);

% ... and the electromagnetic torque
sys(5)=(3/2)*p*Lm*(x(3)*x(2)-x(4)*x(1));
%===============
% end mdlOutputs