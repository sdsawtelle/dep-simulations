function RBC_complex = findRBC_complex( sigcyt,sigmem,ecyt,emem,a0,a1,f )
% In this script red blood cells are modeled as oblate spheroids with a
% single shell. The detailed mathematical model is found in the journal
% Electrophoresis in the 2008 article "Bovine red blood cell starvation..."
% by Gagnon, Gordon, Sengupta and Chang. Similarly to the E Coli script we
% must calculate a geometry specific depolarization factor (real #) and a
% modified permittivity (complex #)

 w=2*pi*f;
 e0=8.85*10^(-12);

compcyt=complex(ecyt,-1/(w*e0)*sigcyt);
compmem=complex(emem,-1/(w*e0)*sigmem);

RBC_complex=compmem*((a0/a1)^3+2*(compcyt-compmem)/(compcyt+2*compmem))/((a0/a1)^3-(compcyt-compmem)/(compcyt+2*compmem));
end

