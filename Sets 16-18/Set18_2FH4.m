% Set 18 Exercise MATLAB Code
% Subhan Razzaq - 400557958
%
% Self-inductance of a toroid with 200 turns, an inner radius of 2.0 cm and
% an outer radius of 2.5 cm, carrying 1 A in air. The helical winding is
% traced out as a single wire with 50 segments per turn, giving 10000
% segments in total. The Biot-Savart law builds up the field at points across
% one circular cross-section of the core, and that field is integrated over
% the cross-section to get the flux through it. Multiplying by the number of
% turns gives the flux linkage, and the inductance follows from L = lambda/I.

clc; %clear the command window
clear; %clear all variables
mu=4*pi*1e-7;
I=1.0; %current in the toroid

% Toroid parameters
NumberOfTurns=200; %number of turns
R_inner=0.02; %inner radius (m)
R_outer=0.025; %outer radius (m)
R_mean=(R_inner+R_outer)/2; %mean radius of toroid
r_cross=(R_outer-R_inner)/2; %radius of circular cross-section

% Discretize the helical winding
% As we go around the toroid (phi: 0 to 2*pi), we also wrap N times around
% the cross-section (theta: 0 to 2*pi*N)
NumberOfSegmentsPerTurn=50; %segments per single turn
Total_Segments=NumberOfTurns*NumberOfSegmentsPerTurn;

x_values=zeros(Total_Segments+1,1);
y_values=zeros(Total_Segments+1,1);
z_values=zeros(Total_Segments+1,1);

for idx=1:(Total_Segments+1)
    t=(idx-1)/Total_Segments; %parameter from 0 to 1
    phi=2*pi*t; %goes around the toroid once
    theta=2*pi*NumberOfTurns*t; %wraps N times around the cross-section
    % Position on toroid surface
    rho_point=R_mean+r_cross*cos(theta);
    z_point=r_cross*sin(theta);
    x_values(idx)=rho_point*cos(phi);
    y_values(idx)=rho_point*sin(phi);
    z_values(idx)=z_point;
end

% Discretize one cross-section of the toroid to compute flux
% Place cross-section at phi=0 (in the x-z plane)
% Normal direction is a_y (the phi-hat direction at phi=0)
NumberOfRSteps=25;
NumberOfThetaSteps=50;
dr=r_cross/NumberOfRSteps;
dtheta_area=2*pi/NumberOfThetaSteps;
aN=[0 1 0];

flux=0; %flux through one cross-section

for m=1:NumberOfRSteps
    r_local=(m-0.5)*dr;
    dS=r_local*dr*dtheta_area;
    for n=1:NumberOfThetaSteps
        theta_local=(n-0.5)*dtheta_area;
        rho_p=R_mean+r_local*cos(theta_local);
        zp=r_local*sin(theta_local);
        xp=rho_p;
        yp=0;
        Rp=[xp yp zp];
        B=[0 0 0];
        for i=1:Total_Segments
            XStart=x_values(i); XEnd=x_values(i+1);
            YStart=y_values(i); YEnd=y_values(i+1);
            ZStart=z_values(i); ZEnd=z_values(i+1);
            dL=[(XEnd-XStart) (YEnd-YStart) (ZEnd-ZStart)];
            C=0.5*[(XStart+XEnd) (YStart+YEnd) (ZStart+ZEnd)];
            R=Rp-C;
            norm_R=norm(R);
            R_Hat=R/norm_R;
            dH=(I/(4*pi*norm_R*norm_R))*cross(dL,R_Hat);
            B=B+mu*dH;
        end
        dflux=dS*dot(B,aN);
        flux=flux+dflux;
    end
end

% Flux linkage: flux through one cross-section multiplied by N
% (each of the N turns links approximately this much flux)
numda=flux*NumberOfTurns;
L=abs(numda/I);
fprintf('The self-inductance of the toroid is: %e H\n', L);