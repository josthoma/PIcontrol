% data file for PIspeed_ctrl.mdl application
% SI units
clear all

% loading precomputed wind sequece from 'vntu.mat'  (selection is 4)
load vntu, tt=1:length(vK); tt=tt'; vK=vK';

% aerodynamic parameters 
ro= 1.25, R= 45
cp_m= 0.47, lam_opt= 7      % maximum values of power coefficient, tip speed ratio 
tC_opt= cp_m/lam_opt        % and torque coefficient
Jwt= 9e6,                   % rotor inertia 
sT= 0                       % static (or supplimentary) component torque

% mech. transmission parameters
i=100, eta=0.95             % multiplication ratio and efficiency
ks =0, ds =0                % stiffness and damping
Jd_l = 1, Jd_h = 0.5        % supplimentary inertias of transmission

% SCIG parameters
% 220V / 50Hz
% 157 rad/s
% 6kW
Rs = 0.004, Rr = 0.004      % stator & rotor resistance, inductance etc
Ls = 5.25e-3, Lr = 5.25e-3
Lm = 5.09e-3, p = 2
sgm=1-Lm^2/Lr/Ls, Tr=Lr/Rr
emTmax = 17e3               % maximum torque value
Jg = 90                     % IM inertia

% control law parameters
                            


disp('Parameters loaded!')




