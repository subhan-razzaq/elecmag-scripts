% Set 16 Exercise MATLAB Code
% Subhan Razzaq - 400557958
%
% Plots the magnetic field of a toroid in the x-y plane. The toroid has 200
% turns, carries 5 A, and has an inner radius of 1.5 cm and an outer radius
% of 2.5 cm. The winding is treated as one long helical wire wrapped around
% the torus and is traced out with 20000 short straight segments. The
% Biot-Savart law is applied segment by segment at each point of a 20 by 20
% observation grid covering -4 cm to 4 cm in both x and y. The result is
% drawn with quiver, and the field should come out very small outside the
% core and mostly circulating inside it.

clc; %clear the command window
clear; %clear all variables

NumberOfTurns=200; %Number of turns of the toroid
Rin=0.015; %inner radius of toroid in meters
Rout=0.025; %outer radius of toroid in meters
Rcenter=(Rin+Rout)/2; %center radius of the toroidal path
a=(Rout-Rin)/2; %minor radius of the torus cross section
I=5; %current in Amps

% Parameterize the toroidal winding
% theta goes from 0 to 2*pi (around the big circle)
% For each turn, phi goes from 0 to 2*pi (around the small circle)
% Total parameter: t goes from 0 to NumberOfTurns*2*pi
% theta = t / NumberOfTurns

NumberOfSegments=20000; %total number of segments along the winding
t_min=0;
t_max=NumberOfTurns*2*pi;
t_values=linspace(t_min,t_max,NumberOfSegments+1)';

% theta is the angle around the large circle (toroid axis)
theta_values=t_values/NumberOfTurns;
% phi is the angle around the small circle (cross section)
phi_values=-t_values;

% Toroidal winding coordinates
x_values=(Rcenter+a*cos(phi_values)).*cos(theta_values);
y_values=(Rcenter+a*cos(phi_values)).*sin(theta_values);
z_values=a*sin(phi_values);

% Plot in the x-y plane (z=0)
NumberOfXPlottingPoints=20;
NumberOfYPlottingPoints=20;
PlotXmin=-0.04; %plot region bounds
PlotXmax=0.04;
PlotYmin=-0.04;
PlotYmax=0.04;
PlotStepX=(PlotXmax-PlotXmin)/(NumberOfXPlottingPoints-1);
PlotStepY=(PlotYmax-PlotYmin)/(NumberOfYPlottingPoints-1);
[XData,YData]=meshgrid(PlotXmin:PlotStepX:PlotXmax,PlotYmin:PlotStepY:PlotYmax);

PlotZ=0; %all observation points on the x-y plane
Bx=zeros(NumberOfYPlottingPoints,NumberOfXPlottingPoints);
By=zeros(NumberOfYPlottingPoints,NumberOfXPlottingPoints);

for m=1:NumberOfYPlottingPoints
    for n=1:NumberOfXPlottingPoints
        PlotX=XData(m,n);
        PlotY=YData(m,n);
        Rp=[PlotX PlotY PlotZ];
        for i=1:NumberOfSegments
            XStart=x_values(i);
            XEnd=x_values(i+1);
            YStart=y_values(i);
            YEnd=y_values(i+1);
            ZStart=z_values(i);
            ZEnd=z_values(i+1);
            dl=[(XEnd-XStart) (YEnd-YStart) (ZEnd-ZStart)];
            Rc=0.5*[(XStart+XEnd) (YStart+YEnd) (ZStart+ZEnd)];
            R=Rp-Rc;
            norm_R=norm(R);
            if norm_R < 1e-10
                continue; %skip if observation point is on the wire
            end
            R_Hat=R/norm_R;
            dH=(I/(4*pi*norm_R*norm_R))*cross(dl,R_Hat);
            Bx(m,n)=Bx(m,n)+dH(1,1);
            By(m,n)=By(m,n)+dH(1,2);
        end
    end
end

quiver(XData,YData,Bx,By);
xlabel('x(m)');
ylabel('y(m)');
title('Magnetic field of a toroid in the x-y plane');
axis equal;