% Set 2 Exercise MATLAB Code
% Subhan Razzaq - 400557958
%
% Numerical integration in spherical coordinates for the closed surface
% bounded by r = 0 to r = 2, phi from 45 to 90 degrees, and theta from 45 to
% 90 degrees. The volume is found by summing r^2 sin(theta) dr dphi dtheta
% over a 300 by 300 by 300 grid. The total surface area is then built up from
% the five faces that close the region off, which are the spherical cap at
% r = 2, the two conical faces at theta = 45 and theta = 90 degrees, and the
% two flat sides at the constant phi boundaries. Both results get printed for
% comparison with the analytical answer.

clc; %  clear the command line
clear; %  remove all previous variables

% Initialization
V = 0; %  initialize volume of the closed surface to 0
S1 = 0; %  initialize the area of S1 to 0
S2 = 0; %  initialize the area of S2 to 0
S3 = 0; %  initialize the area of S3 to 0
S4 = 0; %  initialize the area of S4 to 0
S5 = 0; %  initialize the area of S5 to 0
r = 0; %  initialize rho to the its lower boundary
phi = pi/4; %  initialize phi to the its lower boundary
theta = pi/4; %  initialize theta to the its lower boundary

% Discretization Setup
Number_of_r_Steps = 300; %  initialize the r discretization
Number_of_phi_Steps = 300; %  initialize the phi discretization
Number_of_theta_Steps = 300; %  initialize the theta discretization
dr = (2 - r)/Number_of_r_Steps; %  The r increment step size
dphi = (pi/2 - phi)/Number_of_phi_Steps; %  The phi increment step size
dtheta = (pi/2 - theta)/Number_of_theta_Steps; %  The theta increment step size

% The following routine calculates the volume of the enclosed surface
for k=1:Number_of_theta_Steps
    for j=1:Number_of_r_Steps
        for i=1:Number_of_phi_Steps
            V = V + (r^2)*sin(theta)*dphi*dr*dtheta; %  add contribution to the volume
        end
    r = r + dr; %  r increases each time when theta has been traveled from its lower boundary to its upper boundary
    end
    r = 0; %  reset r to its lower boundary
    theta = theta + dtheta; %  Increment theta
end

% SURFACE AREA ROUTINE

theta = pi/4; %  reset theta to lower boundary
% The following routine calculates the area of S1
r = 2; %  radius of S1
for k=1:Number_of_theta_Steps
    for i=1:Number_of_phi_Steps
        S1 = S1 + (r^2)*sin(theta)*dphi*dtheta; %  get contribution to the the area of S1
    end
    theta = theta + dtheta; %  increment theta
end

% The following routing calculate the area of S2
r = 0; %  reset r to it's lower boundary
theta = pi/2; %  theta angle of S2
for j=1:Number_of_r_Steps
    for i=1:Number_of_phi_Steps
        S2 = S2 + r*sin(theta)*dphi*dr; %  get contribution to the the area of S3
    end
r = r + dr; %  increment r
end

% The following routing calculate the area of S3
r = 0; %  reset r to it's lower boundary
theta = pi/4; %  theta angle of S3
for j=1:Number_of_r_Steps
    for i=1:Number_of_phi_Steps
        S3 = S3 + r*sin(theta)*dphi*dr; %  get contribution to the the area of S3
    end
r = r + dr; %  increment r
end

% The following routing calculate the area of S4 and S5
r = 0; %  reset r to it's lower boundary
theta = pi/4; %  theta angle of S3
for j=1:Number_of_r_Steps
    for k=1:Number_of_theta_Steps
        S4 = S4 + r*dtheta*dr; %  get contribution to the the area of S3
    end
r = r + dr; %  increment r
end
S5 = S4; %  The surface area is equal as the rotate for phi does not change the area

% Sum up Surface Areas
S= S1 + S2 + S3 + S4 + S5; %  The area of the enclosed surface

% Display Answers
fprintf("a) The enclosed volume of the closed surface is %f \n", V);
fprintf("b) The area of the closed surface is %f \n", S);

