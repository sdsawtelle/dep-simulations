function [Exosome_complex] = findExosome_complex(sigcyt,sigmem,ecyt,emem,a0,a1,f)

% This script models exosomes as single-shelled spherical particles with
% cytoplasmic and membrane properties taken to be those of RBCs, and with
% outer diameter of 150nm. The mathematical model for this is taken from
% the supplementary info 2011 Lab on a Chip paper "Continuous 
% dielectrophoretic bacterial..." by Park,Zhang,Wang and Yang. For such a
% particle the CM factor may still be written as for the homogeneous
% unshelled case, but with the complex particle permittivity given by a modified expression 
% that incorporates the effect of the membrane. It is this modified permittivity
% that is calculated by this script.

    w=2*pi*f;
	e0=8.85*10^(-12);
    
    compcyt=complex(ecyt,-1/(w*e0)*sigcyt);
    compmem=complex(emem,-1/(w*e0)*sigmem);

	Exosome_complex=compmem*((a0/a1)^3+2*(compcyt-compmem)/(compcyt+2*compmem))/((a0/a1)^3-(compcyt-compmem)/(compcyt+2*compmem));

end

