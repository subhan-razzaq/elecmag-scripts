% Set 4 Exercise MATLAB Code
% Subhan Razzaq - 400557958
%
% Electric field on the axis of a charged disk. A uniform surface charge
% density of 2 uC/m^2 covers the region rho < 1 m in the z = 0 plane, and the
% observation point sits at (0,0,1). The disk is chopped into a 100 by 100
% polar grid, each little patch is treated as a point charge of dQ = D dS,
% and the vector contributions are summed up. The x and y parts should cancel
% out by symmetry, so the answer is expected to point along z. The final
% field vector is printed to check against the analytical result.
clc; %clear the command line
clear; %remove all previous variables

Epsilono=8.854e-12; %use permittivity of air
D=2e-6; %the surface charge density
P=[0 0 1]; %the position of the observation point
E=zeros(1,3); % initialize E=(0 ,0, 0)

Number_of_p_Steps=100;%initialize discretization in the p direction
Number_of_phi_Steps=100;%initialize discretization in %the phi direction

p_lower=0; %the lower boundary of p
p_upper=1; %the upper boundary of p
phi_lower=0; %the lower boundary of phi
phi_upper=2*pi; %the upper boundary of phi

dp=(p_upper - p_lower)/Number_of_p_Steps; %the p increment 
dphi=(phi_upper- phi_lower)/Number_of_phi_Steps; %The phi increment 

% Integration
for j=1: Number_of_phi_Steps
    for i=1: Number_of_p_Steps
        p= p_lower +dp/2+(i-1)*dp; %the p component 
        phi= phi_lower +dphi/2+(j-1)*dphi; %the phi component 
        x = p*cos(phi); % Convert to x coordinate
        y = p*sin(phi); % Convert to y coordinate
        dS=dphi*dp*p; %the area of a single grid
        dQ=D*dS; % the charge on a single grid
        R=P-[x y 0];% vector R 
        RMag=norm(R); % magnitude of vector R
        E=E+(dQ/(4*Epsilono*pi* RMag ^3))*R; % get contribution to the E field
    end
end

% Display Results
fprintf('The electric field for the surface charge density is:\nE = [%.4f  %.4f  %.4f] V/m\n', E(1), E(2), E(3));