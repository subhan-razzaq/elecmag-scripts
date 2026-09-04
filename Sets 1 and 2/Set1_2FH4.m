% Set 1 Exercise MATLAB Code
% Subhan Razzaq - 400557958
%
% Vector operations on two position vectors R1 and R2 drawn from the origin
% out to the points P1(1,2,3) and P2(3,2,1). The script works out three
% things by hand style formulas rather than any built in shortcuts. It finds
% the dot product of R1 and R2, then the projection of R1 onto R2, and
% finally the angle between the two vectors in both radians and degrees.
% Everything gets printed at the end so the numbers can be checked against
% the analytical solution.

clc; %  clear the command line
clear; %  remove all previous variables

% Define Points
O = [0 0 0]; %  the origin
P1 = [1 2 3]; %  Point 1
P2 = [3 2 1];  %  Point 2

% Create Vectors 
R1 = P1-O; %  vector R1
R2 = P2-O; %  vector R2

% Dot Product
R1_dot_R2 = dot(R1,R2); %  the dot product of R1 and R2
R2_dot_R2 = dot(R2,R2); %  the dot product of R2 and R2 which is magnitude of R2 squared

% Projection of R1 on R2
Proj_R1_ON_R2 = (R1_dot_R2/R2_dot_R2)*R2; %  the projection of R1 on R2

% Magnitudes
Mag_R1 = norm(R1); %  the magnitude of R1
Mag_R2 = norm(R2); %  the magnitude of R2

% Angle
COS_theta = R1_dot_R2/(Mag_R1*Mag_R2); %  this is the cosine value of the angle between R1 and R2
theta_radians = acos(COS_theta); %  the angle between R1 and R2 in radians
theta_degrees = theta_radians * (180/pi); %  angle between R1 and R2 in degrees

% Display Answers for Verification
fprintf("a) The dot product between R1 and R2 is %f \n",R1_dot_R2); %  Print dot product (part a)
fprintf("b) The projection of R1 on R2 is [%.4f  %.4f  %.4f]\n", Proj_R1_ON_R2(1), Proj_R1_ON_R2(2), Proj_R1_ON_R2(3)); %  Print projection (part b)
fprintf("c) The angle between R1 and R2 in radians is %f \n",theta_radians); %  Print angle in radians (part c)
fprintf("c) The angle between R1 and R2 in degrees is %f \n",theta_degrees); %  Print angle in degrees (part c)