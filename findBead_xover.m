function xover = findBead_xover(sigma,radius)
% This script finds the zero-crossing frequency along the CM curve for a
% given solution conductivity and bead radius. If there is no zero-crossing
% it returns the value 0.

		function ReCM=findReCM(f)
            sigmed=sigma;
            emed=78.5;
            [Ecoli_params,RBC_params,Exosome_params,Bead_params]=defineParams();
            Bead_params{3}=radius;
            Med_complex=findMed_complex(sigmed,emed,f);
			Bead_complex=findBead_complex(Bead_params{:},f);
            Bead_CM=findBead_CM(Bead_complex,Med_complex);
            ReCM=real(Bead_CM);
        end
    

    if findReCM(100)*findReCM(10^9)>0
        xover=0;
    else
        xover=fzero(@findReCM,[100,10^9]);
    end
    
end

