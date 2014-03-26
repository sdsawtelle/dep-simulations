function Med_complex = findMed_complex(sigmed,emed,f)
% calculates the complex permittivity of the medium

    w=2*pi*f;
    e0=8.85*10^(-12);

 
    Med_complex=complex(emed,-1/(w*e0)*sigmed);
    
end

