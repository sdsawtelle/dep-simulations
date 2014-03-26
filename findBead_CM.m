function Bead_CM = findBead_CM(Bead_complex, Med_complex)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


Bead_CM = (Bead_complex-Med_complex)/(Bead_complex+2*Med_complex);


end

