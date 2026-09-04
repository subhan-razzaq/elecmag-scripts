% Set 12 Exercise MATLAB Code to verify analytical results
% Subhan Razzaq - 400557958
%
% Capacitance and stored energy of a coaxial capacitor with a nonuniform
% dielectric. The inner radius is 1 mm, the outer radius is 5 mm, the length
% is 1 cm, and the relative permittivity varies with position as
% er = 1000 * rho instead of being constant. A charge of 5 nC sits on the
% inner conductor. The gap is split into 100 cylindrical shells, the energy
% in each shell is worked out from D^2 / (2 * er * eps0), and those are added
% up to get the total energy. Capacitance then follows from C = Q^2 / (2W).

clc; %clear the command line
clear; %remove all previous variables

% initialize variables
eo = 1e-9/(36*pi);          % permittivity of free space
Q = 5e-9;                   % charge on inner plate
rho_inner = 1e-3;           % inner radius (m)
rho_outer = 5e-3;           % outer radius (m)
h = 0.01;                   % length of capacitor (m)

Number_of_rho_steps = 100;  % number of steps in rho direction
drho = (rho_outer - rho_inner) / Number_of_rho_steps; % rho increment

% perform calculations
W=0; % initialize the total energy
for k=1:Number_of_rho_steps
    rho = rho_inner + 0.5*drho + (k-1)*drho;  % current radius
    er = 1e3 * rho;                            % relative permittivity = 10^3 * rho
    Ds = Q / (2*pi*rho*h);                     % D for coaxial (varies with rho)
    dV = rho * drho * 2*pi * h;                % volume element: rho*drho*dphi*dz integrated over phi and z
    dW = 0.5 * Ds^2 * dV / (er * eo);          % energy in this shell
    W = W + dW;                                 % accumulate
end
C=Q^2/(2*W);
fprintf("The capacitance of a capacitor of this kind with 0.01 m length is %e F\n", C);
fprintf("The energy stored in this capacitor is %e J\n", W);