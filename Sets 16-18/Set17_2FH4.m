% Set 17 Exercise MATLAB Code
% Subhan Razzaq - 400557958
%
% Mutual inductance between two coaxial circular coils. Coil 1 has a radius
% of 1 cm and sits at the origin in the x-y plane, and coil 2 has a radius of
% 4 cm and sits 10 cm above it in a parallel plane. A 1 A current is pushed
% through coil 1, which is split into 100 straight segments, and the
% Biot-Savart law gives the field it produces. That field is then integrated
% over the face of coil 2 using a 100 by 100 polar grid to get the flux
% linking it. Mutual inductance comes out as M = flux / I and is printed in
% henries.

clc; %clear the command window
clear; %clear all variables
mu=4*pi*1e-7;
I=1.0; %current in coil 1

% Coil parameters
a1=0.01; %radius of coil 1 (m)
a2=0.04; %radius of coil 2 (m)
d=0.1;   %separation distance (m)

% Coil 1 is a circular loop of radius a1, centered at origin in the x-y plane
% Coil 2 is a circular loop of radius a2, centered at (0,0,d) in a plane parallel to x-y

% Discretize coil 1 into line segments
Number_of_Segments=100; %number of segments for coil 1
dphi_coil=2*pi/Number_of_Segments; %angle increment

% Build segment start/end points for coil 1
phi_start=zeros(Number_of_Segments,1);
phi_end=zeros(Number_of_Segments,1);
for i=1:Number_of_Segments
    phi_start(i)=(i-1)*dphi_coil;
    phi_end(i)=i*dphi_coil;
end

% Coil 2 surface: circular disk of radius a2 at z=d
% Normal direction is a_z = [0 0 1]
aN=[0 0 1]; %direction normal to coil 2 surface

% Discretize the surface of coil 2 using polar coordinates (rho, phi)
NumberOfRhoSteps=100; %steps in rho direction
NumberOfPhiSteps=100; %steps in phi direction
drho=a2/NumberOfRhoSteps; %rho increment
dphi_area=2*pi/NumberOfPhiSteps; %phi increment for area

flux=0; %total flux through coil 2

for m=1:NumberOfRhoSteps %loop over rho
    rho=(m-0.5)*drho; %rho of current surface element
    dS=rho*drho*dphi_area; %area of current element
    for n=1:NumberOfPhiSteps %loop over phi
        phi_p=(n-0.5)*dphi_area; %phi of current surface element
        xp=rho*cos(phi_p); %x coordinate of surface element on coil 2
        yp=rho*sin(phi_p); %y coordinate of surface element on coil 2
        zp=d; %z coordinate of surface element on coil 2
        Rp=[xp yp zp]; %position of current surface element
        B=[0 0 0]; %initialize magnetic field at this point
        for i=1:Number_of_Segments %loop over coil 1 segments
            % Start and end points of segment on coil 1
            x1=a1*cos(phi_start(i)); y1=a1*sin(phi_start(i)); z1=0;
            x2=a1*cos(phi_end(i));   y2=a1*sin(phi_end(i));   z2=0;
            dL=[(x2-x1) (y2-y1) (z2-z1)]; %vector of differential length
            C=0.5*[(x1+x2) (y1+y2) (z1+z2)]; %center of segment
            R=Rp-C; %vector from segment to observation point
            norm_R=norm(R);
            R_Hat=R/norm_R;
            dH=(I/(4*pi*norm_R*norm_R))*cross(dL,R_Hat);
            B=B+mu*dH;
        end %end of segment loop
        dflux=dS*dot(B,aN); %flux through current surface element
        flux=flux+dflux;
    end %end of phi loop
end %end of rho loop

M=flux/I; %mutual inductance
fprintf('The mutual inductance of the coils separated by a distance of 0.1m is: %e H\n', M);