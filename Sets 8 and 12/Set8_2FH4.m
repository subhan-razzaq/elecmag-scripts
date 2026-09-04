% Set 8 Exercise MATLAB Code to verify analytical results
% Subhan Razzaq - 400557958
%
% Energy stored in the field outside a charged sphere. A surface charge
% density of 2 uC/m^2 sits on the sphere r = 1 m, and the region of interest
% is the shell from r = 2 m out to r = 3 m over all of theta and phi. Gauss's
% law gives the field magnitude at each radius, and the energy density
% 0.5 * eps * E^2 is integrated over the shell using a 100 by 100 by 100 grid
% in r, theta and phi. The total stored energy in joules is printed at the
% end.

clc; %clear the command line
clear; %remove all previous variables

ps = 2e-6; %surface charge density
Epsilono=1e-9/(36*pi); %use permitivity of free space
r_upper=3.0;%upper bound of r
r_lower=2.0;%lower bound of r
phi_upper=2*pi;%upper bound of phi
phi_lower=0;%lower bound of phi
theta_upper=pi;%upper bound of theta
theta_lower=0;%lower bound of theta

Number_of_r_Steps=100; %initialize discretization in the r direction
dr=(r_upper-r_lower)/Number_of_r_Steps; %The r increment
Number_of_theta_Steps=100; %initialize the discretization in the theta direction
dtheta=(theta_upper-theta_lower)/Number_of_theta_Steps; %The theta increment
Number_of_phi_Steps=100; %initialize the phi discretization
dphi=(phi_upper-phi_lower)/Number_of_phi_Steps; %The step in the phi direction
WE=0;%the total engery stored in the region

for k=1:Number_of_phi_Steps
    for j=1:Number_of_theta_Steps
        for i=1:Number_of_r_Steps
            r=r_lower+0.5*dr+(i-1)*dr; %radius of current volume element
            theta=theta_lower+0.5*dtheta+(j-1)*dtheta; %z of current volume element
            phi=phi_lower+0.5*dphi+(k-1)*dphi; %phi of current volume element
            EMag=ps/(Epsilono*(r^2));%magnitude of electric field of current volume element
            dV=(r^2)*sin(theta)*dr*dphi*dtheta;%volume of current element
            dWE=0.5*Epsilono*EMag*EMag*dV;%energy stored in current element
            WE=WE+dWE;%get contribution to the total energy
        end %end of the i loop
     end %end of the j loop
end %end of the k loop
fprintf("The energy stored in the region is %.5f J\n", WE);