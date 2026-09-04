# 2FH4 MATLAB Scripts

MATLAB code I wrote for the exercise sets in 2FH4 (Electromagnetics). Each set
starts as a problem I solved by hand, and the script is there to check that the
analytical answer actually holds up. The general approach is the same
throughout, which is to chop a region into a lot of small pieces, work out the
contribution of each piece, and add them all together until the sum lines up
with the closed form result.

Everything is plain MATLAB with no toolboxes needed. Run a script and it prints
its answer to the command window.

## Layout

Files are grouped by the writeup they belong to. Each folder has the PDF with
the full analytical work plus the scripts that go with it.

```
Sets 1 and 2/    vectors, volume and surface area
Set 3/           E field from point charges and a line charge
Set 4/           E field from a charged disk
Sets 8 and 12/   stored energy and capacitance
Sets 16-18/      magnetic fields and inductance
```

## What each script does

### Set 1

Basic vector work on two position vectors pointing at (1,2,3) and (3,2,1). It
finds their dot product, the projection of the first onto the second, and the
angle between them in radians and degrees. Short and simple, mostly a warmup
for getting the formulas straight.

### Set 2

Spherical coordinate integration for a closed surface with r running 0 to 2 and
both phi and theta running 45 to 90 degrees. The volume is a triple sum over a
300 cubed grid. The surface area is the harder half, since the region is closed
off by five separate faces and each one needs its own integral. Those are the
spherical cap at r = 2, the two cones at the theta boundaries, and the two flat
sides at the phi boundaries.

### Set 3

Electric field at the origin with three sources acting at once. Two 8 nC point
charges sit above the xy plane and a 4 nC/m line charge runs along a diagonal
segment out at (3.5, 3.5, 0). Coulomb's law handles the point charges directly.
The line gets split into 100000 tiny segments, each treated as a point charge,
and the sum of those approximates the integral. There is a submitted copy of
this one in the same folder, which is identical to the main script.

### Set 4

Field on the axis of a uniformly charged disk. A 2 uC/m^2 sheet covers the unit
disk in the z = 0 plane and the observation point is one meter up the z axis.
The disk is meshed with a 100 by 100 polar grid and every patch contributes a
small Coulomb field. The x and y components cancel out by symmetry, so the
answer should end up pointing straight along z.

### Set 8

Energy stored in the field of a charged sphere. The charge sits on the surface
at r = 1 m and the region of interest is the shell between r = 2 m and r = 3 m.
Gauss's law gives the field at each radius, and the energy density gets
integrated over the shell with a 100 cubed grid in r, theta and phi. This one
lands very close to the hand calculation, within about 0.004 percent.

### Set 12

Coaxial capacitor with a dielectric that is not uniform. The relative
permittivity changes with radius as 1000 times rho, which means the usual
constant permittivity formula does not apply. The gap between the 1 mm and 5 mm
conductors is split into 100 shells, the energy in each shell is computed, and
the total gives the capacitance through C = Q^2 / (2W).

### Set 16

Plots the magnetic field of a 200 turn toroid carrying 5 A. Rather than
assuming the ideal result, the winding is parameterized as one long helix
wrapped around the torus and traced with 20000 straight segments. Biot-Savart
is applied segment by segment at every point of a 20 by 20 observation grid in
the xy plane. The plot comes out as a quiver, and it shows what you would
expect, which is almost nothing outside the core.

### Set 17

Mutual inductance between two coaxial circular coils, 1 cm and 4 cm in radius,
separated by 10 cm. Current runs through the small coil, its field is built up
from 100 segments using Biot-Savart, and that field is integrated over the face
of the large coil to get the linking flux. Mutual inductance is just flux over
current. Comes out around 2.5e-10 H, roughly 1 percent off the analytical
value.

### Set 18

Self-inductance of a 200 turn toroid with a 2.0 cm inner radius and a 2.5 cm
outer radius. The winding is traced as a helix with 50 segments per turn, so
10000 segments in total. The field is integrated over one cross-section of the
core to get the flux through it, then multiplied by the turn count for the flux
linkage. Inductance follows from L = lambda / I. This one runs the longest of
the bunch since it is a triple nested loop over a lot of segments.

## Notes

The numerical answers do not match the analytical ones exactly, and that is
expected. Discretization error is the main reason, and for the toroid problems
there is also the fact that a real helical winding is not quite the idealized
circular path the textbook formula assumes. Bumping up the step counts tightens
things up at the cost of runtime.
