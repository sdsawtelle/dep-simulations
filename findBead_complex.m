function Bead_complex = findBead_complex(Ks,ebead,a,f)

%   For polystyrene beads the bulk conductivity is negligible compared to the surface conductivity.
% 	The surface conductivity depends on the functionalization, but also more generally on the 
% 	conductivity of the medium due to differences in bound charge layers (this dependence is usually
% 	ignored). Bead conductivity is given by sigbead=2*Ks/a. A more detailed
% 	explanation is found in the supplementary info 2011 Lab on a Chip paper "Continuous 
%   dielectrophoretic bacterial..." by Park,Zhang,Wang and Yang.2

    w=2*pi*f;
	e0=8.85*10^(-12);

    Bead_complex=complex(ebead,-(2*Ks/a)/(w*e0));

end

