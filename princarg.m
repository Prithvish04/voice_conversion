function phase=princarg(phasein)
two_pi=2*pi;
a=phasein/two_pi;
k=round(a);
phase=phasein-k*two_pi;
end